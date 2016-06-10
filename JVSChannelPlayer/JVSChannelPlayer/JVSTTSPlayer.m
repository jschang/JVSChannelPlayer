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

@interface JVSTTSPlayer() 
@property (nonatomic,retain) dispatch_queue_t dispatchQueue;
@end

@implementation JVSTTSPlayer

@synthesize synth, utter, voice, voices, delegate, isPaused, dispatchQueue;

-(id)init {
    self = [super init];
    if(!self) return self;
    self.synth = [[AVSpeechSynthesizer alloc] init];
    self.synth.delegate = self;
    //self.voices = [AVSpeechSynthesisVoice speechVoices];
    dispatchQueue = dispatch_queue_create("JVSTTSPlayer", DISPATCH_QUEUE_CONCURRENT);
    self.currentItem = nil;
    isPaused = false;
    return self;
}
-(void)setCurrentItem:(id<JVSTTSPlayerItem>)item {
    /*NSMutableArray *localVoices = [[NSMutableArray alloc] init]; 
    for(AVSpeechSynthesisVoice *voice in voices) {
        if([voice.language isEqualToString:item.language]) {
            [localVoices addObject:voice];
        }
    }
    if(localVoices.count==0) {
        self.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en"];
    } else {
        self.voice = localVoices[(int)(localVoices.count * ((float)rand() / RAND_MAX))];
    }*/
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
            //utter.voice = self.voice;
            [synth speakUtterance:utter];
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
    if(self.delegate && self.currentItem && [self.delegate respondsToSelector:@selector(player:didPauseItem:)]) {
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didPauseItem:self.currentItem];
        });
    }
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    if(self.delegate && self.currentItem && [self.delegate respondsToSelector:@selector(player:didBeginItem:)]) {
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didBeginItem:self.currentItem];
        });
    }
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    if(self.delegate && self.currentItem && [self.delegate respondsToSelector:@selector(player:didStopItem:)]) {
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didStopItem:self.currentItem];
        });
    }
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    if(self.delegate && self.currentItem && [self.delegate respondsToSelector:@selector(player:didFinishItem:)]) {
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didFinishItem:self.currentItem];
        });
    }
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    if(self.delegate && self.currentItem && [self.delegate respondsToSelector:@selector(player:didResumeItem:)]) {
        dispatch_async(dispatch_get_main_queue(),^(){
            [self.delegate player:self didResumeItem:self.currentItem];
        });
    }
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
}

@end
