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
        
        self.loadObjects()
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        var formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.NoStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        formatter.doesRelativeDateFormatting = true
        
        let update = (objects[section] as PFObject).updatedAt
        
        return formatter.stringFromDate(NSDate())
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        var object: PFObject = objects[indexPath.section] as PFObject
        
        cell.textLabel?.text = object.valueForKey("title") as? String
        cell.detailTextLabel?.text = object.valueForKey("subtitle") as? String
        cell.detailTextLabel?.font = UIFont(name: "UniSansThinCAPS", size: 15)
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30.0
        }
        return 0
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // TODO:
        var tView = UITextView(frame: CGRectMake(0.0, 0.0, self.view.bounds.size.width, 44.0))
        var tString = (objects[indexPath.section] as PFObject).valueForKey("subtitle") as String
        
        return self.heightForTextView(tView, containingSting: tString)
    }
    func heightForTextView(textView: UITextView, containingSting: String) -> CGFloat {
        var horizontalPadding = CGFloat(14.0)
        var verticalPadding = CGFloat(44.0)
        var widthOfTextView = textView.contentSize.width - horizontalPadding
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByCharWrapping
        paragraphStyle.alignment = NSTextAlignment.Left

        var attrs = [NSFontAttributeName: UIFont(name: "Times New Roman", size: 15)!, NSParagraphStyleAttributeName : paragraphStyle]
        
        var size: CGSize = (containingSting as NSString).boundingRectWithSize(CGSizeMake(widthOfTextView, 999999), options: NSStringDrawingOptions.UsesFontLeading, attributes: attrs, context: nil).size
        
        return size.height + verticalPadding
    }
}