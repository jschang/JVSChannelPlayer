//
//  FeedItem+CoreDataProperties.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/3/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FeedItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *identifier;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSDate *updated;
@property (nullable, nonatomic, retain) NSDate *fetchDate;
@property (nullable, nonatomic, retain) NSNumber *playCount;
@property (nullable, nonatomic, retain) NSDate *lastPlay;
@property (nullable, nonatomic, retain) NSOrderedSet<FeedItemEnclosure *> *enclosures;
@property (nullable, nonatomic, retain) Feed *feed;

@end

@interface FeedItem (CoreDataGeneratedAccessors)

- (void)insertObject:(FeedItemEnclosure *)value inEnclosuresAtIndex:(NSUInteger)idx;
- (void)removeObjectFromEnclosuresAtIndex:(NSUInteger)idx;
- (void)insertEnclosures:(NSArray<FeedItemEnclosure *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeEnclosuresAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInEnclosuresAtIndex:(NSUInteger)idx withObject:(FeedItemEnclosure *)value;
- (void)replaceEnclosuresAtIndexes:(NSIndexSet *)indexes withEnclosures:(NSArray<FeedItemEnclosure *> *)values;
- (void)addEnclosuresObject:(FeedItemEnclosure *)value;
- (void)removeEnclosuresObject:(FeedItemEnclosure *)value;
- (void)addEnclosures:(NSOrderedSet<FeedItemEnclosure *> *)values;
- (void)removeEnclosures:(NSOrderedSet<FeedItemEnclosure *> *)values;

@end

NS_ASSUME_NONNULL_END
