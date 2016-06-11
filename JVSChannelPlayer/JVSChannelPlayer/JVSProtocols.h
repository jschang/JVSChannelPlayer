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

@class JVSChannel;
@class JVSChannelManager;

@protocol JVSPlayerItem <NSObject>
@property (nonatomic,strong) id<JVSPlayer> player;
@end

@protocol JVSAVPlayerItem<JVSPlayerItem>
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* mediaUrl;
@end

@protocol JVSTTSPlayerItem<JVSPlayerItem>
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* text;
@property (nonatomic,copy) NSString* language;
@end

/**
 * Player that plays a single item.  Multiple types may operate on a channel
 * Implement the JVSPlayerFactory to provide single instances of these.
 */
@protocol JVSPlayer <NSObject>
@required
@property (nonatomic,strong) id<JVSPlayerDelegate> delegate;
@property (nonatomic,assign,readonly) bool isPaused;
-(void)play:(id<JVSPlayerItem>)item;
-(void)stop;
-(void)pause;
-(void)resume;
@end

@protocol JVSPlayerDelegate <NSObject>
@optional
-(void)player:(id<JVSPlayer>)player didBeginItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didStopItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didFinishItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didPauseItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player didResumeItem:(id<JVSPlayerItem>)item;
-(void)player:(id<JVSPlayer>)player playingItem:(id<JVSPlayerItem>)item didProgress:(CMTime)time ofDuration:(CMTime)duration;
@end

@protocol JVSChannelDelegate <JVSPlayerDelegate>
@optional 
-(void)channel:(JVSChannel*)channel hasReadyItem:(id<JVSPlayerItem>)item;
@end

@protocol JVSChannelManagerDelegate <JVSChannelDelegate>
@optional
-(void)channelManager:(JVSChannelManager*)player didChangeTo:(JVSChannel*)newChannel from:(JVSChannel*)prevChannel;
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
-(void)addItem:(id<JVSPlayerItem>)item afterItem:(id<JVSPlayerItem>)prevItem;
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
@optional
-(id<JVSPlayerItem>)playerItemWithDict:(NSDictionary*)dict;
-(id<JVSPlayerItem>)playerItemWithItem:(id<JVSPlayerItem>)item;
-(id<JVSPlayerItem>)playerItemWithObject:(NSObject*)item;
@end

#endif /* JVSProtocols_h */
