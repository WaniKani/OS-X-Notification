//
//  WKApi.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKApi.h"

@interface WKApi ()
- (NSURL*)apiUrlWithPath: (NSString*)path;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKApi

- (NSURL*)apiUrlWithPath: (NSString*)path
{
  NSString* urlString = [NSString stringWithFormat: @"https://www.wanikani.com/api/user/%@/%@",
                         _apiKey,
                         path];

  return [NSURL URLWithString: urlString];
}

- (void)updateAllData
{
  [self updateLevelProgression];
  [self updateStudyQueue];
  [self updateUserInfo];
}

- (void)updateUserInfo
{
  NSURL* apiURL = [self apiUrlWithPath: @"user-information"];
  NSURLRequest* request = [NSURLRequest requestWithURL: apiURL];
  NSData* response = [NSURLConnection sendSynchronousRequest: request
                                           returningResponse: nil
                                                       error: nil];
  NSString* jsonString = [[NSString alloc] initWithData: response
                                               encoding: NSUTF8StringEncoding];

  SBJsonParser* jsonParser = [[SBJsonParser alloc] init];
  NSError* error = nil;

  id jsonObject = [jsonParser objectWithString: jsonString
                                         error: &error];

  NSDictionary* requestedInformation = [jsonObject objectForKey: @"user_information"];

  _username = [requestedInformation objectForKey: @"username"];
  NSString* gravatId = [requestedInformation objectForKey: @"gravatar"];
  _gravatar = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.gravatar.com/avatar/%@?s=180", gravatId]];
  _level = [requestedInformation objectForKey: @"level"];
  _title = [requestedInformation objectForKey: @"title"];
  _creationDate = [requestedInformation objectForKey: @"creation_date"];
}

- (void)updateStudyQueue
{
  NSURL* apiURL = [self apiUrlWithPath: @"study-queue"];

  NSURLRequest* request = [NSURLRequest requestWithURL: apiURL];
  NSData* response = [NSURLConnection sendSynchronousRequest: request
                                           returningResponse: nil
                                                       error: nil];
  NSString* jsonString = [[NSString alloc] initWithData: response
                                               encoding: NSUTF8StringEncoding];

  SBJsonParser* jsonParser = [[SBJsonParser alloc] init];
  NSError* error = nil;

  id jsonObject = [jsonParser objectWithString: jsonString
                                         error: &error];

  NSDictionary* requestedInformation = [jsonObject objectForKey: @"requested_information"];

  _lessonsAvailable = [requestedInformation objectForKey: @"lessons_available"];
  _reviewsAvailable = [requestedInformation objectForKey: @"reviews_available"];
  _nextReviewDate = [requestedInformation objectForKey: @"next_review_date"];
  _reviewsAvailableNextHour = [requestedInformation objectForKey: @"reviews_available_next_hour"];
  _reviewsAvailableNextDay = [requestedInformation objectForKey: @"reviews_available_next_day"];
}

- (void)updateLevelProgression
{
  NSURL* apiURL = [self apiUrlWithPath: @"level-progression"];

  NSURLRequest* request = [NSURLRequest requestWithURL: apiURL];
  NSData* response = [NSURLConnection sendSynchronousRequest: request
                                           returningResponse: nil
                                                       error: nil];
  NSString* jsonString = [[NSString alloc] initWithData: response
                                               encoding: NSUTF8StringEncoding];

  SBJsonParser* jsonParser = [[SBJsonParser alloc] init];
  NSError* error = nil;

  id jsonObject = [jsonParser objectWithString: jsonString
                                         error: &error];

  NSDictionary* requestedInformation = [jsonObject objectForKey: @"requested_information"];

  _radicalsProgress = [requestedInformation objectForKey: @"radicals_progress"];
  _radicalsTotal = [requestedInformation objectForKey: @"radicals_total"];
  _kanjiProgress = [requestedInformation objectForKey: @"kanji_progress"];
  _kanjiTotal = [requestedInformation objectForKey: @"kanji_total"];
}

@end
