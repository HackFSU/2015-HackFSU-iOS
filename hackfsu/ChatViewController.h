//
//  ChatViewController.h
//  hackfsu
//
//  Created by Michelle Rojas on 2/7/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *tfEntry;
    
    IBOutlet UITableView *chatTable;
}

@property(nonatomic, strong) IBOutlet UITextField *tfEntry;
@property (nonatomic, retain) IBOutlet UITableView *chatTable;

-(void) registerForKeyboardNotifications;
-(void) freeKeyboardNotifications;
-(void) keyboardWasShown:(NSNotification*)aNotification;
-(void) keyboardWillHide:(NSNotification*)aNotification;

@end
