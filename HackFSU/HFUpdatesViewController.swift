//
//  HFUpdatesViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 2/22/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFUpdatesViewController: PFQueryTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parseClassName = "Updates"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 100
        
        self.loadObjects(0, clear: true)
        self.title = "News"
        self.navigationItem.title = self.title
        

    }
    
    // MARK: - Parse
    
    override func objectsDidLoad(error: NSError!) {
        super.objectsDidLoad(error)
        // TODO:
        
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
        //
        var cell: PFTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as PFTableViewCell
        
        cell.textLabel?.text = object.valueForKey("title") as? String
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 49.0
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // TODO:
        return 44.0
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // TODO:
    }
}