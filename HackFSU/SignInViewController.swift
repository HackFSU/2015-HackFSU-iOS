//
//  SignInViewController.swift
//  HackFSU
//
//  Created by Trevor Helms on 2/15/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import Foundation

class SignInViewController : UIViewController {
    
    let service = "parseSignIn"
    let userAccount = "parseSignInUser"
    let key = "HackFSUSpring2015"
    
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInErrorLabel.text = ""
    }
    
    override func viewDidAppear(animated: Bool) {
        let (dictionary, error) = Locksmith.loadData(forKey: key, inService: service, forUserAccount: userAccount)
    }
    
    @IBAction func signInButtonClicked() {
        // Check fields not empty
        if emailTextField.text != "" && passwordTextField.text != "" {
            PFUser.logInWithUsernameInBackground(emailTextField.text, password: passwordTextField.text) {
                (user: PFUser!, error: NSError!) -> Void in
                if user != nil {
                    // User exists, let's sign 'em in
                    self.signInErrorLabel.text = "SIGNED IN MAN"
                }
                else {
                    self.signInErrorLabel.text = "Email/password combo not found, yo."
                }
            }
        }
        else {
            // All fields need to be filled, obviously
            signInErrorLabel.text = "Not cool dude. Fill in all da fields."
            NSLog("Fields not filled in")
        }
    }
    
}