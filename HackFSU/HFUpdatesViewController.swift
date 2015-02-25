//
//  HFUpdatesViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 2/22/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFUpdatesViewController: PFQueryTableViewController {
    
    var formatter = NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parseClassName = "Updates"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        
        self.loadObjects()
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.backgroundColor = UIColor.HFColor.LightBlue
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor.HFColor.Blue
        
        formatter.dateStyle = NSDateFormatterStyle.NoStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        formatter.doesRelativeDateFormatting = true
    }
    
    // MARK: - Parse
    
    override func objectsDidLoad(error: NSError!) {
        super.objectsDidLoad(error)
        
        self.tableView.reloadData()
    }
    
    override func objectsWillLoad() {
        super.objectsWillLoad()
        // TODO:
    }
    
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: self.parseClassName)
        
        query.orderByDescending("updatedAt")
        
        return query
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        var cell: HFUpdateViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as HFUpdateViewCell
        
        cell.title?.text = object.valueForKey("title") as? String
        
        cell.subtitle?.text = object.valueForKey("subtitle") as? String
        cell.subtitle?.numberOfLines = 0
        
        cell.time?.text = object.updatedAt.timeAgoSinceNow()
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
}