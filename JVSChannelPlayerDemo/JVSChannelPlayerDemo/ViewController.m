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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playTapped:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(appDelegate.channelPlayer.currentChannel!=nil) {
        appDelegate.channelPlayer.currentChannel.delegate = self;
        [appDelegate.channelPlayer.currentChannel play];
    }
}

- (IBAction)prevTapped:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(appDelegate.channelPlayer.currentChannel!=nil) {
        appDelegate.channelPlayer.currentChannel.delegate = self;
        [appDelegate.channelPlayer.currentChannel previous];
    }
}

- (IBAction)nextTapped:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(appDelegate.channelPlayer.currentChannel!=nil) {
        appDelegate.channelPlayer.currentChannel.delegate = self;
        [appDelegate.channelPlayer.currentChannel next];
    }
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
    int minutes = (int)(dTime/60.0);
    self.currentProgress.text = [NSString stringWithFormat:@"%d:%f",minutes,dTime-minutes];
}

@end
