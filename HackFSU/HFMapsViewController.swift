//
//  MapsViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 1/31/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFMapsViewController: UIViewController {
    
    @IBOutlet var countdown: HFCountdownView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = HFCountdownView(frame: self.view.frame) as HFCountdownView
        (self.view as HFCountdownView).animateProgressView()
    }
}