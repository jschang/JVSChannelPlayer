//
//  DemoAudioItem.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/4/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoItemBase.h"

@interface DemoAVItem : DemoItemBase<JVSAVPlayerItem>

@property (nonatomic,strong) NSString *mediaUrl;
@property (nonatomic) bool isVideo;

@end
