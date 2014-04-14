//
//  SportViewController.h
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMImageCache.h"

@interface SportViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,
                                                  QueryManagerDelegate>
{
    UITableView *sportTV;
}

@property(nonatomic, retain)UITableView *sportTV;

@end
