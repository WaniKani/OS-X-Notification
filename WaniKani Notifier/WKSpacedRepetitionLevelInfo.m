//
//  WKSpacedRepetitionLevelInfo.m
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/31/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import "WKSpacedRepetitionLevelInfo.h"

@implementation WKSpacedRepetitionLevelInfo
- (void)updateWithDictionary: (NSDictionary*)dictionary
{
	self.radicalsCount = SAFE_NUMBER(dictionary[@"radicals"]);
  self.kanjiCount = SAFE_NUMBER(dictionary[@"kanji"]);
  self.vocabularyCount = SAFE_NUMBER(dictionary[@"vocabulary"]);
  self.totalCount = SAFE_NUMBER(dictionary[@"total"]);
}

- (NSString*)summaryText
{
	return [NSString stringWithFormat: @"%@: %@", self.title, self.totalCount];
}

+ (NSSet*)keyPathsForValuesAffectingSummaryText
{
	return [NSSet setWithObjects: @"title", @"totalCount", nil];
}

#pragma mark -
- (NSString*)debugDescription
{
	return [NSString
					stringWithFormat: @"\n%@\n\tradicals: %@\n\tkanji: %@\n\tvocabulary: %@\n\ttotal: %@",
					self.title, self.radicalsCount, self.kanjiCount, self.vocabularyCount, self.totalCount];
}

@end
