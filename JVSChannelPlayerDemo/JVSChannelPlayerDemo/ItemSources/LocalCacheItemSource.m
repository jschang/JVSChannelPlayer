//
//  LocalCacheItemSource.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "LocalCacheItemSource.h"

@implementation LocalCacheItemSource

@synthesize upstreamSource;

-(void)makeItemSourceReadyAndThen:(void (^)())andThen {
    NSLog(@"LocalCacheItemSource makeItemSourceReady");
    [upstreamSource makeItemSourceReadyAndThen:^{
        if(andThen!=nil) { andThen(); }
    }];
}
-(void)addItem:(id<JVSPlayerItem>)item afterItem:(id<JVSPlayerItem>)prevItem {
    [upstreamSource addItem:item afterItem:prevItem];
}
-(void)fetchItem:(NSInteger)itemId andThen:(void(^)(id<JVSPlayerItem>))andThen {
    [upstreamSource fetchItem:itemId andThen:andThen];
}
-(void)fetchItemsAfter:(id<JVSPlayerItem>)item withCount:(NSInteger)count andThen:(void(^)(NSArray*))andThen {
    [upstreamSource fetchItemsAfter:item withCount:count andThen:andThen];
}
-(void)fetchItemsBefore:(id<JVSPlayerItem>)item withCount:(NSInteger)count andThen:(void(^)(NSArray*))andThen {
    [upstreamSource fetchItemsBefore:item withCount:count andThen:andThen];
}

@end
