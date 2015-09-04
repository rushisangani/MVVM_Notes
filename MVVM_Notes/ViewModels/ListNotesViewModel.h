//
//  ListNotesViewModel.h
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>
#import "Note.h"
#import "CreateNoteViewModel.h"

@interface ListNotesViewModel : NSObject <DataBaseUpdateDelegate>

@property (strong, nonatomic) NSMutableArray *notes;

#pragma mark - Instance methods

-(Note *)getNoteAtIndexPath:(NSIndexPath *)indexPath;
-(void)removeNoteAtIndexPath:(NSIndexPath *)indexPath;

-(NSNumber *)lastNoteId;
-(void)getDataFromDatabase;

@end
