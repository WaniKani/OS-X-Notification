//
//  WKSpacedRepetitionSystemDistribution.m
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/31/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import "WKSpacedRepetitionSystemDistribution.h"

// Model
#import "WKSpacedRepetitionLevelInfo.h"

#import "WKColors.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKSpacedRepetitionSystemDistribution

- (id)init
{
	self = [super init];
	if (self )
	{
		_apprenticeLevelInfo = [[WKSpacedRepetitionLevelInfo alloc] init];
		_apprenticeLevelInfo.title = NSLocalizedString(@"Apprentice", @"SRS Level title");
		_apprenticeLevelInfo.color = COLOR_APPRENTICE;
		
		_guruLevelInfo = [[WKSpacedRepetitionLevelInfo alloc] init];
		_guruLevelInfo.title = NSLocalizedString(@"Guru", @"SRS Level title");
		_guruLevelInfo.color = COLOR_GURU;
		
		_masterLevelInfo = [[WKSpacedRepetitionLevelInfo alloc] init];
		_masterLevelInfo.title = NSLocalizedString(@"Master", @"SRS Level title");
		_masterLevelInfo.color = COLOR_MASTER;
		
		_enlightenLevelInfo = [[WKSpacedRepetitionLevelInfo alloc] init];
		_enlightenLevelInfo.title = NSLocalizedString(@"Enlightened", @"SRS Level title");
		_enlightenLevelInfo.color = COLOR_ENLIGHTENED;
		
		_burnedLevelInfo = [[WKSpacedRepetitionLevelInfo alloc] init];
		_burnedLevelInfo.title = NSLocalizedString(@"Burned", @"SRS Level title");
		_burnedLevelInfo.color = COLOR_BURNED;
	}
	
	return self;
}

#pragma mark -
- (void)updateWithDictionary: (NSDictionary*)dictionary
{
	[self.apprenticeLevelInfo updateWithDictionary: SAFE_DICTIONARY(dictionary[@"apprentice"])];
	[self.guruLevelInfo updateWithDictionary: SAFE_DICTIONARY(dictionary[@"guru"])];
	[self.masterLevelInfo updateWithDictionary: SAFE_DICTIONARY(dictionary[@"master"])];
	[self.enlightenLevelInfo updateWithDictionary: SAFE_DICTIONARY(dictionary[@"enlighten"])];
	[self.burnedLevelInfo updateWithDictionary: SAFE_DICTIONARY(dictionary[@"burned"])];
}

@end
