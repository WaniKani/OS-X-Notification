//
//  WKStudyQueue.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/27/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKApiDataContainer.h"

@interface WKStudyQueue : NSObject <WKApiDataContainer>
@property NSNumber*		lessonsAvailable;
@property NSNumber*		reviewsAvailable;
@property NSDate*			nextReviewDate;
@property NSNumber*		reviewsAvailableNextHour;
@property NSNumber*		reviewsAvailableNextDay;
@end
