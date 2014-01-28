//
//  WKUserInfo.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/27/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKApiDataContainer.h"

@interface WKUser : NSObject <WKApiDataContainer>
@property NSString*		username;
@property NSURL*			gravatar;
@property NSString*		title;
@property NSNumber*		level;
@property NSString*		creationDate;
@end
