//
//  Receipts+CoreDataProperties.h
//  Receipts++
//
//  Created by Taylor Benna on 2016-05-26.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Receipts.h"

NS_ASSUME_NONNULL_BEGIN

@interface Receipts (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDecimalNumber *amount;
@property (nullable, nonatomic, retain) NSString *note;
@property (nonatomic) NSDate *timeStamp;
@property (nullable, nonatomic, retain) NSSet<Tag *> *tags;

@end

@interface Receipts (CoreDataGeneratedAccessors)

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet<Tag *> *)values;
- (void)removeTags:(NSSet<Tag *> *)values;

@end

NS_ASSUME_NONNULL_END
