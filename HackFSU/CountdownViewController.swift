//
//  CountdownViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 1/31/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarItem()
        
        self.title = "Countdown"
        self.navigationItem.title = self.title
    }
}