//
//  WKNotifier.h
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKNotifier : NSObject <NSUserNotificationCenterDelegate>

@property NSNumber *reviewsAvailable;

- (void)sendNotification;

@end
