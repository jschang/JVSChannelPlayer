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

@property (nonatomic,strong) id<JVSPlayer> player;
@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *articleUrl;

@end
