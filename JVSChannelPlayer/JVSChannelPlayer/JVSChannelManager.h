//
//  JVSChannelPlayer.h
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "JVSProtocols.h"
#import "JVSChannel.h"
#import "JVSAVPlayer.h"
#import "JVSTTSPlayer.h"

@class JVSChannel;
@class JVSChannelManager;

@interface JVSChannelManager : NSObject

@property (retain,nonatomic,readonly) NSMutableArray* channels;
@property (retain,nonatomic,readonly) JVSChannel* currentChannel;
@property (retain,nonatomic) id<JVSChannelManagerDelegate> delegate;

-(void)addChannel:(JVSChannel*)channel;
-(void)removeChannel:(JVSChannel*)channel;
-(JVSChannel*)nextChannel;
-(JVSChannel*)previousChannel;
-(void)resetToFirstChannel;
-(bool)isPaused;
-(bool)hasReadyItem;

-(void)play;
-(void)pause;
-(void)resume;
-(void)stop;
-(void)next;
-(void)previous;

/**
 * Call once you've added all your channels...
 * cascades through all channels and item sources
 */
-(void)makeReady;

@end