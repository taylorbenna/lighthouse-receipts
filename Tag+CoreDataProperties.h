//
//  Tag+CoreDataProperties.h
//  Receipts++
//
//  Created by Taylor Benna on 2016-05-26.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tagName;
@property (nullable, nonatomic, retain) NSSet<Receipts *> *receipts;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addReceiptsObject:(Receipts *)value;
- (void)removeReceiptsObject:(Receipts *)value;
- (void)addReceipts:(NSSet<Receipts *> *)values;
- (void)removeReceipts:(NSSet<Receipts *> *)values;

@end

NS_ASSUME_NONNULL_END
