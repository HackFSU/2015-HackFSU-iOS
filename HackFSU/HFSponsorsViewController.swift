import UIKit

class HFSponsorsViewController: PFQueryTableViewController {
    
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
        self.parseClassName = "Sponsors"
        self.loadingViewEnabled = false
        self.paginationEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.HFColor.Blue
        self.view.backgroundColor = UIColor.HFColor.Blue
        
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.refreshControl?.tintColor = UIColor.HFColor.White
    }
    
    // MARK: - Parse
    
    override func queryForTable() -> PFQuery! {
        return PFQuery(className: self.parseClassName).orderByAscending("rank")
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        var cell: HFSponsorCell = tableView.dequeueReusableCellWithIdentifier("Cell") as HFSponsorCell
        
        cell.imgFile = object.objectForKey("image") as PFFile
        
        return cell
    }
}