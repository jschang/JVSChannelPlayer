//
//  RSSOrAtomFeedParser.m
//  JVSChannelPlayerDemo
//
//  Created by Jonathan Schang on 6/3/16.
//  Copyright © 2016 Jon Schang. All rights reserved.
//

#import "RSSOrAtomFeedParser.h"
#import <MWFeedParser/MWFeedParser.h>

@interface RSSOrAtomFeedParser()

@property (nonatomic,strong,retain) RSSOrAtomFeedAndThenBlock andThen;
@property (nonatomic,strong,retain) RSSOrAtomFeedOnInfoBlock onInfo; 
@property (nonatomic,strong,retain) RSSOrAtomFeedOnItemBlock onItem; 
@property (nonatomic,strong,retain) NSMutableArray<MWFeedItem*>* parsedItems;
@property (nonatomic,strong,retain) MWFeedParser *feedParser;

@end

@implementation RSSOrAtomFeedParser

@synthesize andThen;
@synthesize onInfo;
@synthesize onItem;
@synthesize parsedItems;
@synthesize feedParser;

+(RSSOrAtomFeedParser*) parseUrl:(NSString*)url 
        onInfo:(RSSOrAtomFeedOnInfoBlock)onInfo
        onItem:(RSSOrAtomFeedOnItemBlock)onItem
        andThen:(RSSOrAtomFeedAndThenBlock)andThen {
    RSSOrAtomFeedParser* parser = [[RSSOrAtomFeedParser alloc] init];
    parser.andThen = andThen;
    parser.onItem = onItem;
    parser.onInfo = onInfo;
    parser.parsedItems = [[NSMutableArray<MWFeedItem*> alloc] init];
    // Create feed parser and pass the URL of the feed
    NSURL *feedURL = [NSURL URLWithString:url];
    parser.feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    parser.feedParser.delegate = parser;
    parser.feedParser.feedParseType = ParseTypeFull;
    parser.feedParser.connectionType = ConnectionTypeAsynchronously;
    dispatch_async(dispatch_get_main_queue(),^{
        [parser.feedParser parse];
    });
    return parser;
}

#pragma mark - MWFeedParser Methods

- (void)feedParserDidStart:(MWFeedParser *)parser {
    // Called when dataMWFeedItem has downloaded and parsing has begun
}
- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    if(onInfo!=nil) {
        onInfo(info);
    }
}
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    // Provides info about a feed item
    [self.parsedItems addObject:item];
    if(onItem!=nil) {
        self.onItem(item);
    }
}
- (void)feedParserDidFinish:(MWFeedParser *)parser {
    // Parsing complete or stopped at any time by `stopParsing`
    if(andThen!=nil) {
        self.andThen(self.parsedItems, nil);
    }
}
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    // Parsing failed
    if(andThen!=nil) {
        self.andThen(self.parsedItems, error);
    }
}

@end
