//
//  HFDashViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 2/22/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFDashViewController: RGPageViewController, RGPageViewControllerDataSource, RGPageViewControllerDelegate {
    
    var menu: NSArray = ["Updates", "Schedule", "Maps", "Sponsors"]
    
    var updatesViewController: UIViewController!
    var scheduleViewController: UIViewController!
    var mapsViewController: UIViewController!
    var sponsorsViewController: UIViewController!
    var countdownViewController: UIViewController!
    
    var countdownBar: UIBarButtonItem!
    var timer: NSTimer!
    var endTime: NSDate!
    
    override var tabbarStyle: RGTabbarStyle {
        get {
            return .Solid
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "HackFSU"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.HFColor.Green
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.toolbar.barTintColor = self.navigationController?.navigationBar.barTintColor
        
        var spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        countdownBar = UIBarButtonItem(title: "36:00:00", style: UIBarButtonItemStyle.Done, target: self, action: "")
        countdownBar.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        
        self.setToolbarItems([spacer, countdownBar, spacer], animated: true)
        
        
        // Setting up view controllers
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "%Y-%m-%d %H:%M:%S %z"
        endTime = NSDate() // dateFormatter.dateFromString("2015-03-20 12:00:00 -0500")
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "countdownBarUpdate", userInfo: nil, repeats: true)
        
        
        self.updatesViewController  = storyboard.instantiateViewControllerWithIdentifier("HFUpdatesViewController") as HFUpdatesViewController
        self.scheduleViewController = storyboard.instantiateViewControllerWithIdentifier("HFScheduleViewController") as HFScheduleViewController
        let mapsViewController      = storyboard.instantiateViewControllerWithIdentifier("HFMapsViewController") as HFMapsViewController
        self.mapsViewController = UINavigationController(rootViewController: mapsViewController)
        self.sponsorsViewController = storyboard.instantiateViewControllerWithIdentifier("HFSponsorsViewController") as HFSponsorsViewController
//        self.countdownViewController = storyboard.instantiateViewControllerWithIdentifier("CountdownViewController") as CountdownViewController
        
        self.datasource = self
        self.delegate = self
    }
    
    // MARK: - Countdown 
    func countdownBarUpdate() {
    
        var currentTime = NSDate()
        
        var interval = endTime.timeIntervalSince1970 - currentTime.timeIntervalSince1970
        
        var seconds = interval % 60;
        var minutes = (interval / 60) % 60;
        var hours = interval / 3600;
        
        self.countdownBar.title = NSString(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // MARK: - RGPageViewController Data Source
    func numberOfPagesForViewController(pageViewController: RGPageViewController) -> Int {
        return menu.count
    }
    
    func tabViewForPageAtIndex(pageViewController: RGPageViewController, index: Int) -> UIView {
        let title: String = self.menu.objectAtIndex(index) as String
        let tabView: RGTabBarItem = RGTabBarItem(frame: CGRectMake(0.0, 0.0, self.view.bounds.width / 6.0, 49.0), text: title, image: UIImage(named: "Grid"), color: nil)
        
        let label: UILabel = UILabel()
        
        label.text = title
        label.textColor = UIColor.whiteColor()
        
        label.sizeToFit()
        
        return label
    }
    
    func viewControllerForPageAtIndex(pageViewController: RGPageViewController, index: Int) -> UIViewController? {
        
        switch index {
        case 0:
            return self.updatesViewController
        case 1:
            return self.scheduleViewController
        case 2:
            return self.mapsViewController
        case 3:
            return self.sponsorsViewController
        default:
            return self.updatesViewController
        }
    }
    
    // MARK: - RGPageViewController Delegate
    func widthForTabAtIndex(index: Int) -> CGFloat {
        return self.view.bounds.width / 4.0
    }
    
    func tintColorForTabBar() -> UIColor? {
        return self.navigationController?.navigationBar.barTintColor
    }
    
    func colorForTabIndicator() -> UIColor {
        return UIColor.HFColor.Blue
    }
    func widthOrHeightForIndicator() -> CGFloat {
        return 4.0
    }
    func heightForTabbar() -> CGFloat {
        // default height of UITabBar is 49px
        return 49.0
    }
}