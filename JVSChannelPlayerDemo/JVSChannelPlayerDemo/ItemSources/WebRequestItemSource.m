//
//  WebRequestItemSource.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "WebRequestItemSource.h"
#import <MWFeedParser/MWFeedParser.h>

@implementation WebRequestItemSource

@synthesize channelId;
@synthesize itemCount;
@synthesize itemFactory;
@synthesize url;

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

-(void)makeItemSourceReadyandThen:(void(^)(void))andThen {
    NSLog(@"WebRequestItemSource makeItemSourceReady");
    if(andThen!=nil) { andThen(); }
}

-(void)addItem:(id<JVSPlayerItem>)item {
    [NSException raise:@"UnsupportedOperation" format:@"We don't save items here, that's in the caching layer.  =P"];
}
-(void)fetchItem:(NSInteger)itemId andThen:(void(^)(id<JVSPlayerItem>))andThen {
    if(andThen!=nil) { andThen(nil); }
}
-(void)fetchItemsAfter:(id<JVSPlayerItem>)item withCount:(NSInteger)count andThen:(void(^)(NSArray*))andThen {
}
-(void)fetchItemsBefore:(id<JVSPlayerItem>)item withCount:(NSInteger)count andThen:(void(^)(NSArray*))andThen {
}


@end
