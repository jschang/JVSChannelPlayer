//
//  DemoItemFactory.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <JVSChannelPlayer/JVSChannelPlayer.h>
#import "DemoItemFactory.h"

#import "CoreDataModel/Feed.h"
#import "CoreDataModel/FeedItem.h"
#import "CoreDataModel/FeedItemEnclosure.h"

#import "Items/DemoAVItem.h"
#import "Items/DemoTTSItem.h"

@implementation DemoItemFactory

/*
@property (nonatomic,readonly,strong) NSNumber *id;
@property (nonatomic,readonly,strong) NSString *author;
@property (nonatomic,readonly,strong) NSString *title;
@property (nonatomic,readonly,strong) NSString *articleUrl;

@property (nonatomic,readonly,strong) NSString *text;

@property (nonatomic,readonly,strong) NSString *mediaUrl;
@property (nonatomic,readonly) bool isVideo;
*/

/**
 * Implement this one to pull from CoreData,
 * when wrapping a player item source that pulls from the web.
 */
-(id<JVSPlayerItem>)playerItemWithObject:(FeedItem*)item {
    id<JVSPlayerItem> ret;
    if(item.enclosures.count>0) {
        DemoAVItem *avItem = [[DemoAVItem alloc] init];
        avItem.id = item.id;
        avItem.title = item.title;
        avItem.articleUrl = item.link;
        avItem.author = item.author;
        avItem.mediaUrl = item.enclosures[0].url;
        ret = avItem;
    } else {
        DemoTTSItem *ttsItem = [[DemoTTSItem alloc] init];
        ttsItem.id = item.id;
        ttsItem.title = item.title;
        ttsItem.articleUrl = item.link;
        ttsItem.author = item.author;
        ttsItem.text = item.summary;
        ret = ttsItem;
    }
    return ret;
}

@end
