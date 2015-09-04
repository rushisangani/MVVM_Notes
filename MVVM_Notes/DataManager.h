//
//  DataManager.h
//  MVVM_Notes
//
//  Created by Rushi Sangani on 01/09/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface DataManager : NSObject

@property (nonatomic) NSNumber *lastNoteId;

+(DataManager *)sharedManager;

/* Add new note to database */
-(void)addNewNote:(NSDictionary *)note withResult:(void(^)(BOOL result))completionBlock;

/* Update note */
-(void)updateNote:(NSDictionary *)note withResult:(void(^)(BOOL result))completionBlock;

/* Delete Note */
-(void)deleteNote:(NSNumber *)noteId withResult:(void(^)(BOOL result))completionBlock;

/* Get all notes from database */
-(NSArray *)getAllNotes;

/* Get Note by Id*/
-(Note *)getNoteById:(NSNumber *)noteId;

@end
