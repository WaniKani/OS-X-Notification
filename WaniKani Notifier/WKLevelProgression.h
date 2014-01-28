//
//  WKLevelProgression.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/27/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKApiDataContainer.h"

@interface WKLevelProgression : NSObject <WKApiDataContainer>
@property (nonatomic, strong) NSNumber*		radicalsProgress;
@property (nonatomic, strong) NSNumber*		radicalsTotal;
@property (nonatomic, readonly) NSString*	radicalsCompletionString;

@property (nonatomic, strong) NSNumber*		kanjiProgress;
@property (nonatomic, strong) NSNumber*		kanjiTotal;
@property (nonatomic, readonly) NSString*	kanjiCompletionString;
@end
