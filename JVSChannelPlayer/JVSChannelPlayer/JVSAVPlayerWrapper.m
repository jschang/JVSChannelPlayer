//
//  JVSAVPlayerWrapper.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/2/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "JVSAVPlayerWrapper.h"

@interface JVSAVPlayerWrapper()

@property (strong,nonatomic) AVPlayer *avPlayer;
@property (strong,nonatomic) id<JVSPlayerDelegate> delegate;

@end

@implementation JVSAVPlayerWrapper

@synthesize avPlayer, delegate;

-(id)init {
    self = [super init];
    if(!self) return self;
    self.avPlayer = [[AVPlayer alloc] init];
    return self;
}

-(void)play:(id<JVSPlayerItem>)item {
    [avPlayer replaceCurrentItemWithPlayerItem:(AVPlayerItem*)item];
    [avPlayer play];
}
-(void)pause {
    [avPlayer pause];
}
-(void)resume {
    [avPlayer play];
}
-(void)setDelegate:(id<JVSPlayerDelegate>)delegate {
    self.delegate = delegate;
}

@end
