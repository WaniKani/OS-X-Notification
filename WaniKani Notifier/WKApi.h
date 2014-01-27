//
//  WKApi.h
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@class SBJsonStreamParser;
@class SBJsonStreamParserAdapter;

@interface WKApi : NSObject {
  NSURLConnection* theConnection;
  SBJsonStreamParser* parser;
  SBJsonStreamParserAdapter* adapter;
}

//Conection Info
@property (strong) NSString* apiKey;

//UserInfo
@property NSString* username;
@property NSURL* gravatar;
@property NSString* title;
@property NSNumber* level;
@property NSString* creationDate;

//StudyQueue
@property NSNumber* lessonsAvailable;
@property NSNumber* reviewsAvailable;
@property NSString* nextReviewDate;
@property NSNumber* reviewsAvailableNextHour;
@property NSNumber* reviewsAvailableNextDay;

//LevelProgression
@property NSNumber* radicalsProgress;
@property NSNumber* radicalsTotal;
@property NSNumber* kanjiProgress;
@property NSNumber* kanjiTotal;

- (void)updateAllData;
- (void)updateUserInfo;
- (void)updateStudyQueue;
- (void)updateLevelProgression;

@end
