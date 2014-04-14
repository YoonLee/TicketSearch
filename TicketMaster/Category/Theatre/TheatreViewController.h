//
//  TheatreViewController.h
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMImageCache.h"

@interface TheatreViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,
                                                    QueryManagerDelegate>
{
    UITableView *teatreTV;
}

@property(nonatomic, retain)UITableView *teatreTV;

@end
