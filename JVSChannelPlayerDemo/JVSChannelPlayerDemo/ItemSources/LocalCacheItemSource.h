//
//  LocalCacheItemSource.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JVSChannelPlayer/JVSChannelPlayer.h>

@interface LocalCacheItemSource : NSObject<JVSPlayerItemSource>

@property (strong,nonatomic) id<JVSPlayerItemSource> upstreamSource;

@end
