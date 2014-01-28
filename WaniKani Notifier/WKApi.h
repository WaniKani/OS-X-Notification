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

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WKApi : NSObject {
}

//Conection Info
@property (strong) NSString* apiKey;

@property (nonatomic, strong) WKUser* user;
@property (nonatomic, strong) WKStudyQueue* studyQueue;
@property (nonatomic, strong) WKLevelProgression* levelProgression;

- (void)updateAllData;
- (void)updateUserInfo;
- (void)updateStudyQueue;
- (void)updateLevelProgression;

@end
