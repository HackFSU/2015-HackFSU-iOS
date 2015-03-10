//
//  HFScheduleCell.swift
//  HackFSU
//
//  Created by Logan Isitt on 3/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFEventCell: PFTableViewCell {
    
    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventLoc: UILabel!
    @IBOutlet var eventDesc: UILabel!
    @IBOutlet var startTime: UILabel!
    @IBOutlet var endTime: UILabel!
    
    var accent: CALayer!
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init()
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup 
    func setup() {
        accent = CALayer()
        accent.backgroundColor = UIColor.HFColor.Blue.CGColor
        layer.addSublayer(accent)
    }
    
    override func layoutSubviews() {
        startTime.font = UIFont.HFFont.smallFont
        
        endTime.font = UIFont.HFFont.smallFont
        endTime.textColor = UIColor.grayColor()
        
        eventName.font = UIFont.HFFont.H5
        
        eventLoc.font = UIFont.HFFont.smallFont
        eventLoc.textColor = UIColor.grayColor()
        
        let xS = CGRectGetMaxX(startTime.frame) + 4
        let xE = CGRectGetMinX(eventName.frame) - 8
        let w = xE - xS
        
        accent.frame = CGRectMake(xS, 4, w, self.bounds.height - 8)
    }
}
