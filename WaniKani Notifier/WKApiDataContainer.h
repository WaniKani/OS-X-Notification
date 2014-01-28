//
//  WKApiDataContainer.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/27/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WKApiDataContainer <NSObject>
- (void)updateWithDictionary: (NSDictionary*)dictionary;
@end
