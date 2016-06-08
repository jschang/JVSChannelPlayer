//
//  ViewController.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Items/DemoItemBase.h"

@interface ViewController ()
@property (retain,nonatomic) AppDelegate* appDelegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(_appDelegate.channelPlayer.currentChannel) {
        self.currentChannelName.text = ((DemoChannel*)_appDelegate.channelPlayer.currentChannel).title;
    }
    _appDelegate.channelPlayer.delegate = self;
    self.currentItemName.text = @"Tap Play or Next";
    self.currentProgress.text = [NSString stringWithFormat:@"0:0"];
}

- (void)viewWillDisappear:(BOOL)animated {
    _appDelegate.channelPlayer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)previousChannelTapped:(id)sender {
    [_appDelegate.channelPlayer previousChannel];
}

- (IBAction)nextChannelTapped:(id)sender {
    [_appDelegate.channelPlayer nextChannel];
}

- (IBAction)playTapped:(id)sender {
    if( ![_appDelegate.channelPlayer hasReadyItem] ) {
        [_appDelegate.channelPlayer next];
    } else if( [_appDelegate.channelPlayer isPaused] ) {
        [_appDelegate.channelPlayer resume];
    } else {
        [_appDelegate.channelPlayer play];
    }
}

- (IBAction)pauseTapped:(id)sender {
    [_appDelegate.channelPlayer pause];
}

- (IBAction)stopTapped:(id)sender {
    [_appDelegate.channelPlayer stop];
    self.currentProgress.text = [NSString stringWithFormat:@"0:0"];
}

- (IBAction)prevTapped:(id)sender {
    [_appDelegate.channelPlayer previous];
}

- (IBAction)nextTapped:(id)sender {
    [_appDelegate.channelPlayer next];
}

-(void)channelManager:(JVSChannelManager*)manager didChangeTo:(DemoChannel*)newChannel from:(DemoChannel*)prevChannel {
    if(!newChannel) {
        [manager resetToFirstChannel];
    } else {
        self.currentChannelName.text = newChannel.title;
        [manager next];
    }
}

-(void)channel:(DemoChannel*)channel hasReadyItem:(DemoItemBase*)item {
    NSLog(@"Channel has new item");
    self.currentChannelName.text = channel.title;
    [channel play];
}

-(void)player:(id<JVSPlayer>)player didFinishItem:(DemoItemBase*)item {
    NSLog(@"Did finish item");
}
-(void)player:(id<JVSPlayer>)player didBeginItem:(DemoItemBase*)item {
    NSLog(@"Did begin item");
    self.currentItemName.text = item.title;
}
-(void)player:(id<JVSPlayer>)player didPauseItem:(DemoItemBase*)item {
    NSLog(@"Did pause item");
}
-(void)player:(id<JVSPlayer>)player didResumeItem:(DemoItemBase*)item {
    NSLog(@"Did resume item");
}

-(void)player:(id<JVSPlayer>)player playingItem:(id<JVSPlayerItem>)item didProgress:(CMTime)time {
    double dTime = ((double)time.value/(double)time.timescale);
    int minutes = (int)(dTime / 60.0);
    int seconds = ((int)dTime) % 60;
    self.currentProgress.text = [NSString stringWithFormat:@"%d:%d",minutes,seconds];
}

@end
