//
//  WKSpacedRepetitionLevelInfo.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/31/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKApiDataContainer.h"

@interface WKSpacedRepetitionLevelInfo : NSObject <WKApiDataContainer>
@property (nonatomic, strong) NSString*		title;
@property (nonatomic, strong) NSNumber*		radicalsCount;
@property (nonatomic, strong) NSNumber*		kanjiCount;
@property (nonatomic, strong) NSNumber*		vocabularyCount;
@property (nonatomic, strong) NSNumber*		totalCount;

@property (nonatomic, readonly) NSString* summaryText;
@end
