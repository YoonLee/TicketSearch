//
//  MusicViewController.h
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,
                                                  QueryManagerDelegate>
{
    UITableView *musicTV;
}

@property(nonatomic, retain)UITableView *musicTV;

@end
