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

@interface JVSTTSPlayer : NSObject<JVSPlayer,AVSpeechSynthesizerDelegate>
@property (retain,nonatomic) AVSpeechSynthesisVoice *voice;
@end
