//
//  WKStudyQueue.m
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/27/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import "WKStudyQueue.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKStudyQueue
- (void)updateWithDictionary: (NSDictionary*)dictionary
{
	self.lessonsAvailable = dictionary[@"lessons_available"];
  self.reviewsAvailable = dictionary[@"reviews_available"];
  self.nextReviewDate = dictionary[@"next_review_date"];
  self.reviewsAvailableNextHour = dictionary[@"reviews_available_next_hour"];
  self.reviewsAvailableNextDay = dictionary[@"reviews_available_next_day"];
}

@end
