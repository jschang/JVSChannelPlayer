//
//  JVSTTSPlayer.h
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/7/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "JVSProtocols.h"

@protocol JVSTTSPlayerItem<JVSPlayerItem>
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* text;
@property (nonatomic,copy) NSString* language;
@end

@interface JVSTTSPlayer : NSObject<JVSPlayer,AVSpeechSynthesizerDelegate>
@end
