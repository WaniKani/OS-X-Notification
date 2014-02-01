//
//  WKLevelProgression.m
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/27/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import "WKLevelProgression.h"

@implementation WKLevelProgression
- (void)updateWithDictionary: (NSDictionary*)dictionary
{
	self.radicalsProgress = SAFE_NUMBER(dictionary[@"radicals_progress"]);
  self.radicalsTotal = SAFE_NUMBER(dictionary[@"radicals_total"]);
  self.kanjiProgress = SAFE_NUMBER(dictionary[@"kanji_progress"]);
  self.kanjiTotal = SAFE_NUMBER(dictionary[@"kanji_total"]);
}

- (NSString*)radicalsCompletionString
{
	return [NSString stringWithFormat: @"%@/%@",
					self.radicalsProgress,
					self.radicalsTotal];
}

+ (NSSet*)keyPathsForValuesAffectingRadicalsCompletionString
{
	return [NSSet setWithObjects: @"radicalsProgress", @"radicalsTotal", nil];
}

- (NSString*)kanjiCompletionString
{
	return [NSString stringWithFormat: @"%@/%@",
					self.kanjiProgress,
					self.kanjiTotal];
}

+ (NSSet*)keyPathsForValuesAffectingKanjiCompletionString
{
	return [NSSet setWithObjects: @"kanjiProgress", @"kanjiTotal", nil];
}

@end
