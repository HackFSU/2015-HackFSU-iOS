//
//  TimelineCell.m
//  hackfsu
//
//  Created by Logan Isitt on 2/7/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "TimelineCell.h"

@implementation TimelineCell

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
//        CALayer *line = [CALayer layer];
//        line.frame = CGRectMake(25.0f, 0, 5.0f, self.frame.size.height);
//        line.cornerRadius = 2.5f;
//        line.backgroundColor = [BLACK CGColor];
//        
//        [self.layer insertSublayer:line atIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.timeLabel setFont:FONT12];
    
    [self.timeLabel setTextColor:[UIColor whiteColor]];
    [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.timeLabel setBackgroundColor:LIGHT_GREEN];
    [self.timeLabel.layer setCornerRadius:5.0f];
    
    [self.descriptionView setFont:FONT14];
    [self.descriptionView setBackgroundColor:GRAY];
    [self.descriptionView.layer setCornerRadius:5.0f];
}

-(void)layoutIfNeeded
{
    CGPoint cen = self.timeLabel.center;

    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(cen.x - 2.5f, 0, 5.0f, self.frame.size.height);
    line.backgroundColor = [BLACK CGColor];
    
    [self.layer insertSublayer:line atIndex:0];
}

@end
