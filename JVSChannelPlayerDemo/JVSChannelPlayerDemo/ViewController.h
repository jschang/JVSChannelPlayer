//
//  ViewController.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JVSChannelPlayer/JVSChannelPlayer.h>

@interface ViewController : UIViewController<JVSChannelManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currentChannelName;
@property (weak, nonatomic) IBOutlet UILabel *currentItemName;
@property (weak, nonatomic) IBOutlet UILabel *currentProgress;

@end

