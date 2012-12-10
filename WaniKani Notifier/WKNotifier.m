//
//  WKNotifier.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKNotifier.h"

@implementation WKNotifier

- (void)sendNotification{
    NSString *notificationText;
    
    if([_reviewsAvailable intValue]==1){
        notificationText = [NSString stringWithFormat:@"There is one review available at Wanikani.com"];
    }
    else{
        notificationText = [NSString stringWithFormat:@"There are %@ reviews available at Wanikani.com", _reviewsAvailable];
    }
    
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    
    notification.title = @"Review Available!";
    notification.informativeText = notificationText;
    notification.soundName = @"review-time.mp3";
    notification.hasActionButton = TRUE;
    notification.actionButtonTitle = @"Open Review";
    [notification setOtherButtonTitle: @"Be Lazy :("];
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

@end
