//
//  FeedItemEnclosure+CoreDataProperties.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/4/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FeedItemEnclosure.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedItemEnclosure (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *length;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) FeedItem *item;

@end

NS_ASSUME_NONNULL_END
