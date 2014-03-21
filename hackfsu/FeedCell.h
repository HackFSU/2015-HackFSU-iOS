//
//  UpdateEventTableViewCell.h
//  hackfsu
//
//  Created by Michelle Rojas on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *title;               // event update
@property (strong,nonatomic) IBOutlet UITextView *updateView;      // details about event


@end

