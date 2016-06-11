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
@end

@interface JVSTTSPlayer() 
@property (nonatomic,retain) dispatch_queue_t dispatchQueue;
@property (nonatomic,retain) NSMutableDictionary* itemsByUtter;
@end

@implementation JVSTTSPlayer

@synthesize synth, utter, voice, delegate, isPaused, dispatchQueue;

-(id)init {
    self = [super init];
    if(!self) return self;
    self.synth = [[AVSpeechSynthesizer alloc] init];
    self.synth.delegate = self;
    self.itemsByUtter = [[NSMutableDictionary alloc] init];
    dispatchQueue = dispatch_queue_create("JVSTTSPlayer", DISPATCH_QUEUE_CONCURRENT);
    self.currentItem = nil;
    isPaused = false;
    return self;
}
-(void)setCurrentItem:(id<JVSTTSPlayerItem>)item {
    _currentItem = item;
}
-(bool)isPaused {
    return synth.isPaused;
}
-(void)play:(id<JVSTTSPlayerItem>)item {
    dispatch_async(dispatchQueue, ^(){
        self.currentItem = item;
        if(self.currentItem) {
            self.currentItem = item;
            utter = [AVSpeechUtterance speechUtteranceWithString:item.text];
            [_itemsByUtter setObject:item forKey:utter.description];
            if(self.voice) {
                utter.voice = self.voice;
            }
            [synth speakUtterance:utter];
            NSLog(@"utterance.description=%@",utter.description);
        }
    });
}
-(void)pause {
    dispatch_async(dispatchQueue, ^(){
        if(self.currentItem && synth.isSpeaking) {
            [synth pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        }
    });
}
-(void)resume {
    dispatch_async(dispatchQueue, ^(){
        if(self.currentItem && synth.isPaused) {
            [synth continueSpeaking];
        }
    });
}
-(void)stop {
    dispatch_async(dispatchQueue, ^(){ 
        if(self.currentItem && synth.isSpeaking) {
            [synth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        }
    });
}

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    dispatch_async(dispatch_get_main_queue(),^(){
        id<JVSTTSPlayerItem> item = _itemsByUtter[utterance.description];
        if(self.delegate && item && [self.delegate respondsToSelector:@selector(player:didPauseItem:)]) {
            [self.delegate player:self didPauseItem:item];
        }
    });
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    dispatch_async(dispatch_get_main_queue(),^(){
        id<JVSTTSPlayerItem> item = _itemsByUtter[utterance.description];
        if(self.delegate && item && [self.delegate respondsToSelector:@selector(player:didBeginItem:)]) {
            [self.delegate player:self didBeginItem:item];
        }
    });
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    dispatch_async(dispatch_get_main_queue(),^(){
        id<JVSTTSPlayerItem> item = _itemsByUtter[utterance.description];
        if(self.delegate && item && [self.delegate respondsToSelector:@selector(player:didResumeItem:)]) {
            [self.delegate player:self didResumeItem:item];
        }
    });
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    dispatch_async(dispatch_get_main_queue(),^(){
        id<JVSTTSPlayerItem> item = _itemsByUtter[utterance.description];
        if(self.delegate && item && [self.delegate respondsToSelector:@selector(player:didStopItem:)]) {
            [self.delegate player:self didStopItem:item];
        }
        NSLog(@"removing utterance item:%@",utterance.description);
        [_itemsByUtter removeObjectForKey:utterance.description];
    });
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    dispatch_async(dispatch_get_main_queue(),^(){
        id<JVSTTSPlayerItem> item = _itemsByUtter[utterance.description];
        if(self.delegate && item && [self.delegate respondsToSelector:@selector(player:didFinishItem:)]) {
            [self.delegate player:self didFinishItem:item];
        }
        NSLog(@"removing utterance item:%@",utterance.description);
        [_itemsByUtter removeObjectForKey:utterance.description];
    });
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
}

@end
