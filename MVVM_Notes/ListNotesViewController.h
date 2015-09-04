//
//  ViewController.h
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModels/ListNotesViewModel.h"

@interface ListNotesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ListNotesViewModel *listViewModel;

@end

