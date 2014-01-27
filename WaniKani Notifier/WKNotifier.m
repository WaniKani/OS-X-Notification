//
//  WKNotifier.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKNotifier.h"

@interface WKNotifier ()
+ (NSUserNotificationCenter*)userNotificationCenter;
- (void)deliverNotification: (NSUserNotification*)notification;

// Notification Builder
@property (nonatomic, readonly) NSUserNotification* notification;
@property (nonatomic, readonly) NSString* notificationText;
@property (nonatomic, readonly) NSString* notificationSoundName;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKNotifier

+ (NSUserNotificationCenter*)userNotificationCenter
{
  return [NSUserNotificationCenter defaultUserNotificationCenter];
}

- (void)deliverNotification: (NSUserNotification*)notification
{
  [[[self class] userNotificationCenter] deliverNotification: notification];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)sendNotification
{
  if ( [_reviewsAvailable intValue] >= [[self minReviews] intValue] )
  {
    [self deliverNotification: self.notification];
  }
}

#pragma mark - Notification Building
- (NSUserNotification*)notification
{
  NSUserNotification* notification = [[NSUserNotification alloc] init];
  notification.title = NSLocalizedString(@"Review Available!", @"NSUserNotification title");
  notification.informativeText = self.notificationText;
  notification.soundName = self.notificationSoundName;
  notification.hasActionButton = YES;
  notification.actionButtonTitle = NSLocalizedString(@"Open Review", @"NSUserNotification action button title");
  [notification setOtherButtonTitle: NSLocalizedString(@"Be Lazy :(", @"NSUserNotification decline button title")];

  return notification;
}

- (NSString*)notificationText
{
  NSUInteger reviewCount = _reviewsAvailable.unsignedIntegerValue;
  NSString* notificationText = NSLocalizedString(@"There is one review available at Wanikani.com", @"NSUserNotification text");

  if ( reviewCount > 1 )
  {
    notificationText = [NSString stringWithFormat:
                        NSLocalizedString(@"There are %u reviews available at Wanikani.com", @"NSUserNotification text"),
                        reviewCount];
  }

  return notificationText;
}

- (NSString*)notificationSoundName
{
  NSString* notificationSoundName = nil;
  if ( self.sound )
  {
    notificationSoundName = @"review-time.mp3";
  }

  return notificationSoundName;
}

@end
