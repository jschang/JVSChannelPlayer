//
//  WebRequestItemSource.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JVSChannelPlayer/JVSChannelPlayer.h>

@interface WebRequestItemSource : NSObject<JVSPlayerItemSource>

@property (strong,nonatomic) id<JVSPlayerItemFactory> itemFactory;
@property (nonatomic) int itemCount;
@property (nonatomic) int channelId;
@property (copy,nonatomic) NSString *url;

+(WebRequestItemSource*)initWithItemCount:(int)count 
        andChannelId:(int)channelId 
        andUrl:(NSString*)url
        andFactory:(id<JVSPlayerItemFactory>)factory;

@end
