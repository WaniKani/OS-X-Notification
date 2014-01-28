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
@property NSNumber*		radicalsProgress;
@property NSNumber*		radicalsTotal;
@property NSNumber*		kanjiProgress;
@property NSNumber*		kanjiTotal;
@end
