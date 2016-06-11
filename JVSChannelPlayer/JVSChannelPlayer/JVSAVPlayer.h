//
//  JVSAVPlayerWrapper.h
//  JVSChannelPlayer
//
//  Created by Jonathan Schang on 6/2/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "JVSProtocols.h"

@interface JVSAVPlayer : NSObject<JVSPlayer,AVAudioPlayerDelegate>
@end
