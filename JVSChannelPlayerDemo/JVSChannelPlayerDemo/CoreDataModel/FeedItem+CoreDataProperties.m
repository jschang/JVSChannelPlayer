//
//  FeedItem+CoreDataProperties.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/3/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FeedItem+CoreDataProperties.h"

@implementation FeedItem (CoreDataProperties)

@dynamic author;
@dynamic content;
@dynamic date;
@dynamic identifier;
@dynamic link;
@dynamic summary;
@dynamic title;
@dynamic updated;
@dynamic fetchDate;
@dynamic playCount;
@dynamic lastPlay;
@dynamic enclosures;
@dynamic feed;

@end
