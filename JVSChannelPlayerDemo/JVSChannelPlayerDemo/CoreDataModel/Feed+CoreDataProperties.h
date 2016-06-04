//
//  Feed+CoreDataProperties.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/4/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Feed.h"

NS_ASSUME_NONNULL_BEGIN

@interface Feed (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *displayName;
@property (nullable, nonatomic, retain) NSDate *lastFetchDate;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSOrderedSet<FeedItem *> *items;

@end

@interface Feed (CoreDataGeneratedAccessors)

- (void)insertObject:(FeedItem *)value inItemsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromItemsAtIndex:(NSUInteger)idx;
- (void)insertItems:(NSArray<FeedItem *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeItemsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInItemsAtIndex:(NSUInteger)idx withObject:(FeedItem *)value;
- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray<FeedItem *> *)values;
- (void)addItemsObject:(FeedItem *)value;
- (void)removeItemsObject:(FeedItem *)value;
- (void)addItems:(NSOrderedSet<FeedItem *> *)values;
- (void)removeItems:(NSOrderedSet<FeedItem *> *)values;

@end

NS_ASSUME_NONNULL_END
