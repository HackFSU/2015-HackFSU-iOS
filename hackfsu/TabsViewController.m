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
    
    self.delegate = self;
    
    [self setSelectedIndex:3];
    
    ExtraViewController *EVC = (ExtraViewController *) [self selectedViewController];
    [EVC setDelegate:self];
    
    UIBarButtonItem *signOut = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out"
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(signOutUser)];
    

    float width = 120.0f;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(width/2 - 15, 19, 30, 37)];
    [self.pageControl setNumberOfPages:3];
    [self.pageControl setCurrentPage:1];
    
    [v addSubview:self.pageControl];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setText:[self.tabBar selectedItem].title];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    
    [v addSubview:self.titleLabel];
    
    self.navigationItem.titleView = v;
    
    [signOut setTintColor:DARK_GREEN];
    [signOut setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[FONT12] forKeys:@[NSFontAttributeName]]
                           forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:signOut];
    
    
    UITabBarItem *tbItem = [UITabBarItem appearance];
    [tbItem setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[FONT10, [UIColor blackColor]] forKeys:@[NSFontAttributeName, NSBackgroundColorAttributeName]]
                           forState:UIControlStateNormal];
    
    
//    UIImage *tabBackground = [[UIImage imageNamed:@"tabBG.png"]
//                               stretchableImageWithLeftCapWidth:0.0f topCapHeight:0.0f];
//    
//    [[UITabBar appearance] setSelectionIndicatorImage:tabBackground];
    
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [self setSelectedIndex:0];
    [self.titleLabel setText:[self selectedViewController].title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"didSelectItem");
    [self.navigationItem setTitle:item.title];
    
    if (![item.title isEqualToString:@"Extra"])
    {
        [self.titleLabel setText:item.title];
        [self.pageControl setHidden:YES];
    }
    else
    {
        [self.pageControl setHidden:NO];
    }

    NSLog(@"%f %f", item.selectedImage.size.width, item.selectedImage.size.height);
}

-(void) signOutUser
{
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void) pageChangedWithTitle: (NSString *) s andNumber:(int) n
{
    NSLog(@"pageChangedWithTitle");
    [self.titleLabel setText:s];
    [self.pageControl setCurrentPage:n];
}

@end