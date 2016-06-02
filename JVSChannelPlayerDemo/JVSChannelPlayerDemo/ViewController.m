//
//  ViewController.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "ViewController.h"

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
}

- (IBAction)prevTapped:(id)sender {
}

- (IBAction)nextTapped:(id)sender {
}

-(void)player:(id<JVSPlayer>)player didFinishItem:(id<JVSPlayerItem>)item {
}
-(void)player:(id<JVSPlayer>)player didBeginItem:(id<JVSPlayerItem>)item {
}
-(void)player:(id<JVSPlayer>)player didPauseItem:(id<JVSPlayerItem>)item {
}
-(void)player:(id<JVSPlayer>)player didResumeItem:(id<JVSPlayerItem>)item {
}

@end
