//
//  Feed+CoreDataProperties.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/3/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Feed+CoreDataProperties.h"

@implementation Feed (CoreDataProperties)

@dynamic displayName;
@dynamic lastFetchDate;
@dynamic summary;
@dynamic url;
@dynamic items;

@end
