//
//  UpdateEventTableViewCell.m
//  hackfsu
//
//  Created by Michelle Rojas on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
  
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.title setFont:FONT10];

    [self.title setFont:[UIFont systemFontOfSize:16.0f]];
    
    [self.title setTextColor:LIGHT_GREEN];

    [self.updateView setBackgroundColor:GRAY];
    
    [self.updateView.layer setCornerRadius:5.0f];
    // Configure the view for the selected state
}

@end
