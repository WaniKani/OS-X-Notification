//
//  WKNotifier.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKNotifier.h"

@interface WKNotifier ()
- (void)deliverNotification: (NSUserNotification*)notification;

// Notification Builder
- (NSUserNotification*)buildNotification;
@property (nonatomic, readonly) NSString* notificationText;
@property (nonatomic, readonly) NSString* notificationSoundName;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKNotifier
@synthesize userNotificationCenter = _userNotificationCenter;

- (id)init
{
  self = [super init];
  if ( self )
  {
    _userNotificationCenter = [NSUserNotificationCenter defaultUserNotificationCenter];
  }

  return self;
}

- (void)deliverNotification: (NSUserNotification*)notification
{
  [self.userNotificationCenter deliverNotification: notification];
}

- (void)removeDeliveredNotifications
{
  [self.userNotificationCenter removeAllDeliveredNotifications];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)sendNotification
{
  if ( [_reviewsAvailable intValue] >= [[self minReviews] intValue] )
  {
    // Make sure that we remove the notifications that were showing
    [self removeDeliveredNotifications];

    NSUserNotification* notification = [self buildNotification];
    [self deliverNotification: notification];
  }
}

#pragma mark - Notification Building
- (NSUserNotification*)buildNotification
{
  NSUserNotification* notification = [[NSUserNotification alloc] init];
  notification.title = NSLocalizedString(@"Review Available!", @"NSUserNotification title");
  notification.informativeText = self.notificationText;
  notification.soundName = self.notificationSoundName;
  notification.hasActionButton = YES;
  notification.actionButtonTitle = NSLocalizedString(@"Open Review", @"NSUserNotification action button title");
  notification.otherButtonTitle = NSLocalizedString(@"Be Lazy :(", @"NSUserNotification decline button title");

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
