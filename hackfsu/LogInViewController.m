//
//  LogInViewController.m
//  hackfsu
//
//  Created by Matt O'Hagan on 2/8/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "LogInViewController.h"

@implementation LogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.signInButton.layer.cornerRadius = 5;
    
    [self.navigationController setNavigationBarHidden:YES];
    
    if ([PFUser currentUser])
    {
        [self performSegueWithIdentifier:@"toTabs" sender:self];
    }
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
    
    if ([PFUser logInWithUsername:self.emailField.text password:self.passwdField.text])
    {
        [self performSegueWithIdentifier:@"toLoading" sender:self];
    }
}

@end