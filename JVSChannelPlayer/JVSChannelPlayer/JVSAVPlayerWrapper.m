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

@end

@implementation JVSAVPlayerWrapper

@synthesize avPlayer, delegate;

-(id)init {
    self = [super init];
    if(!self) return self;
    self.avPlayer = [[AVPlayer alloc] init];
    return self;
}

-(void)play:(id<JVSAVPlayerItem>)item {
    NSLog(@"JVSAVPlayerWrapper - mediaUrl:%@",item.mediaUrl);
    AVPlayerItem *avItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:item.mediaUrl]];
    [avPlayer replaceCurrentItemWithPlayerItem:avItem];
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
