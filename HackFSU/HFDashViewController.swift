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
    var destinationDate: NSDate!
    
    override var tabbarStyle: RGTabbarStyle {
        get {
            return .Solid
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "HackFSU"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.HFColor.Green
        
        var imgHeader = UIImageView(image: UIImage(named: "logo-nav"))
        imgHeader.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40)
        imgHeader.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = imgHeader
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.toolbar.barTintColor = self.navigationController?.navigationBar.barTintColor
        
        var spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        countdownBar = UIBarButtonItem(title: "36 hours 00 minutes 00 seconds", style: UIBarButtonItemStyle.Done, target: self, action: "")
        countdownBar.setTitleTextAttributes([   NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "UniSansHeavyCAPS", size: 30)!], forState: UIControlState.Normal)
   
        self.setToolbarItems([spacer, countdownBar, spacer], animated: true)
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        destinationDate = NSDate(timeIntervalSince1970: 1427025600)
        
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
    
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        NSCalendarUnit.CalendarUnitMonth
        var units = NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond | NSCalendarUnit.CalendarUnitNanosecond

        var nowComponents = calendar?.component(units, fromDate: NSDate())
        var thenComponents = calendar?.component(units, fromDate: self.destinationDate)

        var difComponents = calendar?.components(units, fromDate: NSDate(), toDate: self.destinationDate, options: NSCalendarOptions.MatchFirst)
        
        let h = difComponents!.hour as Int
        let m = difComponents!.minute as Int
        let s = difComponents!.second as Int
        let n = "\(difComponents!.nanosecond as Int)"
        
        self.countdownBar.title = NSString(format: "%d:%d:%d.%@", h, m, s, n.substringToIndex(advance(n.startIndex, 1))) //"\(h):\(m):\(s).\(n.substringToIndex(advance(n.startIndex, 1)))"
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
        label.font = UIFont(name: "UniSansHeavyCAPS", size: 15)
        
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
        return 30.0
    }
}