//
//  ListNotesViewModel.m
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import "ListNotesViewModel.h"
#import "DataManager.h"
#import "Constants.h"

@implementation ListNotesViewModel

-(instancetype)init{
    self  = [super init];
    
    if(self){
        [self getDataFromDatabase];
    }
    return self;
}

#pragma mark - Instance methods

-(void)removeNoteAtIndexPath:(NSIndexPath *)indexPath{
    
    Note *note = [self getNoteAtIndexPath:indexPath];
    [[DataManager sharedManager] deleteNote:[note valueForKey:kNoteModel_Id] withResult:^(BOOL result) {
        if(result){
            [[self mutableArrayValueForKeyPath:@"notes"] removeObjectAtIndex:indexPath.row];
        }
    }];
}

#pragma mark - Private methods
-(NSNumber *)lastNoteId{
    return [DataManager sharedManager].lastNoteId;
}

-(Note *)getNoteAtIndexPath:(NSIndexPath *)indexPath{
   return (Note *)[self.notes objectAtIndex:indexPath.row];
}

-(void)getDataFromDatabase{
    
    self.notes = [[NSMutableArray alloc] initWithArray:[[DataManager sharedManager] getAllNotes]];
    [DataManager sharedManager].lastNoteId = [NSNumber numberWithInteger:self.notes.count];
}

#pragma mark- DataBaseUpdateDelegate methods

- (void)databaseUpdated{
    [self getDataFromDatabase];
}

@end
