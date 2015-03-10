//
//  HFSponsorCell.swift
//  HackFSU
//
//  Created by Logan Isitt on 3/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFSponsorCell: PFTableViewCell {
    
    @IBOutlet var spnsrImgView: PFImageView!
    
    var imgFile: PFFile {
        get {
            return self.imgFile
        }
        set(file) {
            spnsrImgView.file = file
            spnsrImgView.loadInBackground(nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.HFColor.White
        spnsrImgView.frame = CGRectInset(self.bounds, 16, 16)
    }
}
