//
//  Note.h
//  MVVM_Notes
//
//  Created by Rushi Sangani on 27/08/15.
//  Copyright (c) 2015 Codal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Note : NSObject

@property (nonatomic) NSUInteger noteId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *modifiedDate;
@property (strong, nonatomic) NSString *noteText;

-(instancetype)initWithId:(NSUInteger)number;

@end
