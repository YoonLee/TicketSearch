//
//  CustomTableViewCell.m
//  TicketMaster
//
//  Created by Yoon Lee on 4/2/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
@synthesize titleLabel, subtitleLabel;
@synthesize dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGRect frame = self.frame;
        frame.size.width = 210;
        frame.size.height = 18;
        frame.origin.x = 100;
        frame.origin.y = 5;
        titleLabel = [[MarqueeLabel alloc] initWithFrame:frame];
        [self.titleLabel setBackgroundColor:CCLEAR()];
        [self.titleLabel setRate:200];
        [self.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
        [self.titleLabel setHoldScrolling:YES];
        UIFont *font = [UIFont fontWithName:@"Avenir-Medium" size:15];
        [self.titleLabel setFont:font];
        [self.contentView addSubview:self.
         titleLabel];
        
        frame.origin.y = 22;
        subtitleLabel = [[MarqueeLabel alloc] initWithFrame:frame];
        font = [UIFont fontWithName:@"Avenir-Medium" size:12];
        [self.subtitleLabel setFont:font];
        [self.subtitleLabel setBackgroundColor:CCLEAR()];
        [self.subtitleLabel setHoldScrolling:YES];
        [self.subtitleLabel setTextColor:CDGRAY()];
        [self.contentView addSubview:self.subtitleLabel];
        
        frame.origin.y = 40;
        font = [UIFont fontWithName:@"AvenirNext-Bold" size:12];
        dateLabel = [[UILabel alloc] initWithFrame:frame];
        [self.dateLabel setBackgroundColor:CCLEAR()];
        [self.dateLabel setFont:font];
        [self.dateLabel setTextColor:RGB(27, 85, 149)];
        [self.contentView addSubview:self.
         dateLabel];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [self addGestureRecognizer:longPress];
        [longPress release];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) handleLongPress: (UIGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
        [self.titleLabel setHoldScrolling:NO];
    else if (longPress.state == UIGestureRecognizerStateEnded || longPress.state == UIGestureRecognizerStateCancelled)
        [self.titleLabel setHoldScrolling:YES];
}

- (void)dealloc
{
    [super dealloc];
    
    [titleLabel release];
    titleLabel = nil;
    
    [subtitleLabel release];
    subtitleLabel = nil;
    
    [dateLabel release];
    dateLabel = nil;
}

@end
