//
//  DataManager.m
//  MVVM_Notes
//
//  Created by Rushi Sangani on 01/09/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#define NoteEntity      @"Note"
#define kLastNoteId     @"lastNoteId"

#import "DataManager.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface DataManager ()
{
    NSNumber *_lastNoteId;
}
@end

@implementation DataManager
@synthesize lastNoteId = _lastNoteId;

#pragma mark- Singleton instance

+(DataManager *)sharedManager{
    
    static DataManager *_sharedManager;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        if(!_sharedManager){
            _sharedManager = [[DataManager alloc] init];
            _sharedManager.lastNoteId = 0;
        }
    });
    
    return _sharedManager;
}

#pragma mark- setter/getter
-(void)setLastNoteId:(NSNumber *)lastNoteId{
    _lastNoteId = lastNoteId;
    [[NSUserDefaults standardUserDefaults] setObject:lastNoteId forKey:kLastNoteId];
}

-(NSNumber *)lastNoteId{
    return (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:kLastNoteId];
}

#pragma mark- Add New Note
-(void)addNewNote:(NSDictionary *)note withResult:(void (^)(BOOL))completionBlock{

    NSManagedObject *noteObject = [NSEntityDescription insertNewObjectForEntityForName:NoteEntity inManagedObjectContext:[self manageObjectContext]];
    
    [noteObject setValue:[note valueForKey:kNoteModel_Id] forKey:kNoteModel_Id];
    [noteObject setValue:[note valueForKey:kNoteModel_Title] forKey:kNoteModel_Title];
    [noteObject setValue:[note valueForKey:kNoteModel_NoteText] forKey:kNoteModel_NoteText];
    [noteObject setValue:[note valueForKey:kNoteModel_ModifiedDate] forKey:kNoteModel_ModifiedDate];
    
    [self saveContextWithResult:^(BOOL result){
        
        if(result){
            self.lastNoteId = [NSNumber numberWithInteger:[self.lastNoteId integerValue]+1];
        }
        
        completionBlock(result);
    }];
}

#pragma mark- Update Note
-(void)updateNote:(NSDictionary *)note withResult:(void (^)(BOOL))completionBlock{
    
    NSManagedObject *noteObject = [self getManagedObjectForId:[note valueForKey:kNoteModel_Id]];
    if(noteObject){
        
        [noteObject setValue:[note valueForKey:kNoteModel_Title] forKey:kNoteModel_Title];
        [noteObject setValue:[note valueForKey:kNoteModel_NoteText] forKey:kNoteModel_NoteText];
        [noteObject setValue:[note valueForKey:kNoteModel_ModifiedDate] forKey:kNoteModel_ModifiedDate];
        
        [self saveContextWithResult:^(BOOL result) {
            completionBlock(result);
        }];
    }
    else{
        completionBlock(NO);
    }
}

#pragma mark - Delete Note
-(void)deleteNote:(NSNumber *)noteId withResult:(void (^)(BOOL))completionBlock{
    
    NSManagedObject *noteObject = [self getManagedObjectForId:noteId];
    if(noteObject){
        
        [[self manageObjectContext] deleteObject:noteObject];
        
        [self saveContextWithResult:^(BOOL result) {
            completionBlock(result);
        }];
    }
    else{
        completionBlock(NO);
    }
}

#pragma mark- Get All Note
-(NSArray *)getAllNotes{
    
    NSManagedObjectContext *context = [self manageObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:NoteEntity inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *results = [[NSArray alloc] initWithArray:[[context executeFetchRequest:fetchRequest error:nil] mutableCopy]];
    return results;
}

#pragma mark- ManageObjectContext
-(NSManagedObjectContext *)manageObjectContext{
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    
    return context;
}

#pragma mark- Save Context
-(void)saveContextWithResult:(void(^)(BOOL result))completionBlock
{
    NSError *error = nil;
    
    // Save the object to persistent store
    if (![[self manageObjectContext] save:&error]) {
        NSLog(@"Can't Process! %@ %@", error, [error localizedDescription]);
        completionBlock(NO);
    }
    else{
        completionBlock (YES);
    }
}

#pragma mark - Private Methods
-(NSManagedObject *)getManagedObjectForId:(NSNumber *)noteId
{
    NSManagedObject *resultObject = nil;
    
    NSManagedObjectContext *context = [self manageObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NoteEntity inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(noteId = %@)",noteId]];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    if (results.count > 0) {
        resultObject = [results objectAtIndex:0];
    }
    return resultObject;
}

-(Note *)getNoteById:(NSNumber *)noteId{
    
    Note *note = nil;
    
    NSManagedObject *noteObject = [self getManagedObjectForId:noteId];
    if(noteObject){
        note = (Note *)noteObject;
    }
    return note;
}

@end
