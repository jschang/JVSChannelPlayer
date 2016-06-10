//
//  DemoTTSItem.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/4/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoItemBase.h"

@interface DemoTTSItem : DemoItemBase<JVSTTSPlayerItem>

@property (nonatomic,strong) JVSAVPlayer* player;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *language;

@end
