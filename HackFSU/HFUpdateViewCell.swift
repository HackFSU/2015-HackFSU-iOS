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
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        var layer = CALayer()
        layer.frame = CGRectMake(buffer, rect.size.height - height, rect.size.width - (buffer * 2), height)
        layer.backgroundColor = UIColor.HFColor.Blue.CGColor
        
        self.layer.addSublayer(layer)
    }
}