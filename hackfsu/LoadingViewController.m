//
//  LoadingViewController.m
//  hackfsu
//
//  Created by Matt O'Hagan on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "LoadingViewController.h"

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.screenName = @"Login Screen";

    [self performSelector:@selector(popGoesTheWeasel) withObject:nil afterDelay:2.0];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.greetingLbl setText:[NSString stringWithFormat:@"Hello, %@", self.name]];
}

-(void) popGoesTheWeasel
{
    [self performSegueWithIdentifier:@"toTabs" sender:self];
}

@end