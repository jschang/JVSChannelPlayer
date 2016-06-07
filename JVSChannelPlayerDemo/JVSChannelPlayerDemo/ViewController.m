//
//  ViewController.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

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

-(void)player:(id<JVSPlayer>)player didFinishItem:(id<JVSPlayerItem>)item {
    NSLog(@"Did finish item");
}
-(void)player:(id<JVSPlayer>)player didBeginItem:(id<JVSPlayerItem>)item {
    NSLog(@"Did begin item");
}
-(void)player:(id<JVSPlayer>)player didPauseItem:(id<JVSPlayerItem>)item {
    NSLog(@"Did pause item");
}
-(void)player:(id<JVSPlayer>)player didResumeItem:(id<JVSPlayerItem>)item {
    NSLog(@"Did resume item");
}

@end
