//
//  TabsViewController.h
//  hackfsu
//
//  Created by Matt O'Hagan on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExtraViewController.h"

@interface TabsViewController : UITabBarController <ExtraViewControllerDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIPageControl *pageControl;

@end
