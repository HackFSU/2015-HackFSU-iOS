//
//  SignInViewController.swift
//  HackFSU
//
//  Created by Trevor Helms on 2/7/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class SignInViewController : UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func signInButonPressed() {
        // Attempt to sign in with Parse
        PFUser.logInWithUsernameInBackground(emailTextField.text, password: passwordTextField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                NSLog("Signed in")
            }
            else {
                NSLog("Sign in failed")
            }
        }
    }
}