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
@property (nonatomic, strong) NSString*		username;
@property (nonatomic, strong) NSString*		gravatarUrlString;
@property (nonatomic, readonly) NSURL*		gravatar;
@property (nonatomic, readonly) NSImage*	gravatarImage;
@property (nonatomic, strong) NSString*		title;
@property (nonatomic, strong) NSNumber*		level;
@property (nonatomic, strong) NSString*		creationDate;
@end
