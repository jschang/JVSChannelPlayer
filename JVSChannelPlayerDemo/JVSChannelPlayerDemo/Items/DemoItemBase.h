//
//  DemoItemBase.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/4/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JVSChannelPlayer/JVSChannelPlayer.h>

@interface DemoItemBase : NSObject<JVSPlayerItem>

@property (nonatomic,readonly,strong) NSNumber *id;
@property (nonatomic,readonly,strong) NSString *author;
@property (nonatomic,readonly,strong) NSString *title;
@property (nonatomic,readonly,strong) NSString *articleUrl;

@end
