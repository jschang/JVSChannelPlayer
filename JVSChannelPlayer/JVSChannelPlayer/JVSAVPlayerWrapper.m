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
@property (strong,nonatomic) id<JVSPlayerItem> currentItem;

@end

@implementation JVSAVPlayerWrapper

@synthesize avPlayer, delegate;

-(id)init {
    self = [super init];
    if(!self) return self;
    self.avPlayer = [[AVPlayer alloc] init];
    self.currentItem = nil;
    return self;
}

-(void)play:(id<JVSAVPlayerItem>)item {
    NSLog(@"JVSAVPlayerWrapper - mediaUrl:%@",item.mediaUrl);
    self.currentItem = item;
    AVPlayerItem *avItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:item.mediaUrl]];
    [avPlayer replaceCurrentItemWithPlayerItem:avItem];
    [avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1,10) 
        queue:nil 
        usingBlock:^(CMTime time) {
            if([self.delegate respondsToSelector:@selector(player:playingItem:didProgress:)]) {
                [self.delegate player:self playingItem:self.currentItem didProgress:time];
            }
        }];
    [avPlayer play];
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didBeginItem:)]) {
        [self.delegate player:self didBeginItem:item];
    }
}
-(void)pause {
    [avPlayer pause];
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didPauseItem:)]) {
        [self.delegate player:self didPauseItem:self.currentItem];
    }
}
-(void)resume {
    [avPlayer play];
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didResumeItem:)]) {
        [self.delegate player:self didResumeItem:self.currentItem];
    }
}
-(void)stop {
    [avPlayer pause];
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didStopItem:)]) {
        [self.delegate player:self didResumeItem:self.currentItem];
    }
}

@end
