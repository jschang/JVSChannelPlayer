//
//  DemoPlayerFactory.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/2/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "DemoPlayerFactory.h"
#import <AVFoundation/AVFoundation.h>
#import <JVSChannelPlayer/JVSChannelPlayer.h>

JVSAVPlayerWrapper* jvsAVPlayer;
JVSTTSPlayer* jvsTTSPlayer;

@implementation DemoPlayerFactory

+(void) initialize {
    jvsTTSPlayer = [[JVSTTSPlayer alloc] init];
    jvsAVPlayer = [[JVSAVPlayerWrapper alloc] init];
}

-(id<JVSPlayer>)playerForItem:(id<JVSPlayerItem>)item {
    if([item conformsToProtocol:@protocol(JVSAVPlayerItem)]) {
        return jvsAVPlayer;
    } else if([item conformsToProtocol:@protocol(JVSTTSPlayerItem)]) {
        return jvsTTSPlayer;
    }
    return nil;
}

@end
