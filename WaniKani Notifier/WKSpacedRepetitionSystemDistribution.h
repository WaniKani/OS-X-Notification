//
//  WKSpacedRepetitionSystemDistribution.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/31/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKApiDataContainer.h"

@class WKSpacedRepetitionLevelInfo;
@interface WKSpacedRepetitionSystemDistribution : NSObject <WKApiDataContainer>
@property (nonatomic, readonly) WKSpacedRepetitionLevelInfo* apprenticeLevelInfo;
@property (nonatomic, readonly) WKSpacedRepetitionLevelInfo* guruLevelInfo;
@property (nonatomic, readonly) WKSpacedRepetitionLevelInfo* masterLevelInfo;
@property (nonatomic, readonly) WKSpacedRepetitionLevelInfo* enlightenLevelInfo;
@property (nonatomic, readonly) WKSpacedRepetitionLevelInfo* burnedLevelInfo;
@end
