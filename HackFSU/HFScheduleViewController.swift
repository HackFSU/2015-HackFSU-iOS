import UIKit

class HFScheduleViewController: PFQueryTableViewController {
    
    var formatter: NSDateFormatter!
    
    var dates: NSArray!
    var sorted: [[PFObject]]!
    
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
    
    func setup() {
        sorted = []

        self.parseClassName = "Schedule"
        self.loadingViewEnabled = false
        self.paginationEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sorted = []

        self.loadObjects()
        
        self.refreshControl?.tintColor = UIColor.HFColor.White
        
        tableView.backgroundColor = UIColor.HFColor.Blue
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
                
        tableView.sectionHeaderHeight = 20
        tableView.sectionFooterHeight = 0
        
        formatter = NSDateFormatter()
        
        formatter.dateStyle = NSDateFormatterStyle.NoStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeZone = NSTimeZone.localTimeZone()
    }
    
    // MARK: - Parse
    
    override func queryForTable() -> PFQuery! {
        return PFQuery(className: self.parseClassName).orderByAscending("startTime")
    }
    
    override func objectsDidLoad(error: NSError!) {
    
        sorted = []
        
        dates = (objects as NSArray).valueForKeyPath("@distinctUnionOfObjects.startTime.dateWithoutTime") as NSArray
        
        dates = dates.sortedArrayUsingDescriptors([NSSortDescriptor(key: "self", ascending: true)])
        
        for d in dates {
            var inner: [PFObject] = []
            for obj in objects {
                if ( (obj.valueForKeyPath("startTime.dateWithoutTime") as NSDate) == (d as NSDate)) {
                    inner.append(obj as PFObject)
                }
            }
            sorted.append(inner)
        }
        tableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = UIView(frame: CGRectMake(0, 0, tableView.bounds.width, tableView.sectionHeaderHeight))
        var title = UILabel(frame: CGRectMake(8, 0, header.bounds.width - 16.0, header.bounds.height))
        header.addSubview(title)
        
        header.backgroundColor = UIColor.HFColor.Blue
        
        formatter.dateFormat = "EEEE, MMMM d"
        let hStr = formatter.stringFromDate(dates[section] as NSDate)
        formatter.dateStyle = NSDateFormatterStyle.NoStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        
        title.text = hStr
        title.textColor = UIColor.HFColor.White
        title.textAlignment = NSTextAlignment.Left
        
        title.font = UIFont.HFFont.H5
        
        return header
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sorted.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sorted[section].count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        var cell: HFEventCell = tableView.dequeueReusableCellWithIdentifier("Cell") as HFEventCell
        
        let obj = sorted[indexPath.section][indexPath.row]
        
        let sDate = obj.objectForKey("startTime") as NSDate
        let eDate = obj.objectForKey("endTime") as NSDate
        
        
        let startStr = formatter.stringFromDate(sDate)
        let endStr = formatter.stringFromDate(eDate)
        
        cell.startTime.text = startStr
        cell.endTime.text = endStr
        
        if eDate.timeIntervalSinceNow < sDate.timeIntervalSinceNow {
            cell.endTime.text = ""
        }
        
        cell.eventName.text = obj.objectForKey("title") as? String
        cell.eventLoc.text = obj.objectForKey("subtitle") as? String
        
        return cell
    }
}