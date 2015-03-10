//
//  HFMapCell.swift
//  HackFSU
//
//  Created by Logan Isitt on 3/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFMapCell: PFTableViewCell {
    
    @IBOutlet var mapImgView: PFImageView!
    
    var imgFile: PFFile {
        get {
            return self.imgFile
        }
        set(file) {
            mapImgView.file = file
            mapImgView.loadInBackground(nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.HFColor.White
        mapImgView.frame = CGRectInset(self.bounds, 16, 16)
    }
}
