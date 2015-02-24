//
//  Update.swift
//  HackFSU
//
//  Created by Trevor Helms on 2/22/15.
//  Copyright (c) 2015 HackFSU. All rights reserved.
//

import UIKit

class Update: NSObject {
    var when: String
    var title: String
    var subtitle: String
    
    init(when: String, title: String, subtitle: String) {
        self.when = when
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}
