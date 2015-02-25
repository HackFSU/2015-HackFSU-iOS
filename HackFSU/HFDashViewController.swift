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
        
        var attrs = [NSForegroundColorAttributeName: UIColor.HFColor.White, NSFontAttributeName: UIFont.HFFont.CountdownFont]
        var spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        countdownBar = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Bordered, target: self, action: "showCountdownView")
        
        countdownBar.setTitleTextAttributes(attrs, forState: UIControlState.Normal)
        
        self.setToolbarItems([spacer, countdownBar, spacer], animated: false)
        
        // Countdown
        destinationDate = NSDate(timeIntervalSince1970: 1427025600) // TODO: Pull from Parse
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "countdownBarUpdate", userInfo: nil, repeats: true)
        
        // View Controllers
        var storyboard = UIStoryboard(name: "Main", bundle: nil)

        self.updatesViewController  = storyboard.instantiateViewControllerWithIdentifier("HFUpdatesViewController") as HFUpdatesViewController
        self.scheduleViewController = storyboard.instantiateViewControllerWithIdentifier("HFScheduleViewController")as HFScheduleViewController
        self.mapsViewController     = storyboard.instantiateViewControllerWithIdentifier("HFMapsViewController") as HFMapsViewController
        self.sponsorsViewController = storyboard.instantiateViewControllerWithIdentifier("HFSponsorsViewController") as HFSponsorsViewController
        //        self.countdownViewController = storyboard.instantiateViewControllerWithIdentifier("CountdownViewController") as CountdownViewController
    }
    
    // MARK: - Countdown
    func countdownBarUpdate() {
        
        destinationDate.timeAgoSinceDate(NSDate(), numericDates: true, numericTimes: true)
        
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
        
        var d = NSDate().dateByAddingTimeInterval(-500)
        
        self.countdownBar.title = NSString(format: "%d:%d:%d.%@", h, m, s, n.substringToIndex(advance(n.startIndex, 1)))
    }
    
    func showCountdownView() {
        
    }
    
    // MARK: - RGPageViewController Data Source
    func numberOfPagesForViewController(pageViewController: RGPageViewController) -> Int {
        return menu.count
    }
    
    func tabViewForPageAtIndex(pageViewController: RGPageViewController, index: Int) -> UIView {
       
        let label: UILabel = UILabel()
        
        label.text = self.menu.objectAtIndex(index) as? String
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
        return 30.0
    }
}