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
    
    var countdownBar: UIBarButtonItem!
    var timer: NSTimer!
    var destinationDate: NSDate!
    
    var startDate: NSDate!
    var endDate: NSDate!
    
    override var tabbarStyle: RGTabbarStyle {
        get {
            return .Solid
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datasource = self
        self.delegate = self
        
        // Nav Bar
        self.title = "HackFSU"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.HFColor.Green
        
        var imgHeader = UIImageView(image: UIImage(named: "logo-nav"))
        imgHeader.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40)
        imgHeader.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = imgHeader
        
        // Toolbar
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.toolbar.barTintColor = UIColor.HFColor.Green
        
        var attrs = [NSForegroundColorAttributeName: UIColor.HFColor.White, NSFontAttributeName: UIFont.HFFont.H3!]
        var spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        countdownBar = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Bordered, target: self, action: "showCountdownView")
        
        countdownBar.setTitleTextAttributes(attrs, forState: UIControlState.Normal)
        
        self.setToolbarItems([spacer, countdownBar, spacer], animated: false)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "showCountdownView")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        
        self.navigationController?.toolbar.addGestureRecognizer(swipeUp)
        
        // Countdown
        var countdownQuery = PFQuery(className: "Schedule")
        countdownQuery.orderByAscending("startTime")
        countdownQuery.whereKey("key", equalTo: Int(1))
        countdownQuery.findObjectsInBackgroundWithTarget(self, selector: "countdownPrep:Error:")
        
        // View Controllers
        var storyboard = UIStoryboard(name: "Main", bundle: nil)

        self.updatesViewController  = storyboard.instantiateViewControllerWithIdentifier("HFUpdatesViewController") as HFUpdatesViewController
        self.scheduleViewController = storyboard.instantiateViewControllerWithIdentifier("HFScheduleViewController")as HFScheduleViewController
        self.mapsViewController     = storyboard.instantiateViewControllerWithIdentifier("HFMapsViewController") as HFMapsViewController
        self.sponsorsViewController = storyboard.instantiateViewControllerWithIdentifier("HFSponsorsViewController") as HFSponsorsViewController
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    // MARK: - Notifications 
    func reloadViewControllers() {
        (self.updatesViewController as HFUpdatesViewController).loadObjects()
    }
    
    // MARK: - Countdown
    func countdownPrep(objects: NSArray, Error error: NSError) {
        
        startDate   = objects.firstObject?.valueForKey("startTime") as NSDate
        endDate     = objects.lastObject?.valueForKey("startTime") as NSDate
        
//        ((countdownViewController as HFCountdownViewController).view as HFCountdownView).startDate = startDate
//        ((countdownViewController as HFCountdownViewController).view as HFCountdownView).endDate = endDate
        
        if (NSDate().isLaterThanOrEqualTo(startDate)) {
            destinationDate = endDate
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countdownBarUpdate", userInfo: nil, repeats: true)
        }
        else {
            self.countdownBar.title = "30 Hours"
        }
    }
    
    func countdownBarUpdate() {
        
        if (NSDate().isLaterThan(endDate)) {
            self.countdownBar.title = "Hacking ended!"
            timer.invalidate()
            return
        }
        
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        NSCalendarUnit.CalendarUnitMonth
        var units = NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond | NSCalendarUnit.CalendarUnitNanosecond
        
        var nowComponents = calendar?.component(units, fromDate: NSDate())
        var thenComponents = calendar?.component(units, fromDate: self.destinationDate)
        
        var difComponents = calendar?.components(units, fromDate: NSDate(), toDate: self.destinationDate, options: NSCalendarOptions.MatchFirst)
        
        let h = difComponents!.hour as Int
        let m = difComponents!.minute as Int
//        let s = difComponents!.second as Int
//        let n = "\(difComponents!.nanosecond as Int)"
        
        self.countdownBar.title = NSString(format: "%d Hours & %d Minutes", h, m)
    }
    
    func showCountdownView() {
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var countdownViewController = storyboard.instantiateViewControllerWithIdentifier("HFCountdownViewController") as HFCountdownViewController
        
        ((countdownViewController as HFCountdownViewController).view as HFCountdownView).startDate = startDate
        ((countdownViewController as HFCountdownViewController).view as HFCountdownView).endDate = endDate
        
        self.navigationController?.presentViewController(countdownViewController, animated: true, completion: nil)
    }
    
    // MARK: - RGPageViewController Data Source
    
    func numberOfPagesForViewController(pageViewController: RGPageViewController) -> Int {
        return menu.count
    }
    
    func tabViewForPageAtIndex(pageViewController: RGPageViewController, index: Int) -> UIView {
       
        let label: UILabel = UILabel()
        
        label.text = self.menu.objectAtIndex(index) as? String
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.HFFont.H5
        
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
        return 2.0
    }
    
    func heightForTabbar() -> CGFloat {
        return 30.0
    }
}