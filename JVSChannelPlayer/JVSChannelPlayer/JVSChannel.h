//
//  JVSChannel.h
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVSChannelPlayer.h"

@interface JVSChannel : NSObject <JVSPlayerDelegate>

@property (retain,nonatomic) id<JVSPlayerItemSource> playerItemSource;
@property (retain,nonatomic) id<JVSPlayerFactory> playerFactory;
@property (retain,nonatomic) id<JVSPlayerDelegate> playerDelegate;

-(id<JVSPlayerItem>)nextItem;
-(id<JVSPlayerItem>)prevItem;

+(JVSChannel*)channelWithItemSource:(id<JVSPlayerItemSource>)source;
-(void)makeReady;

@end
