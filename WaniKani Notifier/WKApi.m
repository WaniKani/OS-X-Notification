//
//  WKApi.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKApi.h"

@implementation WKApi

- (void)updateAllData{
    [self updateLevelProgression];
    [self updateStudyQueue];
    [self updateUserInfo];
}

- (void)updateUserInfo{
    NSString *apiCall = [NSString stringWithFormat:@"http://www.wanikani.com/api/user/%@/user-information", _apiKey];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiCall]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *error = nil;
    
    id jsonObject = [jsonParser objectWithString:jsonString error:&error];
    
    NSDictionary *requestedInformation = [jsonObject objectForKey:@"user_information"];
    
    _username = [requestedInformation objectForKey:@"username"];
    _gravatar = [requestedInformation objectForKey:@"gravatar"];
    _level = [requestedInformation objectForKey:@"level"];
    _title = [requestedInformation objectForKey:@"level"];
    _creationDate = [requestedInformation objectForKey:@"creation_date"];
}

- (void)updateStudyQueue{
    NSString *apiCall = [NSString stringWithFormat:@"http://www.wanikani.com/api/user/%@/study-queue", _apiKey];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiCall]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *error = nil;
    
    id jsonObject = [jsonParser objectWithString:jsonString error:&error];
    
    NSDictionary *requestedInformation = [jsonObject objectForKey:@"requested_information"];
    
    _lessonsAvailable = [requestedInformation objectForKey:@"lessons_available"];
    _reviewsAvailable = [requestedInformation objectForKey:@"reviews_available"];
    _nextReviewDate = [requestedInformation objectForKey:@"next_review_date"];
    _reviewsAvailableNextHour = [requestedInformation objectForKey:@"reviews_available_next_hour"];
    _reviewsAvailableNextDay = [requestedInformation objectForKey:@"reviews_available_next_day"];
    
}

- (void)updateLevelProgression{
    NSString *apiCall = [NSString stringWithFormat:@"http://www.wanikani.com/api/user/%@/level-progression", _apiKey];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiCall]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *error = nil;
    
    id jsonObject = [jsonParser objectWithString:jsonString error:&error];
    
    NSDictionary *requestedInformation = [jsonObject objectForKey:@"requested_information"];
    
    _radicalsProgress = [requestedInformation objectForKey:@"radicals_progress"];
    _radicalsTotal = [requestedInformation objectForKey:@"radicals_total"];
    _kanjiProgress = [requestedInformation objectForKey:@"kanji_progress"];
    _kanjiTotal = [requestedInformation objectForKey:@"kanji_total"];
}


@end
