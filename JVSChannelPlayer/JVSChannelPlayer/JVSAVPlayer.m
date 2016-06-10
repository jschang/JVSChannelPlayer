//
//  JVSAVPlayerWrapper.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/2/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "JVSAVPlayer.h"

@interface JVSAVPlayer()
@property (strong,nonatomic) AVPlayer *avPlayer;
@property (strong,nonatomic) id<JVSAVPlayerItem> currentItem;
@property (nonatomic,retain) dispatch_queue_t dispatchQueue;

@end

@implementation JVSAVPlayer

@synthesize avPlayer, delegate, isPaused, dispatchQueue;

-(id)init {
    self = [super init];
    if(!self) return self;
    self.avPlayer = [[AVPlayer alloc] init];
    self.currentItem = nil;
    isPaused = false;
    dispatchQueue = dispatch_queue_create("JVSAVPlayer", DISPATCH_QUEUE_CONCURRENT);
    return self;
}

-(void)play:(id<JVSAVPlayerItem>)item {
    dispatch_async(dispatchQueue, ^(){
        NSLog(@"JVSAVPlayer - mediaUrl:%@",item.mediaUrl);
        self.currentItem = item;
        AVPlayerItem *avItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:item.mediaUrl]];
        [avPlayer replaceCurrentItemWithPlayerItem:avItem];
        [avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1,10) 
            queue:nil 
            usingBlock:^(CMTime time) {
                if([self.delegate respondsToSelector:@selector(player:playingItem:didProgress:)]) {
                    dispatch_async(dispatch_get_main_queue(),^(){
                        [self.delegate player:self playingItem:self.currentItem didProgress:time];
                    });
                }
            }];
        [avPlayer setRate:1.0f];
        [avPlayer play];
        __block id<JVSAVPlayerItem> thisItem = self.currentItem;
        if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didBeginItem:)]) {
            dispatch_async(dispatch_get_main_queue(),^(){
                [self.delegate player:self didBeginItem:thisItem];
            });
        }
    });
}
-(void)pause {
    if(avPlayer.rate>0.0f) {
        isPaused = true;
        [avPlayer setRate:0.0f];
        [avPlayer pause];
        __block id<JVSAVPlayerItem> item = self.currentItem;
        if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didPauseItem:)]) {
            dispatch_async(dispatch_get_main_queue(),^(){
                [self.delegate player:self didPauseItem:item];
            });
        }
    }
}
-(void)resume {
    if(self.isPaused) {
        [avPlayer setRate:1.0f];
        [avPlayer play];
        __block id<JVSAVPlayerItem> item = self.currentItem;
        if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didResumeItem:)]) {
            dispatch_async(dispatch_get_main_queue(),^(){
                [self.delegate player:self didResumeItem:item];
            });
        }
    }
}
-(void)stop {
    if(avPlayer.rate>0.0f) {
        [avPlayer cancelPendingPrerolls];
        [avPlayer setRate:0.0f];
        [avPlayer pause];
        __block id<JVSAVPlayerItem> item = self.currentItem;
        if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didStopItem:)]) {
            dispatch_async(dispatch_get_main_queue(),^(){
                [self.delegate player:self didStopItem:item];
            });
        }
    }
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if(self.delegate && [self.delegate respondsToSelector:@selector(player:didFinishItem:)]) {
        __block id<JVSAVPlayerItem> item = self.currentItem;
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didFinishItem:item];
        });
    }
}

@end
