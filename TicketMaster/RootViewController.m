//
//  RootViewController.m
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import "RootViewController.h"
#import "SportViewController.h"
#import "MusicViewController.h"
#import "TheatreViewController.h"
#import "CheckoutViewController.h"
#import "UserSettingViewController.h"

@interface RootViewController()
@property(nonatomic, retain)NSArray *controllers;
- (void)addViewControllers:(UIScrollView*)_scrollView;
@end

@implementation RootViewController
@synthesize controllers;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:CWHITE()];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [self setAutomaticallyAdjustsScrollViewInsets:YES];
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self setTitle:@"Sports"];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:RGB(20, 80, 151)];
    [self.navigationController.navigationBar setTintColor:CWHITE()];
    
    NSMutableDictionary *navBarTextAttributes = [NSMutableDictionary dictionaryWithCapacity:1];
    [navBarTextAttributes setObject:[UIFont fontWithName:@"Avenir-Medium" size:22] forKey:NSFontAttributeName];
    [navBarTextAttributes setObject:CWHITE() forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:navBarTextAttributes];

    BButton *calButton = [BButton awesomeButtonWithOnlyIcon:FAIconCalendar type:BButtonTypeDefault];
    [calButton setColor:CWHITE()];
    CGRect frame = calButton.frame;
    frame.size = CGSizeMake(30, 30);
    [calButton setFrame:frame];
    [calButton addTarget:self action:@selector(calendarRequest:) forControlEvents:UIControlEventTouchUpInside];
    BButton *userButton = [BButton awesomeButtonWithOnlyIcon:FAIconUser type:BButtonTypeDefault];
    [userButton setColor:CWHITE()];
    frame = userButton.frame;
    frame.size = CGSizeMake(30, 30);
    [userButton setFrame:frame];
    [userButton addTarget:self action:@selector(userRequest:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *calItem = [[UIBarButtonItem alloc] initWithCustomView:calButton];
    UIBarButtonItem *userItem = [[UIBarButtonItem alloc] initWithCustomView:userButton];
    [self.navigationItem setLeftBarButtonItem:userItem];
    [self.navigationItem setRightBarButtonItem:calItem];
    [calItem release];
    calItem = nil;
    [userItem release];
    userItem = nil;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView setDelegate:self];
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * 3, scrollView.frame.size.height)];
    [scrollView setPagingEnabled:YES];
    [self addViewControllers:scrollView];
    [self.view addSubview:scrollView];
    [scrollView release];
    scrollView = nil;
}

- (void)addViewControllers:(UIScrollView*)scrollView
{
    [self setControllers:@[[[SportViewController alloc] init], [[TheatreViewController alloc] init], [[MusicViewController alloc] init]]];
    
    for (int i = 0; i < self.controllers.count; i ++) {
        UIViewController *vc = [self.controllers objectAtIndex:i];
        CGRect frame = vc.view.frame;
        frame.origin.x = i * self.view.bounds.size.width;
        [vc.view setFrame:frame];
        [vc viewDidAppear:YES];
        [scrollView addSubview:vc.view];
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)_scrollView
{
    int page = [self getPageNumber:_scrollView];
    
    // Update the page control
    if ([self isValidPageNumber:page]) {
        UIViewController *vc = [self.controllers objectAtIndex:page];
        [self setTitle:vc.title];
        // patch not cool but nothing else could do
        [vc viewDidAppear:YES];
    }
}

- (BOOL)isValidPageNumber:(NSInteger)page
{
    return [self.controllers count] > page && page >= 0;
}

- (int)getPageNumber:(UIScrollView*)_scrollView
{
    // First, determine which page is currently visible
    CGFloat pageWidth = self.view.bounds.size.width;
    NSInteger page = (NSInteger)floor((_scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    return page;
}

- (void)calendarRequest:(BButton*)btn
{

}

- (void)userRequest:(BButton*)btn
{
    UserSettingViewController *preference = [[UserSettingViewController alloc] init];
    [preference setPushedFromStrTitle:self.title];
    [self setTitle:@""];
    [self.navigationController pushViewController:preference animated:YES];
    [preference release];
    preference = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [super dealloc];
    
    [controllers release];
    controllers = nil;
}

@end
