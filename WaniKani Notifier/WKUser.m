//
//  WKUserInfo.m
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/27/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import "WKUser.h"

static NSString* const kGravatarFormat = @"http://www.gravatar.com/avatar/%@?s=180";

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WKUser ()
- (NSString*)gravatarUrlStringWithGravatarId: (NSString*)gravatId;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKUser
- (void)updateWithDictionary: (NSDictionary*)dictionary
{
	self.username = SAFE_STRING(dictionary[@"username"]);
  self.gravatarUrlString = [self gravatarUrlStringWithGravatarId:
														SAFE_STRING(dictionary[@"gravatar"])];
  self.level = SAFE_NUMBER(dictionary[@"level"]);
  self.title = SAFE_STRING(dictionary[@"title"]);
  self.creationDate = SAFE_STRING(dictionary[@"creation_date"]);
}

- (NSURL*)gravatar
{
	return [NSURL URLWithString: self.gravatarUrlString];
}

+ (NSSet*)keyPathsForValuesAffectingGravatar
{
	return [NSSet setWithObjects: @"gravatarUrlString", nil];
}

- (NSImage*)gravatarImage
{
	return [[NSImage alloc] initWithData: [NSData dataWithContentsOfURL: self.gravatar]];
}

+ (NSSet*)keyPathsForValuesAffectingGravatarImage
{
	return [NSSet setWithObjects: @"gravatar", nil];
}

#pragma mark - Private
- (NSString*)gravatarUrlStringWithGravatarId: (NSString*)gravatId
{
	return [NSString stringWithFormat: kGravatarFormat, gravatId];
}

@end
