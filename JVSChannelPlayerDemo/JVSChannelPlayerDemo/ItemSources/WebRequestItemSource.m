//
//  WebRequestItemSource.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "WebRequestItemSource.h"
#import "RSSOrAtomFeedParser.h"
#import <MagicalRecord/MagicalRecord.h>
#import "../Items/DemoItemBase.h"
#import "../CoreDataModel/Feed.h"
#import "../CoreDataModel/FeedItem.h"
#import "../CoreDataModel/FeedItemEnclosure.h"

NSObject *idLock;
#define LAST_ID_KEY @"WebRequestItemSource.lastId"

@interface WebRequestItemSource ()
@property (strong,nonatomic,retain) RSSOrAtomFeedParser *rssParser; 
@property (nonatomic,strong,retain) Feed *feed;
@end

@implementation WebRequestItemSource

@synthesize rssParser;
@synthesize channelId;
@synthesize itemCount;
@synthesize itemFactory;
@synthesize url;
@synthesize feed;

+(void) initialize {
    idLock = [[NSObject alloc] init];
    if([[NSUserDefaults standardUserDefaults] objectForKey:LAST_ID_KEY]==0) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:LAST_ID_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(NSInteger) nextId {
    @synchronized(idLock) {
        NSInteger lastId = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_ID_KEY];
        lastId++;
        [[NSUserDefaults standardUserDefaults] setInteger:lastId forKey:LAST_ID_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return lastId;
    }
}

+(WebRequestItemSource*)initWithItemCount:(int)count 
        andChannelId:(int)channelId 
        andUrl:(NSString*)url
        andFactory:(id<JVSPlayerItemFactory>)factory {
        
    WebRequestItemSource *source = [[WebRequestItemSource alloc] init];
    source.channelId = channelId;
    source.itemCount = count;
    source.url = url;
    source.itemFactory = factory;
    return source;
}

#pragma mark - JVSPlayerItemSource Methods

-(void)makeItemSourceReadyAndThen:(void(^)())andThen {
    NSLog(@"WebRequestItemSource makeItemSourceReady");
    // IRL, we'd prolly do nothing here...but because we're simulating
    // a web request, and the middle-ware would be fetching from a database
    // we'll have our database access on this layer, and cache things here
    // ... the LocalCacheItemSource will use just in memory cache, 
    // but would use CoreData in a real-application
    self.rssParser = [RSSOrAtomFeedParser parseUrl:self.url
        onInfo:^(MWFeedInfo *info) {
            // Provides info about the feed
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@", info.link];
            NSArray *feeds = [Feed MR_findAllWithPredicate:predicate];
            if([feeds count]==0) {
                feed = [Feed MR_createEntity];
                feed.id = [NSNumber numberWithInteger:self.channelId];
                feed.url = info.link;
                feed.summary = info.summary;
                feed.displayName = info.title;
                feed.lastFetchDate = [NSDate date];
                [feed.managedObjectContext MR_saveToPersistentStoreAndWait];
            } else {
                feed = feeds[0];
            }
        }
        onItem:^(MWFeedItem *item) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"link = %@ && feed.url = %@", item.link, feed.url];
            NSArray *items = [FeedItem MR_findAllWithPredicate:predicate];
            if([items count]==0) {
                FeedItem *feedItem = [FeedItem MR_createEntity];
                feedItem.id = [NSNumber numberWithInteger:[WebRequestItemSource nextId]];
                feedItem.link = item.link;
                feedItem.content = item.content;
                feedItem.date = item.date;
                feedItem.identifier = item.identifier;
                feedItem.summary = item.summary;
                feedItem.title = item.title;
                feedItem.updated = item.updated;
                feedItem.fetchDate = [NSDate date];
                feedItem.playCount = 0;
                feedItem.lastPlay = nil;
                feedItem.feed = feed;
                NSMutableOrderedSet *enccopy = [feedItem.enclosures mutableCopy];
                feedItem.enclosures = enccopy;
                for(NSDictionary *enclosure in item.enclosures) {
                    FeedItemEnclosure *enc = [FeedItemEnclosure MR_createEntity];
                    enc.url = [enclosure valueForKey:@"url"];
                    enc.type = [enclosure valueForKey:@"type"];
                    enc.length = [enclosure valueForKey:@"length"];
                    enc.item = feedItem;
                    [enccopy addObject:enc];
                }
                [feedItem.managedObjectContext MR_saveToPersistentStoreAndWait];
            }
        }
        andThen:^(NSArray<MWFeedItem *> *items, NSError *error) {
            NSLog(@"got items: ");
            // TODO: cleanup with a configurable retention policy
            NSPredicate *predicate = [NSPredicate 
                predicateWithFormat:@"item.feed.url = %@ "
                                    "&& (item.playCount = null || item.playCount = 0) "
                                    "&& (item.favorited = null || item.favorited = 0) "
                                    "&& item.lastPlay < %@ "
                , feed.url
                , [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*60)]];
            [FeedItemEnclosure MR_deleteAllMatchingPredicate:predicate];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            predicate = [NSPredicate 
                predicateWithFormat:@"feed.url = %@ "
                                    "&& (playCount = null || playCount = 0) "
                                    "&& (favorited = null || favorited = 0) "
                                    "&& lastPlay < %@ "
                , feed.url
                , [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*60)]];
            [FeedItem MR_deleteAllMatchingPredicate:predicate];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            if(andThen!=nil) {
                andThen();
            }
        }];
}

