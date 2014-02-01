//
//  WKStudyQueue.m
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/27/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import "WKStudyQueue.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WKStudyQueue ()
- (NSDate*)dateFromDateInSeconds: (NSNumber*)dateInSeconds;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKStudyQueue
- (void)updateWithDictionary: (NSDictionary*)dictionary
{
	self.lessonsAvailable = SAFE_NUMBER(dictionary[@"lessons_available"]);
  self.reviewsAvailable = SAFE_NUMBER(dictionary[@"reviews_available"]);
  self.nextReviewDate = [self dateFromDateInSeconds: SAFE_NUMBER(dictionary[@"next_review_date"])];
  self.reviewsAvailableNextHour = SAFE_NUMBER(dictionary[@"reviews_available_next_hour"]);
  self.reviewsAvailableNextDay = SAFE_NUMBER(dictionary[@"reviews_available_next_day"]);
}

- (NSDate*)dateFromDateInSeconds: (NSNumber*)dateInSeconds
{
	return [NSDate dateWithTimeIntervalSince1970: [dateInSeconds doubleValue]];
}

@end
