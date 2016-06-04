//
//  DemoItemFactory.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/1/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <JVSChannelPlayer/JVSChannelPlayer.h>
#import "DemoItemFactory.h"

@implementation DemoItemFactory

/**
 * Implement this one when pulling directly from the web,
 * prolly a json source.
 */
-(id<JVSPlayerItem>)playerItemWithDict:(NSDictionary*)dict {
    return nil;
}

/**
 * Implement this one to pull from CoreData,
 * when wrapping a player item source that pulls from the web.
 */
-(id<JVSPlayerItem>)playerItemWithItem:(id<JVSPlayerItem>)item {
    return nil;
}

@end
