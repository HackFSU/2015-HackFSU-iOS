//
//  HFCountdownViewController.swift
//  HackFSU
//
//  Created by Logan Isitt on 2/24/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFCountdownViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = HFCountdownView(frame: view.bounds)
        
        view.backgroundColor = UIColor.HFColor.Green
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "dissmiss")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        
        self.view.addGestureRecognizer(swipeDown)
        
        (view as HFCountdownView).startTimer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        (view as HFCountdownView).update()
        (view as HFCountdownView).animateProgressView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func dissmiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
