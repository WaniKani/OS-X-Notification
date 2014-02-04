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
#import "WKSpacedRepetitionSystemDistribution.h"

typedef void(^WKApiCompletionHandler)(id result, NSError* error);

@interface WKApi ()
- (NSURL*)apiUrlWithPath: (NSString*)path;
@property (nonatomic, readonly) NSOperationQueue* requestQueue;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKApi

+ (WKApi*)sharedInstance
{
	static WKApi* _sharedInstance = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
    _sharedInstance = [[WKApi alloc] init];
	});
	
	return _sharedInstance;
}

- (id)init
{
	self = [super init];
	if ( self )
	{
		_user = [[WKUser alloc] init];
		_studyQueue = [[WKStudyQueue alloc] init];
		_levelProgression = [[WKLevelProgression alloc] init];
		_srsDistribution = [[WKSpacedRepetitionSystemDistribution alloc] init];
		
		_requestQueue = [[NSOperationQueue alloc] init];
		[_requestQueue setMaxConcurrentOperationCount: 4];
	}
	
	return self;
}

#pragma mark -
- (NSDate*)nextReviewDate
{
	return self.studyQueue.nextReviewDate;
}

+ (NSSet*)keyPathsForValuesAffectingNextReviewDate
{
	return [NSSet setWithObjects: @"studyQueue.nextReviewDate", nil];
}

- (BOOL)isUpdating
{
	return (self.requestQueue.operationCount > 0);
}

+ (NSSet*)keyPathsForValuesAffectingUpdating
{
	return [NSSet setWithObjects: @"requestQueue.operationCount", nil];
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
	[self updateSrsDistribution];
}

- (void)updateUserInfo
{
	[self userInformationForPath: @"user-information"
						 completionHandler: ^(id result, NSError* error) {
							 [self.user updateWithDictionary: result];
						 }];
}

- (void)updateStudyQueue
{
	[self requestedInformationForPath: @"study-queue"
									completionHandler: ^(id result, NSError* error) {
										[self.studyQueue updateWithDictionary: result];
									}];
}

- (void)updateLevelProgression
{
  [self requestedInformationForPath: @"level-progression"
									completionHandler: ^(id result, NSError* error) {
										[self.levelProgression updateWithDictionary: result];
									}];
}

- (void)updateSrsDistribution
{
	[self requestedInformationForPath: @"srs-distribution"
									completionHandler: ^(id result, NSError* error) {
										[self.srsDistribution updateWithDictionary: result];
									}];
}

#pragma mark - Private
- (void)userInformationForPath: (NSString*)path
						 completionHandler: (WKApiCompletionHandler)completionHandler
{
	[self
	 jsonObjectWithRequestForPath: path
	 completionHandler: ^(id result, NSError *error) {
		 if ( error )
		 {
			 dispatch_async(dispatch_get_main_queue(), ^{
				 completionHandler(nil, error);
			 });
		 }
		 else
		 {
			 NSDictionary* jsonObject = SAFE_DICTIONARY(result);
			 NSDictionary* userInfo = SAFE_DICTIONARY(jsonObject[@"user_information"]);
			 
			 dispatch_async(dispatch_get_main_queue(), ^{
				 completionHandler(userInfo, nil);
			 });
		 }
	 }];
}

- (void)requestedInformationForPath: (NSString*)path
									completionHandler: (WKApiCompletionHandler)completionHandler
{
	[self
	 jsonObjectWithRequestForPath: path
	 completionHandler: ^(id result, NSError *error) {
		 if ( error )
		 {
			 dispatch_async(dispatch_get_main_queue(), ^{
				 completionHandler(nil, error);
			 });
		 }
		 else
		 {
			 NSDictionary* jsonObject = SAFE_DICTIONARY(result);
			 NSDictionary* requestedInfo = SAFE_DICTIONARY(jsonObject[@"requested_information"]);
			 
			 dispatch_async(dispatch_get_main_queue(), ^{
				 completionHandler(requestedInfo, nil);
			 });
		 }
	 }];
}

- (void)jsonObjectWithRequestForPath: (NSString*)path
									 completionHandler: (WKApiCompletionHandler)completionHandler
{
	NSURL* apiURL = [self apiUrlWithPath: path];
  NSURLRequest* request = [NSURLRequest requestWithURL: apiURL];
	[self jsonObjectWithRequest: request
						completionHandler: completionHandler];
}

- (void)jsonObjectWithRequest: (NSURLRequest*)request
						completionHandler: (WKApiCompletionHandler)completionHandler
{
	NSLog(@"Fetch: %@", request.URL.absoluteString);
	[NSURLConnection
	 sendAsynchronousRequest: request
	 queue: self.requestQueue
	 completionHandler: ^(NSURLResponse* response, NSData* data, NSError*connectionError) {
		 if ( connectionError )
		 {
			 dispatch_async(dispatch_get_main_queue(), ^{
				 completionHandler(nil, connectionError);
			 });
		 }
		 else
		 {
			 NSError* jsonError = nil;
			 id jsonObject = [NSJSONSerialization JSONObjectWithData: data
																											 options: 0
																												 error: &jsonError];
			 
			 dispatch_async(dispatch_get_main_queue(), ^{
				 completionHandler(jsonObject, jsonError);
			 });
		 }
	 }];
}


@end
