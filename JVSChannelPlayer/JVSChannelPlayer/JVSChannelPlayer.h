//
//  JVSChannelPlayer.h
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for JVSChannelPlayer.
FOUNDATION_EXPORT double JVSChannelPlayerVersionNumber;

//! Project version string for JVSChannelPlayer.
FOUNDATION_EXPORT const unsigned char JVSChannelPlayerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <JVSChannelPlayer/PublicHeader.h>

#import "JVSProtocols.h"
#import "JVSChannel.h"
#import "JVSAVPlayerWrapper.h"

@class JVSChannel;

@interface JVSChannelPlayer : NSObject

@property (retain,nonatomic,readonly) NSMutableArray* channels;
@property (retain,nonatomic,readonly) JVSChannel* currentChannel;

@property (retain,nonatomic) id<JVSPlayerFactory> playerFactory;

-(void)addChannel:(JVSChannel*)channel;
-(void)removeChannel:(JVSChannel*)channel;
-(JVSChannel*)nextChannel;
-(JVSChannel*)prevChannel;

/**
 * Call once you've added all your channels...
 * cascades through all channels and item sources
 */
-(void)makeReady;

@end