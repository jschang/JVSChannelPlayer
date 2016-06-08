//
//  AppDelegate.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 5/31/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <JVSChannelPlayer/JVSChannelPlayer.h>
#import "AppDelegate.h"
#import "ItemSources/WebRequestItemSource.h"
#import "ItemSources/LocalCacheItemSource.h"
#import "ItemSources/RSSOrAtomFeedParser.h"
#import <MagicalRecord/MagicalRecord.h>

@interface AppDelegate ()
@property (strong,nonatomic,retain) DemoItemFactory *itemFactory;
@end

@implementation AppDelegate 

@synthesize itemFactory, channelPlayer;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.channelPlayer = [[JVSChannelManager alloc] init];
    self.itemFactory = [[DemoItemFactory alloc] init];
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"JVSChannelPlayerDemo"];
    NSLog(@"%@",[NSPersistentStore MR_urlForStoreName:[MagicalRecord defaultStoreName]].path);
    
    //[self addChannel:4 withFetchCount:2 andTitle:@"Gizmodo" andUrl:@"http://feeds.gawker.com/gizmodo/full"];
    //[self addChannel:5 withFetchCount:2 andTitle:@"TechCrunch" andUrl:@"http://feeds.feedburner.com/TechCrunch/"];
    //[self addChannel:6 withFetchCount:2 andTitle:@"C-Net" andUrl:@"http://www.cnet.com/rss/news/"];
    [self addChannel:3 withFetchCount:2 andTitle:@"Get It Done" andUrl:@"http://www.quickanddirtytips.com/xml/getitdone.xml"];
    [self addChannel:1 withFetchCount:2 andTitle:@"The Memory Palace" andUrl:@"http://feeds.feedburner.com/thememorypalace?format=xml"];
    [self addChannel:2 withFetchCount:2 andTitle:@"The Economist - Money Talks" andUrl:@"https://feeds.feedburner.com/economst/audiovideo/moneytalks?format=xml"];
    
    [self.channelPlayer makeReady];
     
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(JVSChannel*)addChannel:(int)channelId withFetchCount:(int)itemCount andTitle:(NSString*)title andUrl:(NSString*)url {
    LocalCacheItemSource *localSource = [[LocalCacheItemSource alloc] init];
    WebRequestItemSource *webSource = [WebRequestItemSource 
            initWithItemCount:itemCount
            andChannelId:channelId
            andUrl:url
            andFactory:self.itemFactory];
    localSource.upstreamSource = webSource;
    DemoChannel* channel = [[DemoChannel alloc] init];
    channel.title = title;
    channel.playerFactory = [[DemoPlayerFactory alloc] init];
    channel.itemSource = localSource;
    [self.channelPlayer addChannel:channel];
    return channel;
}

@end
