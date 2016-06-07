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

@protocol JVSAVPlayerItem<JVSPlayerItem,AVAudioPlayerDelegate>
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* mediaUrl;
@end

@interface JVSAVPlayerWrapper : NSObject<JVSPlayer>

@end
