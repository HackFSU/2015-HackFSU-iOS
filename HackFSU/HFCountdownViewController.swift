//
//  HFCountdownViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 2/24/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFCountdownViewController: UIViewController {
    
    @IBOutlet var countdownView: HFCountdownView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = HFCountdownView(frame: view.bounds)
        
        view.backgroundColor = UIColor.HFColor.Green
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "dissmiss")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        
        self.view.addGestureRecognizer(swipeDown)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        (self.view as HFCountdownView).update()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        (self.view as HFCountdownView).animateProgressView()
//        countdownView.animateProgressView()
    }
    
    @IBAction func dissmiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
