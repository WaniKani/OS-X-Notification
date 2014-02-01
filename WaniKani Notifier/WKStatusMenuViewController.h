//
//  WKStatusMenuViewController.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 2/1/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WKUser;
@class WKStudyQueue;
@class WKLevelProgression;
@class WKSpacedRepetitionSystemDistribution;

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WKStatusMenuViewController : NSViewController
@property (nonatomic, strong) WKUser* user;
@property (nonatomic, strong) WKStudyQueue* studyQueue;
@property (nonatomic, strong) WKLevelProgression* levelProgression;
@property (nonatomic, strong) WKSpacedRepetitionSystemDistribution* srsDistribution;

@end
