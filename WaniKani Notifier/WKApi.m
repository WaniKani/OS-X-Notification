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
  NSDictionary* userInformation = [self userInformationForPath: @"user-information"];
	[self.user updateWithDictionary: userInformation];
}

- (void)updateStudyQueue
{
  NSDictionary* requestedInformation = [self requestedInformationForPath: @"study-queue"];
	[self.studyQueue updateWithDictionary: requestedInformation];
}

- (void)updateLevelProgression
{
  NSDictionary* requestedInformation = [self requestedInformationForPath: @"level-progression"];
	[self.levelProgression updateWithDictionary: requestedInformation];
}

#pragma mark - Private
- (NSDictionary*)userInformationForPath: (NSString*)path
{
	NSDictionary* requestedInformation = @{};
	
	id jsonObject = [self jsonObjectWithRequestForPath: path];
	if ( [jsonObject respondsToSelector: @selector(objectForKey:)] )
	{
		requestedInformation = [jsonObject objectForKey: @"user_information"];
	}
	
	return requestedInformation;
}

- (NSDictionary*)requestedInformationForPath: (NSString*)path
{
	NSDictionary* requestedInformation = @{};
	
	id jsonObject = [self jsonObjectWithRequestForPath: path];
	if ( [jsonObject respondsToSelector: @selector(objectForKey:)] )
	{
		requestedInformation = [jsonObject objectForKey: @"requested_information"];
	}
	
	return requestedInformation;
}

- (id)jsonObjectWithRequestForPath: (NSString*)path
{
	id jsonObject = nil;
	
	NSURL* apiURL = [self apiUrlWithPath: path];
  NSURLRequest* request = [NSURLRequest requestWithURL: apiURL];
	jsonObject = [self jsonObjectWithRequest: request];
	
	return jsonObject;
}

- (id)jsonObjectWithRequest: (NSURLRequest*)request
{
	id jsonObject = nil;
	
	NSData* response = [NSURLConnection sendSynchronousRequest: request
                                           returningResponse: nil
                                                       error: nil];
	
  NSError* jsonError = nil;
	jsonObject = [NSJSONSerialization JSONObjectWithData: response
																							 options: 0
																								 error: &jsonError];
	
	return jsonObject;
}

@end
