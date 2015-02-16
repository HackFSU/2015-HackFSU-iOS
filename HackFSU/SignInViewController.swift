//
//  SignInViewController.swift
//  HackFSU
//
//  Created by Trevor Helms on 2/15/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class SignInViewController : UIViewController {

    let service = "parseSignIn"
    let userAccount = "parseSignInUser"
    
    let DEVEL_MODE = true

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInErrorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        signInErrorLabel.text = ""
    }

    @IBAction func signInButtonClicked() {
        if DEVEL_MODE {
            presentSlideMenuController()
        }
        
        // Check fields not empty
        if emailTextField.text != "" && passwordTextField.text != "" {
            PFUser.logInWithUsernameInBackground(emailTextField.text, password: passwordTextField.text) {
                (user: PFUser!, error: NSError!) -> Void in
                if user != nil {
                    // User exists, let's sign 'em in
                    NSLog("Signed in as \(user.email)")
                    self.presentSlideMenuController()

                }
                else {
                    self.signInErrorLabel.text = "Email/password combo not found, yo."
                    NSLog("User account not found")
                }
            }
        }
        else {
            // All fields need to be filled, obviously
            signInErrorLabel.text = "Not cool dude. Fill in all da fields."
            NSLog("Fields not filled in")
        }
    }

    func presentSlideMenuController() {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)

        let newsViewController = storyboard.instantiateViewControllerWithIdentifier("NewsViewController") as NewsViewController
        let sidebarViewController = storyboard.instantiateViewControllerWithIdentifier("SidebarViewController") as SidebarViewController

        let newsNav: UINavigationController = UINavigationController(rootViewController: newsViewController)

        sidebarViewController.newsViewController = newsNav

        let slideMenuController = SlideMenuController(mainViewController: newsNav, leftMenuViewController: sidebarViewController)
        self.presentViewController(slideMenuController, animated: true, completion: nil)

    }
}
