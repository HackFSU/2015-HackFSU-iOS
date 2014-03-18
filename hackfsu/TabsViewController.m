//
//  TabsViewController.m
//  hackfsu
//
//  Created by Matt O'Hagan on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "TabsViewController.h"

@implementation TabsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *signOut = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleDone target:self action:@selector(signOutUser)];
    
    [self.navigationItem setLeftBarButtonItem:signOut];
    
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

@end