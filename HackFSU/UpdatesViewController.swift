//
//  UpdatesViewController.swift
//  HackFSU
//
//  Created by Trevor Helms on 2/22/15.
//  Copyright (c) 2015 HackFSU. All rights reserved.
//

import UIKit

class UpdatesViewController: UITableViewController {
    
    var updates = [Update]()
    var sections = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var query = PFQuery(className: "Updates")
        query.orderByDescending("updatedAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                NSLog("Successfully retrieved \(objects.count) objects.")
                
                if let updateObjects = objects as? [PFObject] {
                    for update in updateObjects {
                        NSLog(update.objectId)
                        var date = update.createdAt
//                        var dateFormatter = NSDateFormatter()
//                        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
//                        var when = dateFormatter.stringFromDate(date)
                        var when: String = ""
                        var title = update.objectForKey("title") as String
                        var subtitle = update.objectForKey("subtitle") as String
                        
                        var now = NSDate().timeIntervalSince1970
                        var time = now - date.timeIntervalSince1970
                        var secondsAgo = time
                        
                        if secondsAgo >= 10 {
                            when = "\(UInt(floor(secondsAgo))) seconds ago"
                        }
                        else {
                            when = "A few seconds ago"
                        }
                        
                        var minutesAgo = secondsAgo / 60
                        
                        if minutesAgo >= 1 {
                            when = "\(UInt(floor(minutesAgo))) minutes ago"
                        }
                        
                        var hoursAgo = minutesAgo / 60
                        
                        if hoursAgo >= 1 {
                            when = "\(UInt(floor(hoursAgo))) hours ago"
                        }
                        
                        var daysAgo = hoursAgo / 24
                        
                        if daysAgo >= 1 {
                            when = "\(UInt(floor(daysAgo))) days ago"
                        }
                        
                        
                        var u = Update(when: when, title: title, subtitle: subtitle)
                        NSLog(u.title)
                        self.updates.append(u)
                    }
                }
                
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return updates.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UpdateCell", forIndexPath: indexPath) as UITableViewCell
        let update = updates[self.sections] as Update
        
        cell.textLabel?.text = update.title
        cell.detailTextLabel?.text = update.subtitle
        cell.detailTextLabel?.numberOfLines = 0         // Hack to display multiple lines
        self.sections++
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let update = updates[section] as Update
        return update.when
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
