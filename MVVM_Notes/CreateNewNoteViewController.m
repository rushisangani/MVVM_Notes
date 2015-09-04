//
//  CreateNewNoteViewController.m
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import "CreateNewNoteViewController.h"
#import "Constants.h"

@interface CreateNewNoteViewController () <UITextFieldDelegate, UITextViewDelegate>
{
    NSString *noteTitle;
    NSString *noteDescription;
}

@end

@implementation CreateNewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    noteTitle = [self.noteModel noteTitle];
    noteDescription = [self.noteModel noteText];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.txtNoteTitle.text = noteTitle;
    self.txtNoteDescription.text = noteDescription;
}

#pragma mark - Action Methods
- (IBAction)cancelButtonClicked:(id)sender {
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonClicked:(id)sender {
    [self.view endEditing:YES];
    
    [self.noteModel updateDatabase:noteTitle noteText:noteDescription];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextField Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    noteTitle = (textField.text) ? textField.text : @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    noteDescription = (textView.text) ? textView.text : @"";
}

@end
