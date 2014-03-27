//
//  LogInViewController.m
//  hackfsu
//
//  Created by Matt O'Hagan on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "LogInViewController.h"
#import "LoadingViewController.h"

@implementation LogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenName = @"Login Screen";

    self.emailField.delegate = self;
    self.passwdField.delegate = self;
    self.signInButton.layer.cornerRadius = 5;
    
    if ([PFUser currentUser])
    {
        [self performSegueWithIdentifier:@"toTabs" sender:self];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.view.frame.origin.y == 0)
    {
        int y = - (216 - (CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(self.signInButton.frame) - 6));
        float dur = self.view.frame.size.height > 480 ? 0.3f : 0.5f;
        [UIView animateWithDuration:dur
                         animations:^{
                             [self.view setFrame:CGRectOffset(self.view.frame, 0, y)];
                         }];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailField)
    {
        [self.passwdField becomeFirstResponder];
        return NO;
    }
    [textField resignFirstResponder];
    if (self.view.frame.origin.y < 0)
    {
        int y = - CGRectGetMinY(self.view.frame);
        float dur = self.view.frame.size.height > 480 ? 0.2f : 0.1f;
        [UIView animateWithDuration:dur
                         animations:^{
                             [self.view setFrame:CGRectOffset(self.view.frame, 0, y)];
                         }];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.emailField resignFirstResponder];
    [self.passwdField resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.emailField resignFirstResponder];
    [self.passwdField resignFirstResponder];
    
    if (self.view.frame.origin.y < 0)
    {
        int y = - CGRectGetMinY(self.view.frame);
        float dur = self.view.frame.size.height > 480 ? 0.2f : 0.1f;
        [UIView animateWithDuration:dur
                         animations:^{
                             [self.view setFrame:CGRectOffset(self.view.frame, 0, y)];
                         }];
    }
}

-(void)loginButtonTouchHandler:(id)sender
{
    [self.emailField resignFirstResponder];
    [self.passwdField resignFirstResponder];
    
    if (self.view.frame.origin.y < 0)
    {
        int y = - CGRectGetMinY(self.view.frame);
        float dur = self.view.frame.size.height > 480 ? 0.2f : 0.1f;
        [UIView animateWithDuration:dur
                         animations:^{
                             [self.view setFrame:CGRectOffset(self.view.frame, 0, y)];
                         }];
    }
    
    [PFUser logInWithUsernameInBackground:self.emailField.text
                                 password:self.passwdField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user)
                                        {
                                            name = [user valueForKey:@"name"];
                                            [self performSegueWithIdentifier:@"toLoading" sender:self];
                                        }
                                        else
                                        {
                                            [self invalidCredientials];
                                        }
                                    }];
}

-(void) invalidCredientials
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!"
                                                    message:@"Invalid email or password."
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(delayAlertDismiss:) withObject:alert afterDelay:1.5f];
}

-(void) delayAlertDismiss: (UIAlertView *) alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toLoading"])
    {
        LoadingViewController *LVC = [segue destinationViewController];
        LVC.name = name;
    }
}

@end