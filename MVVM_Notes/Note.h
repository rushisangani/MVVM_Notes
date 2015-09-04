//
//  Note.h
//  
//
//  Created by Rushi Sangani on 04/09/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * modifiedDate;
@property (nonatomic, retain) NSNumber * noteId;
@property (nonatomic, retain) NSString * noteText;
@property (nonatomic, retain) NSString * title;

@end
