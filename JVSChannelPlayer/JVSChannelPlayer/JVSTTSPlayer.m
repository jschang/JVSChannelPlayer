//
//  JVSTTSPlayer.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/7/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "JVSTTSPlayer.h"

@interface JVSTTSPlayer()
@property (strong,nonatomic) id<JVSTTSPlayerItem> currentItem;
@property (retain,nonatomic) AVSpeechSynthesizer *synth;
@property (retain,nonatomic) AVSpeechUtterance *utter;
@property (retain,nonatomic) AVSpeechSynthesisVoice *voice;
@property (retain,nonatomic) NSArray<AVSpeechSynthesisVoice*> *voices; 
@end

@implementation JVSTTSPlayer

@synthesize synth, utter, voice, voices, delegate, isPaused;

-(id)init {
    self = [super init];
    if(!self) return self;
    //self.synth = [[AVSpeechSynthesizer alloc] init];
    //self.voices = [AVSpeechSynthesisVoice speechVoices];
    //self.voice = self.voices[0];
    self.currentItem = nil;
    isPaused = false;
    return self;
}
-(void)play:(id<JVSTTSPlayerItem>)item {
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didBeginItem:)]) {
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didBeginItem:item];
        });
    }
}
-(void)pause {
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didPauseItem:)]) {
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didPauseItem:self.currentItem];
        });
    }
}
-(void)resume {
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didResumeItem:)]) {
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didResumeItem:self.currentItem];
        });
    }
}
-(void)stop {
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(player:didStopItem:)]) {
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didResumeItem:self.currentItem];
        });
    }
}

@end
