//
//  JVSChannel.h
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVSChannelManager.h"

@interface JVSChannel : NSObject <JVSPlayer>

@property (retain,nonatomic) id<JVSPlayerFactory> playerFactory;
@property (retain,nonatomic) id<JVSPlayerItemSource> itemSource;
@property (retain,nonatomic) id<JVSChannelDelegate> delegate;
@property (nonatomic,retain,readonly) id<JVSPlayerItem> currentItem;

+(JVSChannel*)channelWithItemSource:(id<JVSPlayerItemSource>)source;
-(void)makeReady;
-(bool)isPaused;

-(void)next;
-(void)previous;
-(void)play;
-(void)stop;
-(void)pause;
-(void)resume;

@end
