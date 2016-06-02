//
//  JVSChannel.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "JVSChannel.h"

@implementation JVSChannel

@synthesize playerItemSource;
@synthesize playerFactory;
@synthesize playerDelegate;

+(JVSChannel*)channelWithItemSource:(id<JVSPlayerItemSource>)source {
    JVSChannel * channel = [[JVSChannel alloc] init];
    channel.playerItemSource = source;
    return channel;
}

-(void)makeReady {
    [self.playerItemSource makeItemSourceReadyAndThen:^{
    }];
}

-(id<JVSPlayerItem>)nextItem {
    return nil;
}
-(id<JVSPlayerItem>)prevItem {
    return nil;
}

-(void)player:(id<JVSPlayer>)player didFinishItem:(id<JVSPlayerItem>)item {
    if( playerItemSource!=nil 
        && [playerItemSource respondsToSelector:@selector(fetchItemsAfter:withCount:andThen:)]) {
        [playerItemSource fetchItemsAfter:item withCount:1 andThen:^(NSArray *items) {
            if([items count]>0) {
                id<JVSPlayer> playerForNextItem = [playerFactory playerForItem:items[0]];
                [playerForNextItem setDelegate:self];
                [player setDelegate:nil];
                /* policy is to advance to the next item && */
                [playerForNextItem play:items[0]];
            }
        }];
    }
}
-(void)player:(id<JVSPlayer>)player didBeginItem:(id<JVSPlayerItem>)item {
}
-(void)player:(id<JVSPlayer>)player didPauseItem:(id<JVSPlayerItem>)item {
}
-(void)player:(id<JVSPlayer>)player didResumeItem:(id<JVSPlayerItem>)item {
}

@end
