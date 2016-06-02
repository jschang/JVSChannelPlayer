//
//  LocalCacheItemSource.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "LocalCacheItemSource.h"
#import "NWURLConnection.h"

@implementation LocalCacheItemSource

@synthesize upstreamSource;

-(void)makeItemSourceReadyAndThen:(void (^)())andThen {
    NSLog(@"LocalCacheItemSource makeItemSourceReady");
    [upstreamSource makeItemSourceReadyAndThen:^{
        if(andThen!=nil) { andThen(); }
    }];
}
-(void)addItem:(id<JVSPlayerItem>)item afterItem:(id<JVSPlayerItem>)prevItem {
}
-(void)fetchItem:(NSInteger)itemId andThen:(void(^)(id<JVSPlayerItem>))andThen {
}
-(void)fetchItemsAfter:(id<JVSPlayerItem>)item withCount:(NSInteger)count andThen:(void(^)(NSArray*))andThen {
}
-(void)fetchItemsBefore:(id<JVSPlayerItem>)item withCount:(NSInteger)count andThen:(void(^)(NSArray*))andThen {
}

@end
