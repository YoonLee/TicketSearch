//
//  UserSettingViewController.m
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import "UserSettingViewController.h"

@implementation UserSettingViewController
@synthesize pushedFromStrTitle;
@synthesize settingTV;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:CWHITE()];
    [self setTitle:@"Settings"];
    
    self.settingTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.settingTV setDelegate:self];
    [self.settingTV setDataSource:self];
    [self.settingTV setRowHeight:60];
    [self.view addSubview:self.settingTV];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect frame = self.view.bounds;
    frame.size.height = frame.size.height - 64;
    [self.settingTV setFrame:frame];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.topViewController setTitle:self.pushedFromStrTitle];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MusicCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [super dealloc];
    
    [settingTV release];
    settingTV = nil;
}

@end
