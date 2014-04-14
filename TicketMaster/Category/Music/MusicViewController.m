//
//  MusicViewController.m
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import "MusicViewController.h"
#import "CustomTableViewCell.h"
@interface MusicViewController()
@property(nonatomic, retain)NSArray *contents;
- (NSString*)getDateFormat:(NSString*)dateStr;
@end
@implementation MusicViewController
@synthesize musicTV;
@synthesize contents;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:CWHITE()];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [self setAutomaticallyAdjustsScrollViewInsets:YES];
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self setTitle:@"Music"];
    
    self.musicTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.musicTV setDelegate:self];
    [self.musicTV setDataSource:self];
    [self.musicTV setRowHeight:60];
    [self.view addSubview:self.musicTV];
    
    QueryManager *qm = [[[QueryManager alloc] init] autorelease];
    [qm shakeEQ:@"music&per_page=100"];
    [qm setDelegate:self];
    [qm executeQuery];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect frame = self.view.bounds;
    frame.size.height = frame.size.height - 64;
    [self.musicTV setFrame:frame];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contents.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CustomTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *single = [contents objectAtIndex:indexPath.row];
    NSString *title = [single objectForKey:@"title"];
    [cell.titleLabel setText:title];
    
    NSDictionary *venue = [single objectForKey:@"venue"];
    [cell.subtitleLabel setText:[venue objectForKey:@"name"]];
    
    NSString *dateStr = [single objectForKey:@"datetime_local"];
    dateStr = [self getDateFormat:dateStr];
    [cell.dateLabel setText:dateStr];
    
    UIImage *placeholder = [UIImage imageNamed:@"Placeholder.png"];
    [cell.imageView setImage:placeholder];
    // check away
    NSArray *performers = [single objectForKey:@"performers"];
    int homeIndex = 0;
    if ([[[performers objectAtIndex:0] objectForKey:@"away_team"] boolValue])
        homeIndex = 1;
    
    NSString *hugeImgURLStr = [[performers objectAtIndex:homeIndex] objectForKey:@"image"];
    if (![[NSNull null] isEqual:hugeImgURLStr]) {
        NSURL *url = [NSURL URLWithString:hugeImgURLStr];
        [cell.imageView setClipsToBounds:YES];
        [cell.imageView setImageWithURL:url placeholder:placeholder];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MusicCellIdentifier";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceivedResponseFromQueryManager:(QueryManager*)qm withResponse:(id)response
{
    NSDictionary *object = (NSDictionary*)response;
    self.contents = [object objectForKey:@"events"];
    DLog(@"%@", [contents description]);
    [self.musicTV reloadData];
}

- (NSString*)getDateFormat:(NSString*)dateStr
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    // 2014-04-03T19:05:00
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    // converts the date format as we wish
    [dateFormatter setDateFormat:@"EEE, MMM/dd/yyyy hh:mm a"];
    NSString *releaseDate = [dateFormatter stringFromDate:date];
    
    return releaseDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [super dealloc];
    
    [musicTV release];
    musicTV = nil;
}

@end
