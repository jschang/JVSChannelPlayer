//
//  DemoAudioItem.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/4/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoItemBase.h"

@interface DemoAVItem : DemoItemBase

@property (nonatomic,readonly,strong) NSString *mediaUrl;
@property (nonatomic,readonly) bool isVideo;

@end
