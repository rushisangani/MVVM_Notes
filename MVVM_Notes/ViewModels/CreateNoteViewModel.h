//
//  CreateNoteViewModel.h
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@protocol DataBaseUpdateDelegate <NSObject>

-(void)databaseUpdated;

@end

@interface CreateNoteViewModel : NSObject

@property (weak, nonatomic) id<DataBaseUpdateDelegate> delegate;

#pragma mark - Instance methods

-(instancetype)initWithDelegate:(id)delegate noteId:(NSNumber *)noteId isEdit:(BOOL)isEdit;
-(void)updateDatabase:(NSString *)title noteText:(NSString *)noteDescription;

-(NSString *)noteTitle;
-(NSString *)noteText;

@end
