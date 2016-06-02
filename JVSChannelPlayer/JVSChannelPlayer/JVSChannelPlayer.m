//
//  JVSChannelPlayer.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVSChannelPlayer.h"

@implementation JVSChannelPlayer

@synthesize channels;
@synthesize playerFactory;
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
}
-(void)removeChannel:(JVSChannel*)channel {
    [channels removeObject:channel];
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
