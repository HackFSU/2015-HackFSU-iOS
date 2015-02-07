//
//  SponsorsViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 1/31/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class SponsorsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarItem()
        
        self.title = "Sponsors"
        self.navigationItem.title = self.title
    }
    
    //: MARK - Table View Data Source 
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tier \(section + 1)"
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}