//
//  ViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 1/28/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

enum MenuView: Int {
    case News = 0
    case Schedule
    case Maps
    case Sponsors
    case Countdown
}

class SidebarViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var menu = ["News", "Schedule", "Maps", "Sponsors", "Countdown"]

    var newsViewController: UIViewController!
    var scheduleViewController: UIViewController!
    var mapsViewController: UIViewController!
    var sponsorsViewController: UIViewController!
    var countdownViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Name the view
        self.title = "HackFSU"
        self.navigationItem.title = self.title
        
        // Styles nav bar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 34.0/255.0, green: 48.0/255.0, blue: 96.0/255.0, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Lato-Regular", size: 32)!]
        
        // Stops empty cells from showing
//        tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        
        // Setting up view controllers
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newsViewController = storyboard.instantiateViewControllerWithIdentifier("NewsViewController") as NewsViewController
        self.newsViewController = UINavigationController(rootViewController: newsViewController)
        
        let scheduleViewController = storyboard.instantiateViewControllerWithIdentifier("ScheduleViewController") as ScheduleViewController
        self.scheduleViewController = UINavigationController(rootViewController: scheduleViewController)
        
        let mapsViewController = storyboard.instantiateViewControllerWithIdentifier("MapsViewController") as MapsViewController
        self.mapsViewController = UINavigationController(rootViewController: mapsViewController)
        
        let sponsorsViewController = storyboard.instantiateViewControllerWithIdentifier("SponsorsViewController") as SponsorsViewController
        self.sponsorsViewController = UINavigationController(rootViewController: sponsorsViewController)
        
        let countdownViewController = storyboard.instantiateViewControllerWithIdentifier("CountdownViewController") as CountdownViewController
        self.countdownViewController = UINavigationController(rootViewController: countdownViewController)
    }
    
//    // MARK: - Table View Data Source
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
//        
//        cell.textLabel?.text = menu[indexPath.row]
////        cell.imageView?.image = UIImage(named: menu[indexPath.row].lowercaseString)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
//        cell.backgroundColor = UIColor.clearColor()
//        cell.imageView?.tintColor = UIColor.whiteColor()
//        
//        return cell
//    }
//    
//    // MARK: - Table View Delegate
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if let menu = MenuView(rawValue: indexPath.item) {
//            self.changeViewController(menu)
//        }
//    }
//    
    func changeViewController(menu: MenuView) {
        switch menu {
        case .News:
            self.slideMenuController()?.changeMainViewController(self.newsViewController, close: true)
        case .Schedule:
            self.slideMenuController()?.changeMainViewController(self.scheduleViewController, close: true)
            break
        case .Maps:
            self.slideMenuController()?.changeMainViewController(self.mapsViewController, close: true)
            break
        case .Sponsors:
            self.slideMenuController()?.changeMainViewController(self.sponsorsViewController, close: true)
            break
        case .Countdown:
            self.slideMenuController()?.changeMainViewController(self.countdownViewController, close: true)
            break
        default:
            break
        }
    }
    
    // MARK: - Collection View Data Source
    
    // MARK: - Collection View Data Source
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell: MenuViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as MenuViewCell

        cell.nameLabel.text = menu[indexPath.row]
        cell.imageView?.image = UIImage(named: menu[indexPath.row].lowercaseString)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cell.imageView?.tintColor = UIColor.whiteColor()
        
        let row: CGFloat =  CGFloat(indexPath.row)
        let alpha: CGFloat = row * 0.15
        
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
        
        return cell
    }

    // MARK: - Collection View Delegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let menu = MenuView(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
    // MARK: - Collection View Delegate Flow Layout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var width = UIScreen.mainScreen().bounds.size.height / 5
        
        return CGSize(width: width, height: width)
    }
}

