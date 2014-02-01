//
//  WKAppController.h
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "WKApi.h"
#import "WKNotifier.h"

@class WKStatusMenuViewController;
@interface WKAppController : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate>
{
  IBOutlet NSWindow* window;

	IBOutlet WKStatusMenuViewController*		statusMenuViewController;

  IBOutlet NSMenuItem*          profileMenuItem;
  IBOutlet NSView*              profileMenuView;
  IBOutlet NSImageView*         profileMenuImage;
  IBOutlet NSTextField*         profileMenuName;
  IBOutlet NSTextField*         profileMenuSect;
  IBOutlet NSTextField*         profileMenuLevel;
  IBOutlet NSTextField*         profileMenuRadicalText;
  IBOutlet NSTextField*         profileMenuKanjiText;

  // Reviews
  IBOutlet NSMenuItem* reviewsNextHourMenu;
  IBOutlet NSMenuItem* reviewsNextDayMenu;

  IBOutlet NSTextField* apiKeyTextfield;
  IBOutlet NSPopUpButton* minReviews;
  IBOutlet NSPopUpButton* repeater;
  IBOutlet NSPopUpButton* sound;

  IBOutlet NSImageView* userImage;
  IBOutlet NSTextField* userName;
  IBOutlet NSTextField* userSect;
  IBOutlet NSTextField* userLevel;
  IBOutlet NSTextField* userTopicCount;
  IBOutlet NSTextField* userPostCount;

  IBOutlet NSTextField* userRadicalText;
  IBOutlet NSLevelIndicator* userRadicalProgress;

  IBOutlet NSTextField* userKanjiText;
  IBOutlet NSLevelIndicator* userKanjiProgress;

  NSNumber* lastReviewsAvailable;
}
@property (nonatomic, readonly) WKApi* api;

- (IBAction)visitWaniKani: (id)sender;
- (IBAction)showPreferences: (id)sender;
- (IBAction)quit: (id)sender;

- (void)loadKeys;
- (void)saveKeys;

- (BOOL)hasInternet;

@end