-(void)addItem:(id<JVSPlayerItem>)item afterItem:(id<JVSPlayerItem>)prevItem {
    [NSException raise:@"UnsupportedOperation" format:@"We don't save items here, that's in the caching layer.  =P"];
}
-(void)fetchItem:(NSInteger)itemId andThen:(void(^)(id<JVSPlayerItem>))andThen {
    NSPredicate *predicate
        = [NSPredicate predicateWithFormat:@"id = %@", itemId];
    FeedItem *item = [FeedItem MR_findFirstWithPredicate:predicate];
    if(andThen!=nil) {
        andThen([itemFactory playerItemWithObject:item]);
    }
}
-(void)fetchItemsAfter:(DemoItemBase*)item withCount:(NSInteger)count andThen:(void(^)(NSArray*))andThen {
    if(andThen!=nil) {
        andThen([self fetchItemsFrom:item withCount:(int)count forwards:YES]);
    }
}
-(void)fetchItemsBefore:(id<JVSPlayerItem>)item withCount:(NSInteger)count andThen:(void(^)(NSArray*))andThen {
    if(andThen!=nil) {
        andThen([self fetchItemsFrom:item withCount:(int)count forwards:NO]);
    }
}

-(NSArray*) fetchItemsFrom:(DemoItemBase*)item withCount:(int)count forwards:(bool)forwards {

    NSString *pred = forwards ? @"id > %@ && feed.id = %i" 
                              : @"id < %@ && feed.id = %i";

    NSPredicate *filter = [NSPredicate predicateWithFormat:pred
                                , ( 
                                    item != nil 
                                    ? item.id 
                                    : [NSNumber numberWithInt:0]
                                )
                                , self.channelId
                                , nil];
    
    NSFetchRequest *request = [FeedItem MR_requestAllWithPredicate:filter];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"id"
        ascending:forwards?YES:NO];
    
    [request setSortDescriptors:@[sort]];
    [request setReturnsDistinctResults:YES];
    [request setFetchLimit:count];

    NSArray *items = [FeedItem MR_executeFetchRequest:request];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for(FeedItem *item in items) {
        [ret addObject:[itemFactory playerItemWithObject:item]];
    }
    if(!forwards) {
        [self reverse:ret];
    }
    return ret;
}

-(void)reverse:(NSMutableArray*)arr {
    if ([arr count] <= 1)
        return;
    NSUInteger i = 0;
    NSUInteger j = [arr count] - 1;
    while (i < j) {
        [arr exchangeObjectAtIndex:i
                  withObjectAtIndex:j];

        i++;
        j--;
    }
}

@end
