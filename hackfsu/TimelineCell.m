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

    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.timeLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    [self.timeLabel setTextColor:[UIColor whiteColor]];
    [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.timeLabel setBackgroundColor:LIGHT_GREEN];
    [self.timeLabel.layer setCornerRadius:5.0f];
    
    [self.descriptionView setBackgroundColor:GRAY];
    [self.descriptionView.layer setCornerRadius:5.0f];
}

@end
