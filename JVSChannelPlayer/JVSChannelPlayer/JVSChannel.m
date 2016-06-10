//
//  JVSChannel.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "JVSChannel.h"

@implementation JVSChannel

@synthesize playerFactory;
@synthesize itemSource;
@synthesize delegate;
@synthesize currentItem;

+(JVSChannel*)channelWithItemSource:(id<JVSPlayerItemSource>)source {
    JVSChannel * channel = [[JVSChannel alloc] init];
    channel.itemSource = source;
    channel->currentItem = nil;
    return channel;
}

-(void)makeReady {
    [self.itemSource makeItemSourceReadyAndThen:^{}];
}
-(bool)isPaused {
    if(currentItem
        && currentItem.player
        && currentItem.player.isPaused
    ) { 
        return YES; 
    } else {
        return NO;
    }
}

-(void)next {
    [self.itemSource fetchItemsAfter:self.currentItem withCount:1 andThen:^(NSArray *items) {
        if(items!=nil && items.count) {
            if(currentItem && currentItem.player && currentItem.player.delegate) {
                currentItem.player = nil;
            }
            currentItem = items[0];
            self.currentItem.player = [self.playerFactory playerForItem:self.currentItem];
            self.currentItem.player.delegate = self.delegate;
            dispatch_async(dispatch_get_main_queue(),^(){
                if(self.delegate && [self.delegate respondsToSelector:@selector(channel:hasReadyItem:)]) {
                    [self.delegate channel:self hasReadyItem:items[0]];
                }
            }); 
        } else {
            dispatch_async(dispatch_get_main_queue(),^(){
                if(self.delegate && [self.delegate respondsToSelector:@selector(channel:hasReadyItem:)]) {
                    [self.delegate channel:self hasReadyItem:nil];
                }
            });
        }
    }];
}
-(void)previous {
    [self.itemSource fetchItemsBefore:self.currentItem withCount:1 andThen:^(NSArray *items) {
        if(items!=nil && items.count) {
            if(currentItem && currentItem.player && currentItem.player.delegate) {
                currentItem.player.delegate = nil;
            }
            currentItem = items[0];
            self.currentItem.player = [self.playerFactory playerForItem:self.currentItem];
            self.currentItem.player.delegate = self.delegate;
            dispatch_async(dispatch_get_main_queue(),^(){
                if(self.delegate && [self.delegate respondsToSelector:@selector(channel:hasReadyItem:)]) {
                    [self.delegate channel:self hasReadyItem:items[0]];
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(),^(){
                if(self.delegate && [self.delegate respondsToSelector:@selector(channel:hasReadyItem:)]) {
                    [self.delegate channel:self hasReadyItem:nil];
                }
            });
        }
    }];
}
-(void)play {
    if(self.currentItem!=nil) {
        self.currentItem.player.delegate = self.delegate;
        [self.currentItem.player play:self.currentItem];
    }
}
-(void)stop {
    if(self.currentItem!=nil) {
        self.currentItem.player.delegate = self.delegate;
        [self.currentItem.player stop];
    }
}
-(void)pause {
    if(self.currentItem!=nil) {
        self.currentItem.player.delegate = self.delegate;
        [self.currentItem.player pause];
    }
}
-(void)resume {
    if(self.currentItem!=nil) {
        self.currentItem.player.delegate = self.delegate;
        [self.currentItem.player resume];
    }
}

@end
