//
//  LogInViewController.h
//  hackfsu
//
//  Created by Matt O'Hagan on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController <PFLogInViewControllerDelegate ,UITextFieldDelegate>

- (IBAction)loginButtonTouchHandler:(id)sender;

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UITextField *emailField;
@property (nonatomic, strong) IBOutlet UITextField *passwdField;
@property (nonatomic, strong) IBOutlet UIButton *signInButton;
@end
