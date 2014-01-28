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
- (NSURL*)gravatarUrlWithGravatarId: (NSString*)gravatId;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKUser
- (void)updateWithDictionary: (NSDictionary*)dictionary
{
	self.username = dictionary[@"username"];
  self.gravatar = [self gravatarUrlWithGravatarId: dictionary[@"gravatar"]];
  self.level = dictionary[@"level"];
  self.title = dictionary[@"title"];
  self.creationDate = dictionary[@"creation_date"];
}

#pragma mark - Private
- (NSURL*)gravatarUrlWithGravatarId: (NSString*)gravatId
{
	NSString* urlString = [NSString stringWithFormat: kGravatarFormat, gravatId];
	return [NSURL URLWithString: urlString];
}

@end
