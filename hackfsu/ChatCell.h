//
//  ChatCell.h
//  hackfsu
//
//  Created by Logan Isitt on 3/18/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *timeStamp;
@property (strong, nonatomic) IBOutlet UITextView *content;

@end
