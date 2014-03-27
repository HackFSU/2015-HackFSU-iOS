//
//  SponsorsViewController.m
//  hackfsu
//
//  Created by Logan Isitt on 3/21/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "SponsorsViewController.h"

@implementation SponsorsViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.title = @"Sponsors";
        self.screenName = self.title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end