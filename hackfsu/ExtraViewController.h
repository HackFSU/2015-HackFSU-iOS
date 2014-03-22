//
//  ExtraViewController.h
//  hackfsu
//
//  Created by Logan Isitt on 3/21/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExtraViewController;
@protocol ExtraViewControllerDelegate <NSObject>
-(void) pageChangedWithTitle: (NSString *) s andNumber:(int) n;
@end

@interface ExtraViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    NSString *cur;
    NSArray *viewControllers;
}

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic, assign) IBOutlet id<ExtraViewControllerDelegate> delegate;

@end
