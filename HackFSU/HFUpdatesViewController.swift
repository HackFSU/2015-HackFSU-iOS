import UIKit

class HFUpdatesViewController: PFQueryTableViewController {
    
    var formatter = NSDateFormatter()

    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.parseClassName = "Updates"
        self.loadingViewEnabled = false
        self.paginationEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadObjects()
        
        self.refreshControl?.tintColor = UIColor.HFColor.White
        
        tableView.backgroundColor = UIColor.HFColor.Blue
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        formatter.dateStyle = NSDateFormatterStyle.NoStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        formatter.doesRelativeDateFormatting = true
    }
    
    // MARK: - Parse
    
    override func queryForTable() -> PFQuery! {
        return PFQuery(className: self.parseClassName).orderByDescending("updatedAt")
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
}