//
//  TabsViewController.m
//  hackfsu
//
//  Created by Matt O'Hagan on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "TabsViewController.h"
#import "FeedViewController.h"

@implementation TabsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    
    UIBarButtonItem *signOut = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out"
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(signOutUser)];
    
    [signOut setTintColor:DARK_GREEN];
    [signOut setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[FONT12] forKeys:@[NSFontAttributeName]]
                           forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:signOut];
    
    
    UITabBarItem *tbItem = [UITabBarItem appearance];
    [tbItem setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[FONT10, [UIColor blackColor]] forKeys:@[NSFontAttributeName, NSBackgroundColorAttributeName]]
                           forState:UIControlStateNormal];
    
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [self setSelectedIndex:0];
    [self.navigationItem setTitle:[self selectedViewController].title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self.navigationItem setTitle:item.title];
}

-(void) signOutUser
{
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void) refresh
{
    NSLog(@"%@", self.tabBarController.selectedViewController.title);
    [(FeedViewController *)[self.tabBarController.viewControllers objectAtIndex:0] loadObjects:0 clear:YES];
}

@end