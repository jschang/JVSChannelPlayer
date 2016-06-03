//
//  FeedItem.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/3/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Feed, FeedItemEnclosure;

NS_ASSUME_NONNULL_BEGIN

@interface FeedItem : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "FeedItem+CoreDataProperties.h"
