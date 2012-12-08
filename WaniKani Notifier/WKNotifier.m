//
//  WKNotifier.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKNotifier.h"

@implementation WKNotifier

- (void)checkReviews:(NSString*)apiKey{
    NSString *apiCall = [NSString stringWithFormat:@"http://www.wanikani.com/api/user/%@/study-queue", apiKey];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiCall]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *error = nil;
    
    id jsonObject = [jsonParser objectWithString:jsonString error:&error];
    
    NSDictionary *requestedInformation = [jsonObject objectForKey:@"requested_information"];
    NSString *reviewsAvailable = [requestedInformation objectForKey:@"reviews_available"];
    
//    NSLog(@"%@",jsonObject);
//    NSLog(@"%@",[jsonObject objectForKey:@"requested_information"]);
//    NSLog(@"%@",requestedInformation);
//    NSLog(@"reviewsAvailable: %@",reviewsAvailable);
 
    if([reviewsAvailable intValue]!=0){
        [self sendNotification:[reviewsAvailable intValue]];
    }
}

- (void)sendNotification:(int)reviewNumber{
    NSString *notificationText;
    
    if(reviewNumber==1){
        notificationText = [NSString stringWithFormat:@"There is one review available at Wanikani.com"];
    }
    else{
        notificationText = [NSString stringWithFormat:@"There are %d reviews available at Wanikani.com", reviewNumber];
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
