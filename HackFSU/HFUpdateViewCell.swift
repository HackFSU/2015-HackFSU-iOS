//
//  HFUpdateViewCell.swift
//  HackFSU
//
//  Created by Logan Isitt on 2/24/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFUpdateViewCell: PFTableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var subtitle: UILabel!
    @IBOutlet var time: UILabel!
    
    var height = CGFloat(0.5)
    var buffer = CGFloat(8)
    
    var separator: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        
        separator = CALayer()
        layer.addSublayer(separator)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        separator.frame = CGRectMake(buffer, rect.size.height - height, rect.size.width - (buffer * 2), height)
        separator.backgroundColor = UIColor.HFColor.Blue.CGColor
    }
}