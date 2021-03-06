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
    [self setMinutes:0 andSeconds:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    _appDelegate.channelPlayer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setMinutes:(int)minutes andSeconds:(int)seconds {
    self.currentProgress.text = [NSString stringWithFormat:@"%.2d:%.2d",minutes,seconds];
}

- (IBAction)previousChannelTapped:(id)sender {
    [_appDelegate.channelPlayer stop];
    [_appDelegate.channelPlayer previousChannel];
    self.currentItemName.text = @"Loading...";
    [self setMinutes:0 andSeconds:0];
}

- (IBAction)nextChannelTapped:(id)sender {
    [_appDelegate.channelPlayer stop];
    [_appDelegate.channelPlayer nextChannel];
    self.currentItemName.text = @"Loading...";
    [self setMinutes:0 andSeconds:0];
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
    [self setMinutes:0 andSeconds:0];
}

- (IBAction)prevTapped:(id)sender {
    [_appDelegate.channelPlayer stop];
    [_appDelegate.channelPlayer previous];
    self.currentItemName.text = @"Loading...";
    [self setMinutes:0 andSeconds:0];
}

- (IBAction)nextTapped:(id)sender {
    [_appDelegate.channelPlayer stop];
    [_appDelegate.channelPlayer next];
    self.currentItemName.text = @"Loading...";
    [self setMinutes:0 andSeconds:0];
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
    NSLog(@"Channel has new item %@",item.articleUrl);
    self.currentChannelName.text = channel.title;
    [_appDelegate.channelPlayer play];
}

-(void)player:(id<JVSPlayer>)player didFinishItem:(DemoItemBase*)item {
    NSLog(@"Did finish item %@",item.articleUrl);
}
-(void)player:(id<JVSPlayer>)player didBeginItem:(DemoItemBase*)item {
    NSLog(@"Did begin item %@",item.articleUrl);
    self.currentItemName.text = item.title;
}
-(void)player:(id<JVSPlayer>)player didPauseItem:(DemoItemBase*)item {
    NSLog(@"Did pause item %@",item.articleUrl);
}
-(void)player:(id<JVSPlayer>)player didResumeItem:(DemoItemBase*)item {
    NSLog(@"Did resume item %@",item.articleUrl);
}
-(void)player:(id<JVSPlayer>)player didStopItem:(DemoItemBase*)item {
    NSLog(@"Did stop item %@",item.articleUrl);
}

-(void)player:(id<JVSPlayer>)player playingItem:(id<JVSPlayerItem>)item didProgress:(CMTime)time ofDuration:(CMTime)duration {
    double dTime = ((double)time.value/(double)time.timescale);
    int minutes = (int)(dTime / 60.0);
    int seconds = ((int)dTime) % 60;
    if(!CMTIME_IS_INDEFINITE(duration)) {
        double dDuration = ((double)duration.value/(double)duration.timescale);
        int durationMinutes = (int)(dDuration / 60.0);
        int durationSeconds = ((int)dDuration) % 60;
        self.currentProgress.text = [NSString stringWithFormat:@"%.2d:%.2d of %.2d:%2.d",minutes,seconds,durationMinutes,durationSeconds];
        [self.progressBar setProgress:dTime/dDuration animated:YES];
    } else {
        [self setMinutes:minutes andSeconds:seconds];
    }
}

@end
