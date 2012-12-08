//
//  WKNotifier.h
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@class SBJsonStreamParser;
@class SBJsonStreamParserAdapter;

@interface WKNotifier : NSObject <NSUserNotificationCenterDelegate>{
    NSURLConnection *theConnection;
    SBJsonStreamParser *parser;
    SBJsonStreamParserAdapter *adapter;
}

- (void)checkReviews:(NSString*)apiKey;
- (void)sendNotification:(int)reviewNumber;

@end
