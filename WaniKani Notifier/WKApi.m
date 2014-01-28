//
//  WKApi.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKApi.h"

// Models
#import "WKUser.h"
#import "WKStudyQueue.h"
#import "WKLevelProgression.h"

// Utility
#import "SBJson.h"

@interface WKApi ()
- (NSURL*)apiUrlWithPath: (NSString*)path;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKApi

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.user = [[WKUser alloc] init];
		self.studyQueue = [[WKStudyQueue alloc] init];
		self.levelProgression = [[WKLevelProgression alloc] init];
	}
	
	return self;
}

#pragma mark -
- (NSURL*)apiUrlWithPath: (NSString*)path
{
  NSString* urlString = [NSString stringWithFormat: @"https://www.wanikani.com/api/user/%@/%@",
                         _apiKey,
                         path];

  return [NSURL URLWithString: urlString];
}

- (void)updateAllData
{
  [self updateLevelProgression];
  [self updateStudyQueue];
  [self updateUserInfo];
}

- (void)updateUserInfo
{
  NSURL* apiURL = [self apiUrlWithPath: @"user-information"];
  NSURLRequest* request = [NSURLRequest requestWithURL: apiURL];
  NSData* response = [NSURLConnection sendSynchronousRequest: request
                                           returningResponse: nil
                                                       error: nil];
  NSString* jsonString = [[NSString alloc] initWithData: response
                                               encoding: NSUTF8StringEncoding];

  SBJsonParser* jsonParser = [[SBJsonParser alloc] init];
  NSError* error = nil;

  id jsonObject = [jsonParser objectWithString: jsonString
                                         error: &error];

  NSDictionary* requestedInformation = [jsonObject objectForKey: @"user_information"];

	[self.user updateWithDictionary: requestedInformation];
}

- (void)updateStudyQueue
{
  NSURL* apiURL = [self apiUrlWithPath: @"study-queue"];

  NSURLRequest* request = [NSURLRequest requestWithURL: apiURL];
  NSData* response = [NSURLConnection sendSynchronousRequest: request
                                           returningResponse: nil
                                                       error: nil];
  NSString* jsonString = [[NSString alloc] initWithData: response
                                               encoding: NSUTF8StringEncoding];

  SBJsonParser* jsonParser = [[SBJsonParser alloc] init];
  NSError* error = nil;

  id jsonObject = [jsonParser objectWithString: jsonString
                                         error: &error];

  NSDictionary* requestedInformation = [jsonObject objectForKey: @"requested_information"];

	[self.studyQueue updateWithDictionary: requestedInformation];
}

- (void)updateLevelProgression
{
  NSURL* apiURL = [self apiUrlWithPath: @"level-progression"];

  NSURLRequest* request = [NSURLRequest requestWithURL: apiURL];
  NSData* response = [NSURLConnection sendSynchronousRequest: request
                                           returningResponse: nil
                                                       error: nil];
  NSString* jsonString = [[NSString alloc] initWithData: response
                                               encoding: NSUTF8StringEncoding];

  SBJsonParser* jsonParser = [[SBJsonParser alloc] init];
  NSError* error = nil;

  id jsonObject = [jsonParser objectWithString: jsonString
                                         error: &error];

  NSDictionary* requestedInformation = [jsonObject objectForKey: @"requested_information"];

	[self.levelProgression updateWithDictionary: requestedInformation];
}

@end
