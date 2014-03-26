//
//  UpdateEventTableViewCell.m
//  hackfsu
//
//  Created by Michelle Rojas on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)layoutIfNeeded
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.title setFont:BOLD16];
    
    [self.updateView setTextColor:DARK_GREEN];
    
    [self.updateView setFont:FONT14];
    
//    [self.updateView setBackgroundColor:GRAY];
    
//    [self.updateView.layer setCornerRadius:5.0f];
}

@end
