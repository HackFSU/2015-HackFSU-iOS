//
//  NewsViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 1/31/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController
{
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        self.parseClassName = "Updates"
//        self.pullToRefreshEnabled = true
//        self.paginationEnabled = true
//        self.objectsPerPage = 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarItem()
        
//        self.loadObjects(0, clear: true)
        self.title = "News"
        self.navigationItem.title = self.title
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 177.0/255.0, blue: 173.0/255.0, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Lato-Regular", size: 32)!]
    }
    
    // MARK: - Parse 
    
//    override func objectsDidLoad(error: NSError!) {
//        super.objectsDidLoad(error)
//        // TODO:
//    }
//    
//    override func objectsWillLoad() {
//        super.objectsWillLoad()
//        // TODO:
//    }
//    
//    override func queryForTable() -> PFQuery! {
//        var query = PFQuery(className: self.parseClassName)
//        
//        if self.pullToRefreshEnabled {
//            query.cachePolicy = kPFCachePolicyNetworkOnly
//        }
//        
//        if self.objects.count == 0 {
//            query.cachePolicy = kPFCachePolicyCacheThenNetwork
//        }
//        
//        query.orderByDescending("updatedAt")
//        
//        return query
//    }
    
    // MARK: - Table View Data Source
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> UITableViewCell! {
        // 
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        return cell
    }
    
    // MARK: Table View Delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // TODO:
        
        return 60
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // TODO:
    }
}