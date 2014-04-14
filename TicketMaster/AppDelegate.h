//
//  AppDelegate.h
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    
    RootViewController *rootVC;
}

@property(nonatomic, retain)UIWindow *window;
@property(nonatomic, retain)RootViewController *rootVC;

@end
