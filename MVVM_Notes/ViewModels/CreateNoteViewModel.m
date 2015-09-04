//
//  CreateNoteViewModel.m
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import "CreateNoteViewModel.h"
#import "DataManager.h"
#import "Constants.h"

@interface CreateNoteViewModel ()
{
    NSMutableDictionary *mutableDictionary;
}
@property (nonatomic, strong) Note *note;
@property (strong, nonatomic) NSNumber *noteId;
@property (nonatomic, assign) BOOL isEdit;

@end

@implementation CreateNoteViewModel

-(instancetype)initWithDelegate:(id)delegate noteId:(NSNumber *)noteId isEdit:(BOOL)isEdit{
    self = [super init];
    if(self){
        self.delegate = delegate;
        self.isEdit = isEdit;
        self.noteId = noteId;
        
        if(noteId){
            self.note = [self getNoteForId:noteId];
        }
    }
    return self;
}

#pragma mark - Custom Methods
-(NSString *)noteTitle{
    if(!_note){
        return @"";
    }
    return _note.title;
}

-(NSString *)noteText{
    if(!_note){
        return @"";
    }
    return _note.noteText;
}

-(NSUInteger)lastNoteId{
    return [[DataManager sharedManager].lastNoteId integerValue];
}

-(Note *)getNoteForId:(NSNumber *)noteId{
    return [[DataManager sharedManager] getNoteById:noteId];
}

-(void)updateDatabase:(NSString *)title noteText:(NSString *)noteDescription{
    
    NSDictionary *dataDict = @{kNoteModel_Title: title, kNoteModel_NoteText: noteDescription, kNoteModel_ModifiedDate : [self getDateAsString]};
    mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:dataDict];
    
    if(_isEdit){
        [mutableDictionary setObject:self.noteId forKey:kNoteModel_Id];
        [self updateNote:mutableDictionary];
    }
    else{
        [mutableDictionary setValue:[NSNumber numberWithInteger:[self lastNoteId] +1] forKey:kNoteModel_Id];
        [self createNewNote:mutableDictionary];
    }
}

-(NSString *)getDateAsString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

#pragma mark - Update Database
-(void)createNewNote:(NSDictionary *)note{
    
    [[DataManager sharedManager] addNewNote:note withResult:^(BOOL result) {
        if(result){
            if([self.delegate respondsToSelector:@selector(databaseUpdated)]){
                [self.delegate databaseUpdated];
            }
        }
    }];
}

-(void)updateNote:(NSDictionary *)note{
    
    [[DataManager sharedManager] updateNote:note withResult:^(BOOL result) {
        if(result){
            if([self.delegate respondsToSelector:@selector(databaseUpdated)]){
                [self.delegate databaseUpdated];
            }
        }
    }];
}


@end
