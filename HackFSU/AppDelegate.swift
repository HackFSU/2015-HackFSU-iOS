//
//  AppDelegate.swift
//  HackFSU
//
//  Created by Logan Isitt on 1/28/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let PARSE_APP_ID = "jeoeVa2Nz3VLmrnWpAknbWKZADXHbmQltPSlU8mX"
    let PARSE_CLIENT_KEY = "nMdA9eBEQU5l2KNWvvWJ3gIDN70M4yi5hBkdyxs2"
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Initialize Parse
        Parse.setApplicationId(PARSE_APP_ID, clientKey: PARSE_CLIENT_KEY)
        
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newsViewController = storyboard.instantiateViewControllerWithIdentifier("NewsViewController") as NewsViewController
        let sidebarViewController = storyboard.instantiateViewControllerWithIdentifier("SidebarViewController") as SidebarViewController
        
        let newsNav: UINavigationController = UINavigationController(rootViewController: newsViewController)
        
        sidebarViewController.newsViewController = newsNav
        
        let slideMenuController = SlideMenuController(mainViewController:newsNav, leftMenuViewController: sidebarViewController)
        
        //self.window?.rootViewController = slideMenuController
        
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        
        
        // MARK: - Parse
        
        Parse.setApplicationId("jeoeVa2Nz3VLmrnWpAknbWKZADXHbmQltPSlU8mX", clientKey: "nMdA9eBEQU5l2KNWvvWJ3gIDN70M4yi5hBkdyxs2")
//        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

