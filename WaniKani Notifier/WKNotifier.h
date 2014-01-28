//
//  WKNotifier.h
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKNotifier : NSObject <NSUserNotificationCenterDelegate>
@property (nonatomic, strong, readonly) NSUserNotificationCenter* userNotificationCenter;

@property NSNumber* reviewsAvailable;
@property NSNumber* minReviews;
@property BOOL sound;

- (void)sendNotification;

@end
