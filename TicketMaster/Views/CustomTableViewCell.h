//
//  CustomTableViewCell.h
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"

@interface CustomTableViewCell : UITableViewCell

@property(nonatomic, retain)MarqueeLabel *titleLabel, *subtitleLabel;
@property(nonatomic, retain)UILabel *dateLabel;

@end
