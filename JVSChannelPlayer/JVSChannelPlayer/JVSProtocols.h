//
//  JVSProtocols.h
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#ifndef JVSProtocols_h
#define JVSProtocols_h

#import <CoreMedia/CoreMedia.h>

@protocol JVSPlayerItem;
@protocol JVSPlayer;
@protocol JVSPlayerDelegate;
@protocol JVSPlayerItemSource;
@protocol JVSPlayerFactory;
@protocol JVSPlayerItemFactory;

@protocol JVSPlayerItem <NSObject>
/**
 * A unique id for the item
 */
-(id)getItemId;
/**
 * Returns the object that corresponds to whatever the player factory
 * can actually play.
 */
-(id)getPlayable;
@end

/**
 * Player that plays a single item.  Multiple types may operate on a channel
 * Implement the JVSPlayerFactory to provide single instances of these.
 */
@protocol JVSPlayer <NSObject>
@required
-(void)play:(id<JVSPlayerItem>)item;
-(void)pause;
-(void)resume;
-(void)setDelegate:(id<JVSPlayerDelegate>)delegate;
@end

@protocol JVSPlayerDelegate <NSObject>
@optional
-(void)player:(id<JVSPlayer>)player didFinishItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didBeginItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didPauseItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didResumeItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player playingItem:(id<JVSPlayerItem>)item didProgress:(CMTime)time;
@end

/**
 * Implement a generic version of these that can handle 
 * manage the items on a single channel.
 * The number of items it will fetch is up to your implementation.
 * You may implement two of these...one that uses local cache,
 * then wrap that in one that fetches from the web.
 */
@protocol JVSPlayerItemSource <NSObject>
@required
-(void)makeItemSourceReadyAndThen:(void(^)())andThen;
/**
 * If afterItem is nil, then tacked onto the end.
 * If afterItem is not nil, then inserted after.
 * Case when we want to add to head is not supported.
 */
-(void)addItem:(id<JVSPlayerItem>)item afterItem:(id<JVSPlayerItem>)item;
-(void)fetchItem:(NSInteger)itemId andThen:(void(^)(id<JVSPlayerItem> item))andThen;
-(void)fetchItemsAfter:(id<JVSPlayerItem>)item withCount:(NSInteger)count andThen:(void(^)(NSArray* items))andThen;
-(void)fetchItemsBefore:(id<JVSPlayerItem>)item withCount:(NSInteger)count andThen:(void(^)(NSArray* items))andThen;
@end

/**
 * Implement a generic version of this that can return a player impl
 * for each of the item types you have.
 */
@protocol JVSPlayerFactory <NSObject>
@required
-(id<JVSPlayer>)playerForItem:(id<JVSPlayerItem>)item;
@end

/**
 * Implement a version of this that can create a player items
 */
@protocol JVSPlayerItemFactory <NSObject>
@required
/**
 * Implement this one when pulling directly from the web,
 * prolly a json source.
 */
-(id<JVSPlayerItem>)playerItemWithDict:(NSDictionary*)dict;
/**
 * Implement this one to pull from CoreData,
 * when wrapping a player item source that pulls from the web.
 */
-(id<JVSPlayerItem>)playerItemWithItem:(id<JVSPlayerItem>)dict;
@end

#endif /* JVSProtocols_h */
