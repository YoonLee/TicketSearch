//
//  UserSettingViewController.h
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSettingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *settingTV;
}
@property(nonatomic, retain)UITableView *settingTV;
@property(nonatomic, retain)NSString *pushedFromStrTitle;

@end
