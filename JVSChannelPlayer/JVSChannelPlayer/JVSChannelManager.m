//
//  JVSChannelPlayer.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVSChannelManager.h"

@interface JVSChannelManager() 
@property (nonatomic,retain) dispatch_queue_t dispatchQueue;
@end

@implementation JVSChannelManager

@synthesize dispatchQueue;
@synthesize channels;
@synthesize currentChannel;
@synthesize delegate;

-(id)init {
    self = [super init];
    if(!self) {
        return self;
    }
    dispatchQueue = dispatch_queue_create("JVSChannelManager", DISPATCH_QUEUE_CONCURRENT);
    channels = [[NSMutableArray alloc] init];
    return self;
}

-(void)makeReady {
    dispatch_async(dispatchQueue,^(){
        for(JVSChannel *channel in self.channels) {
            [channel makeReady];
        }
    });
}

-(void)addChannel:(JVSChannel*)channel {
    [self removeChannel:channel];
    [channels addObject:channel];
    currentChannel = channel;
}

-(void)removeChannel:(JVSChannel*)channel {
    [channels removeObject:channel];
    if(self.currentChannel == channel && self.channels.count>0) {
        currentChannel = self.channels[0];
    }
}

-(JVSChannel*)nextChannel {
    int idx = [self.channels indexOfObject:self.currentChannel];
    JVSChannel *previousChannel = self.currentChannel;
    if([self.channels count]>(idx+1)) {
        currentChannel = self.channels[idx+1];
    } else {
        currentChannel = nil;
    }
    if(delegate && [delegate respondsToSelector:@selector(channelManager:didChangeTo:from:)]) {
        [delegate channelManager:self didChangeTo:currentChannel from:previousChannel];
    }
    return currentChannel;
}

-(JVSChannel*)previousChannel {
    int idx = [self.channels indexOfObject:self.currentChannel];
    JVSChannel *previousChannel = self.currentChannel;
    if(idx!=NSNotFound && (idx-1)>=0) {
        currentChannel = self.channels[idx-1];
    } else if(channels.count>0) {
        currentChannel = channels[channels.count-1];
    } else {
        currentChannel = nil;
    }
    if(delegate && [delegate respondsToSelector:@selector(channelManager:didChangeTo:from:)]) {
        [delegate channelManager:self didChangeTo:currentChannel from:previousChannel];
    }
    return currentChannel;
}

-(void)resetToFirstChannel {
    JVSChannel *previousChannel = self.currentChannel;
    if(self.channels.count>0) {
        currentChannel = channels[0];
    }
    if(delegate && [delegate respondsToSelector:@selector(channelManager:didChangeTo:from:)]) {
        [delegate channelManager:self didChangeTo:currentChannel from:previousChannel];
    }
}

-(bool) isPaused {
    if(currentChannel) {
        return [currentChannel isPaused];
    } else {
        return NO;
    }
}

-(bool) hasReadyItem {
    if(currentChannel && currentChannel.currentItem) {
        return YES;
    } else {
        return NO;
    }
}

-(void)play {
    if(currentChannel) {
        currentChannel.delegate = self.delegate;
        [currentChannel play];
    }
}
-(void)pause {
    if(currentChannel) {
        currentChannel.delegate = self.delegate;
        [currentChannel pause];
    }
}
-(void)stop {
    if(currentChannel) {
        currentChannel.delegate = self.delegate;
        [currentChannel stop];
    }
}
-(void)next {
    if(currentChannel) {
        currentChannel.delegate = self.delegate;
        [currentChannel next];
    }
}
-(void)previous {
    if(currentChannel) {
        currentChannel.delegate = self.delegate;
        [currentChannel previous];
    }
}
-(void)resume {
    if(currentChannel) {
        currentChannel.delegate = self.delegate;
        [currentChannel resume];
    }
}

@end
