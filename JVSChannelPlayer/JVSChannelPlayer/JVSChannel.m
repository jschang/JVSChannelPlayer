//
//  JVSChannel.m
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "JVSChannel.h"

@interface JVSChannel()
@property (retain,nonatomic) NSMutableArray *items;
@end

@implementation JVSChannel

@synthesize items;

-(id)init {
    self = [super init];
    if(self==nil) {
        return self;
    }
    self.items = [[NSMutableArray alloc] init];
    return self;
}

-(void)player:(id<JVSPlayer>)player didFinishItem:(id<JVSPlayerItem>)item {
    // evaluate caching policy
}
-(id<JVSPlayerItem>)playerWantsNextItem:(id<JVSPlayer>)player {
    return nil;
}
-(id<JVSPlayerItem>)playerWantsPrevItem:(id<JVSPlayer>)player {
    return nil;
}

@end
