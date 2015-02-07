//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func prefersStatusBarHidden() -> Bool {
        #if DEBUG
            return false
            #else
            return false
        #endif
    }
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "menu")!)
//        self.addRightBarButtonWithImage(UIImage(named: "")!)
        self.slideMenuController()?.removeLeftGestures()
//        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
//        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
//        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
//        self.slideMenuController()?.removeRightGestures()
    }
}