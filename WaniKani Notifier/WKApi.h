//
//  WKApi.h
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WKUser;
@class WKStudyQueue;
@class WKLevelProgression;
@class WKSpacedRepetitionSystemDistribution;

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WKApi : NSObject
+ (WKApi*)sharedInstance;

//Conection Info
@property (strong) NSString* apiKey;

@property (nonatomic, readonly) WKUser* user;
@property (nonatomic, readonly) WKStudyQueue* studyQueue;
@property (nonatomic, readonly) WKLevelProgression* levelProgression;
@property (nonatomic, readonly) WKSpacedRepetitionSystemDistribution* srsDistribution;

@property (nonatomic, readonly) NSDate* nextReviewDate;

@property (nonatomic, readonly, getter = isUpdating) BOOL updating;
- (void)updateAllData;
- (void)updateUserInfo;
- (void)updateStudyQueue;
- (void)updateLevelProgression;
- (void)updateSrsDistribution;

@end
