//
//  ExtraViewController.m
//  hackfsu
//
//  Created by Logan Isitt on 3/21/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "ExtraViewController.h"

#import "AwardsViewController.h"
#import "SponsorsViewController.h"
#import "MapViewController.h"

@implementation ExtraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    AwardsViewController *AVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AwardsViewController"];
    viewControllers = @[AVC];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    SponsorsViewController *SVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SponsorsViewController"];
    MapViewController *MVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];

    viewControllers = @[AVC, SVC, MVC];

    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateHeader:self.pageViewController];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    int vcIndex = (int)[viewControllers indexOfObject:viewController];
    if (vcIndex > 0) {
        return [viewControllers objectAtIndex:vcIndex-1];
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    int vcIndex = (int)[viewControllers indexOfObject:viewController];
    if (vcIndex < 3-1) {
        return [viewControllers objectAtIndex:vcIndex+1];
    }
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    [self updateHeader:pageViewController];
}

-(void) updateHeader: (UIPageViewController *) pageViewController
{
    NSLog(@"updateHeader");
    UIViewController *currentVC = pageViewController.viewControllers[0];
    int c = (int)[viewControllers indexOfObject:currentVC];
    NSString *str;
    switch (c)
    {
        case 0: str = @"Awards"; break;
        case 1: str = @"Sponsors"; break;
        case 2: str = @"Map"; break;
        default: break;
    }
    [self.delegate pageChangedWithTitle:str andNumber:(int)[viewControllers indexOfObject:currentVC]];
}

@end