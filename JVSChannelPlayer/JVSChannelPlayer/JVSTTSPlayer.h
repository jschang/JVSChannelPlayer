//
//  JVSTTSPlayer.h
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/7/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "JVSProtocols.h"

@protocol JVSTTSPlayerItem<JVSPlayerItem>
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* text;
@end

@interface JVSTTSPlayer : NSObject<JVSPlayer>

@end
