import UIKit

class HFMapsViewController: PFQueryTableViewController {
        
    // MARK: - Initialization
    override init!(style: UITableViewStyle, className: String!) {
        var sorted: [[PFObject]] = [[]]
        super.init(style: style, className: className)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        var sorted: [[PFObject]] = [[]]
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    func setup() {
        self.parseClassName = "Maps"
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
        return PFQuery(className: self.parseClassName).orderByAscending("floor")
    }

    
    // MARK: - UITableView Data Source
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        var cell: HFMapCell = tableView.dequeueReusableCellWithIdentifier("Cell") as HFMapCell
        
        cell.imgFile = object.objectForKey("Image") as PFFile

        return cell
    }
}