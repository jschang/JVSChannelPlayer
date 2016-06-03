//
//  RSSOrAtomFeedParser.h
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/3/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MWFeedParser/MWFeedParser.h>

typedef void(^RSSOrAtomFeedAndThenBlock)(NSArray<MWFeedItem*> *items,NSError *error);
typedef void(^RSSOrAtomFeedOnInfoBlock)(MWFeedInfo* info);
typedef void(^RSSOrAtomFeedOnItemBlock)(MWFeedItem* item);

@interface RSSOrAtomFeedParser : NSObject<MWFeedParserDelegate>

+(RSSOrAtomFeedParser*) parseUrl:(NSString*)url 
        onInfo:(RSSOrAtomFeedOnInfoBlock)onInfo
        onItem:(RSSOrAtomFeedOnItemBlock)onItem
        andThen:(RSSOrAtomFeedAndThenBlock)andThen;

@end
