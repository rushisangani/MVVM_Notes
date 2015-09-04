//
//  CreateNewNoteViewController.h
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateNoteViewModel.h"

@interface CreateNewNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtNoteTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtNoteDescription;

@property (strong, nonatomic) CreateNoteViewModel *noteModel;

@end
