//
//  JVSChannel.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "JVSChannel.h"

@interface JVSChannel()
@property (nonatomic,retain) id<JVSPlayerItem> currentItem;
@end

@implementation JVSChannel

@synthesize playerFactory;
@synthesize itemSource;
@synthesize delegate;
@synthesize currentItem;

+(JVSChannel*)channelWithItemSource:(id<JVSPlayerItemSource>)source {
    JVSChannel * channel = [[JVSChannel alloc] init];
    channel.itemSource = source;
    channel.currentItem = nil;
    return channel;
}

-(void)makeReady {
    [self.itemSource makeItemSourceReadyAndThen:^{}];
}

-(void)next {
    [self.itemSource fetchItemsAfter:self.currentItem withCount:1 andThen:^(NSArray *items) {
        if(items!=nil && items.count) {
            self.currentItem = items[0];
            self.currentItem.player = [self.playerFactory playerForItem:self.currentItem];
            self.currentItem.player.delegate = self.delegate;
            [self play];
        }
    }];
}
-(void)previous {
    [self.itemSource fetchItemsBefore:self.currentItem withCount:1 andThen:^(NSArray *items) {
        if(items!=nil && items.count) {
            self.currentItem = items[0];
            self.currentItem.player = [self.playerFactory playerForItem:self.currentItem];
            self.currentItem.player.delegate = self.delegate;
            [self play];
        }
    }];
}
-(void)play {
    if(self.currentItem!=nil) {
        [self.currentItem.player play:self.currentItem];
    }
}
-(void)stop {
    if(self.currentItem!=nil) {
        [self.currentItem.player stop];
    }
}
-(void)pause {
    if(self.currentItem!=nil) {
        [self.currentItem.player pause];
    }
}
-(void)resume {
    if(self.currentItem!=nil) {
        [self.currentItem.player resume];
    }
}

@end
