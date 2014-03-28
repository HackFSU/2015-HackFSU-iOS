//
//  AppDelegate.m
//  hackfsu
//
//  Created by Logan Isitt on 2/7/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"4NDzxeC8KxdZi4Kyok7QfGhtS27GuHfntNh9ZSfL"
                  clientKey:@"u4akfWEzsLpXunJEkGFlkA8xvkhEwvN8hwvw4Atq"];

    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObjectsFromArray:
     @[@"Schedule", @"Updates",@"Awards"]
                                            forKey:@"channels"];
    [currentInstallation saveInBackground];
    
    // Register for push notifications
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setTintColor:GRAY];
    [tabBar setSelectedImageTintColor:DARK_GREEN];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[FONT22, WHITE] forKeys:@[NSFontAttributeName, NSForegroundColorAttributeName]]];
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    [GAI sharedInstance].dispatchInterval = 20;
    
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-49442322-1"];

    [[GAI sharedInstance] setTrackUncaughtExceptions:YES];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}

@end