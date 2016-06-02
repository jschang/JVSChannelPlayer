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

@implementation DemoPlayerFactory

-(id<JVSPlayer>)playerForItem:(id<JVSPlayerItem>)item {
    return [[JVSAVPlayerWrapper alloc] init];
}

@end
