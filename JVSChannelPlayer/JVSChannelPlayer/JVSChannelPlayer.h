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

@protocol JVSPlayerItem
-(NSInteger)getItemId;
@end

@protocol JVSPlayer
-(void)play:(id<JVSPlayerItem>)item;
-(void)pause;
-(void)resume;
@end

@protocol JVSPlayerDelegate
-(void)player:(id<JVSPlayer>)player didFinishItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didBeginItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didPauseItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didResumeItem:(id<JVSPlayerItem>)item;
-(id<JVSPlayerItem>)playerWantsNextItem:(id<JVSPlayer>)player;
-(id<JVSPlayerItem>)playerWantsPrevItem:(id<JVSPlayer>)player;
@end

@protocol JVSPlayerItemSource
-(NSArray*)fetchMorePlayerItems;
@end

@protocol JVSPlayerFactory
-(id<JVSPlayer>)playerForItem:(id<JVSPlayerItem>)item;
@end

@protocol JVSPlayerItemFactory
-(id<JVSPlayerItem>)playerItemWithDict:(NSDictionary*)dict;
@end

#include "JVSChannel.h"