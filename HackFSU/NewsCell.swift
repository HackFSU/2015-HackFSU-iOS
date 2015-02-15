//
//  NewsCell.swift
//  HackFSU
//
//  Created by Logan Isitt on 2/7/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var updateView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup
    
    func setup() {
        // TODO:
        
    }
}