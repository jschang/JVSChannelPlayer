//
//  JVSChannelPlayer.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVSChannelManager.h"

@implementation JVSChannelManager

@synthesize channels;
@synthesize currentChannel;

-(id)init {
    self = [super init];
    if(!self) {
        return self;
    }
    channels = [[NSMutableArray alloc] init];
    return self;
}

-(void)makeReady {
    for(JVSChannel *channel in self.channels) {
        [channel makeReady];
    }
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
    if([self.channels count]>=(idx+1)) {
        currentChannel = self.channels[idx+1];
    } else {
        currentChannel = nil;
    }
    return currentChannel;
}
-(JVSChannel*)prevChannel {
    int idx = [self.channels indexOfObject:self.currentChannel];
    if(idx!=NSNotFound && (idx-1)>=0) {
        currentChannel = self.channels[idx-1];
    } else {
        currentChannel = nil;
    }
    return currentChannel;
}

@end
