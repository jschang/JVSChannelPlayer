//
//  AppDelegate.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JVSChannelPlayer/JVSChannelPlayer.h>
#import "DemoChannel.h"
#import "DemoItemFactory.h"
#import "DemoPlayerFactory.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JVSChannelManager *channelPlayer;

@end

