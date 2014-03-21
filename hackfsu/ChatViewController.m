//
//  ChatViewController.m
//  hackfsu
//
//  Created by Michelle Rojas on 2/7/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "ChatViewController.h"

#define TABBAR_HEIGHT 49.0f
#define TEXTFIELD_HEIGHT 70.0f
#define MAX_ENTRIES_LOADED 25

@implementation ChatViewController
@synthesize tfEntry;
@synthesize chatTable;
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:NO];
    
    tfEntry.delegate = self;
    tfEntry.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self registerForKeyboardNotifications];
//    if (_refreshHeaderView == nil) {
//        
//		PF_EGORefreshTableHeaderView *view = [[PF_EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - chatTable.bounds.size.height, self.view.frame.size.width, chatTable.bounds.size.height)];
//		view.delegate = self;
//		[chatTable addSubview:view];
//		_refreshHeaderView = view;
//	}
	//  update the last update date
//	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Chat textfield

-(IBAction) textFieldDoneEditing : (id) sender
{
    NSLog(@"the text content%@",tfEntry.text);
    [sender resignFirstResponder];
    [tfEntry resignFirstResponder];
}

-(IBAction) backgroundTap:(id) sender
{
    [self.tfEntry resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"the text content%@",tfEntry.text);
    [textField resignFirstResponder];
    
    if (tfEntry.text.length>0)
    {
        // updating the table immediately
//        NSArray *keys = [NSArray arrayWithObjects:@"text", @"userName", @"date", nil];
//        NSArray *objects = [NSArray arrayWithObjects:tfEntry.text, userName, [NSDate date], nil];
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//        [chatData addObject:dictionary];
//        
//        NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
//        NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [insertIndexPaths addObject:newPath];
//        [chatTable beginUpdates];
//        [chatTable insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
//        [chatTable endUpdates];
//        [chatTable reloadData];
        
        // going for the parsing
//        PFObject *newMessage = [PFObject objectWithClassName:@"chatroom"];
//        [newMessage setObject:tfEntry.text forKey:@"text"];
//        [newMessage setObject:userName forKey:@"userName"];
//        [newMessage setObject:[NSDate date] forKey:@"date"];
//        [newMessage saveInBackground];
//        tfEntry.text = @"";
    }
    
    // reload the data
//    [self loadLocalChat];
    return NO;
}


-(void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void) freeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


-(void) keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"Keyboard was shown");
    NSDictionary* info = [aNotification userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    // Move
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    NSLog(@"frame..%f..%f..%f..%f",self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"keyboard..%f..%f..%f..%f",keyboardFrame.origin.x, keyboardFrame.origin.y, keyboardFrame.size.width, keyboardFrame.size.height);
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - keyboardFrame.size.height+TABBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height)];
    [chatTable setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+ keyboardFrame.size.height+TABBAR_HEIGHT+TEXTFIELD_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-keyboardFrame.size.height)];
    [chatTable scrollsToTop];
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification*)aNotification
{
    NSLog(@"Keyboard will hide");
    NSDictionary* info = [aNotification userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    // Move
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardFrame.size.height-TABBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height)];
    [chatTable setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-TABBAR_HEIGHT)];
    [UIView commitAnimations];
}

@end