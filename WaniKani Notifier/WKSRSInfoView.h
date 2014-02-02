//
//  WKSRSInfoView.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 2/1/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WKSpacedRepetitionLevelInfo;
@interface WKSRSInfoView : NSView
@property (nonatomic, strong) WKSpacedRepetitionLevelInfo* levelInfo;
@end
