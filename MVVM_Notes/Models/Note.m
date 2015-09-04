//
//  Note.m
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import "Note.h"

@implementation Note

#pragma mark - Instance methods
-(instancetype)initWithId:(NSUInteger)number{
    
    self = [super init];
    if(self){
        
        self.noteId = (number)? number : 0;
        self.title = @"";
        self.noteText = @"";
        self.modifiedDate = @"";
    }
    
    return self;
}

@end
