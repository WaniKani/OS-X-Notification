//
//  WKAppController.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKAppController.h"
#import "WKApi.h"

// Models
#import "WKUser.h"
#import "WKStudyQueue.h"
#import "WKLevelProgression.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WKAppController ()
@property (nonatomic, readonly) NSUserDefaults* userDefaults;
@property (nonatomic, readonly) NSURL* waniKaniUrl;
@property (nonatomic, readonly) WKNotifier* notifier;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKAppController
@synthesize notifier=_notifier;
#define kApiKey @"apiKey"
#define kMinReviews @"minReviews"
#define kRepeater @"repeater"
#define kSound @"sound"
#define kFirstLaunch @"FirstLaunch"

- (NSUserDefaults*)userDefaults
{
	return [NSUserDefaults standardUserDefaults];
}

- (NSURL*)waniKaniUrl
{
  return [NSURL URLWithString: @"https://www.wanikani.com"];
}

- (void)saveKeys
{
  [self.userDefaults setObject: [apiKeyTextfield stringValue]
												forKey: kApiKey];
  [self.userDefaults setObject: [minReviews titleOfSelectedItem]
												forKey: kMinReviews];
  [self.userDefaults setObject: [repeater titleOfSelectedItem]
												forKey: kRepeater];
  [self.userDefaults setObject: [sound titleOfSelectedItem]
												forKey: kSound];
  [self.userDefaults synchronize];
}

- (void)loadKeys
{
  [apiKeyTextfield setStringValue: [self.userDefaults objectForKey: kApiKey]];
  [minReviews selectItemWithTitle: [self.userDefaults objectForKey: kMinReviews]];
  [repeater selectItemWithTitle: [self.userDefaults objectForKey: kRepeater]];
  [sound selectItemWithTitle: [self.userDefaults objectForKey: kSound]];
}

- (void)applicationDidFinishLaunching: (NSNotification*)aNotification
{
  [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate: self];

  self.api = [[WKApi alloc] init];

  // Set up Statusbar Icon
  statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];

  [statusItem setMenu: statusMenu];
  [statusItem setHighlightMode: YES];
  [statusItem setImage: [NSImage imageNamed: @"menubar.png"]];
  [statusItem setAlternateImage: [NSImage imageNamed: @"menubar-invert.png"]];
  [statusItem setEnabled: YES];

  [profileMenuItem setView: profileMenuView];

  // Sets Default Values
  if ( [self.userDefaults objectForKey: kApiKey] != nil )
  {
    [self loadKeys];
  }

  // Sets Default Values
  if ( [self.userDefaults objectForKey: kFirstLaunch] == nil )
  {
    [NSApp activateIgnoringOtherApps: YES];
    [window makeKeyAndOrderFront: nil];
    [self.userDefaults setObject: @"NOPE"
													forKey: kFirstLaunch];
  }

  //Set Up API-Checker Timer
  NSTimer* checkApiKeyTimer;
  checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                      target: self
                                                    selector: @selector(intervalTimer:)
                                                    userInfo: nil
                                                     repeats: NO];

  //Set Up Menu-Review Timer
  NSTimer* menuReviewTimer;
  menuReviewTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                     target: self
                                                   selector: @selector(menuReviewChecker:)
                                                   userInfo: nil
                                                    repeats: NO];
}

- (BOOL)userNotificationCenter: (NSUserNotificationCenter*)center
     shouldPresentNotification: (NSUserNotification*)notification
{
  return YES;
}

- (void)userNotificationCenter: (NSUserNotificationCenter*)center
       didActivateNotification: (NSUserNotification*)notification
{
  [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: @"https://www.wanikani.com/review/"]];
}

- (void)intervalTimer: (id)sender;
{
  if ( [[apiKeyTextfield stringValue] length] == 32 && [self hasInternet] )
  {
    [self.api setApiKey: [apiKeyTextfield stringValue]];
    [self.api updateAllData];

    NSLog(@"API Key:%@/%@/%@", [apiKeyTextfield stringValue], self.api.apiKey, self.api.user.username);

    NSDate* now = [NSDate date];

    NSDateFormatter* df_utc = [[NSDateFormatter alloc] init];
    [df_utc setTimeZone: [NSTimeZone timeZoneWithName: @"UTC"]];
    [df_utc setDateFormat: @"dd-MM-yyyy HH:mm:ss"];

    NSString* utcNextReviewDate = [df_utc stringFromDate: self.api.studyQueue.nextReviewDate];
    NSString* utcNow = [df_utc stringFromDate: now];

    NSLog(@"nextReview: %@, Now: %@", utcNextReviewDate, utcNow);

    NSDate* reviewDate = [df_utc dateFromString: utcNextReviewDate];
    NSDate* nowDate = [df_utc dateFromString: utcNow];

    NSTimeInterval secondsBetween = [reviewDate timeIntervalSinceDate: nowDate];
    int secondsBetweenInt = secondsBetween;

    NSLog(@"secondsBetween: %d", secondsBetweenInt);

    if ( secondsBetweenInt < -20 )
    {
      NSTimer* checkApiKeyTimer;
      checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                          target: self
                                                        selector: @selector(intervalTimer:)
                                                        userInfo: nil
                                                         repeats: NO];
    }
    else
    {
      NSTimer* reviewTimer;
      reviewTimer = [NSTimer scheduledTimerWithTimeInterval: secondsBetweenInt
                                                     target: self
                                                   selector: @selector(setupNotification:)
                                                   userInfo: nil
                                                    repeats: NO];
    }
  }
  else
  {
    NSTimer* checkApiKeyTimer;
    checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 5
                                                        target: self
                                                      selector: @selector(intervalTimer:)
                                                      userInfo: nil
                                                       repeats: NO];
  }
}

- (void)menuReviewChecker: (id)sender
{
  if ( [[apiKeyTextfield stringValue] length] == 32 && [self hasInternet] )
  {
    [reviewsNextHourMenu setTitle: [NSString stringWithFormat: @"Reviews next Hour: %@",
																		self.api.studyQueue.reviewsAvailableNextHour]];
    [reviewsNextDayMenu setTitle: [NSString stringWithFormat: @"Reviews next Day: %@",
																	 self.api.studyQueue.reviewsAvailableNextDay]];
    NSLog(@"Menu rendered");

    NSTimer* menuReviewTimer;
    menuReviewTimer = [NSTimer scheduledTimerWithTimeInterval: 300
                                                       target: self
                                                     selector: @selector(menuReviewChecker:)
                                                     userInfo: nil
                                                      repeats: NO];
  }
  else
  {
    NSTimer* menuReviewTimer;
    menuReviewTimer = [NSTimer scheduledTimerWithTimeInterval: 5
                                                       target: self
                                                     selector: @selector(menuReviewChecker:)
                                                     userInfo: nil
                                                      repeats: NO];
  }
}

- (WKNotifier*)notifier
{
  if ( _notifier == nil )
  {
    _notifier = [[WKNotifier alloc] init];
    _notifier.userNotificationCenter.delegate = self;
  }

  return _notifier;
}

- (void)setupNotification: (id)sender
{
  [self.api updateStudyQueue];

  if ( [@"1 Review" isEqualToString :[minReviews titleOfSelectedItem]] )
  {
    [self.notifier setMinReviews: [NSNumber numberWithDouble: 1]];
  }
  if ( [@"5 Reviews" isEqualToString :[minReviews titleOfSelectedItem]] )
  {
    [self.notifier setMinReviews: [NSNumber numberWithDouble: 5]];
  }
  if ( [@"15 Reviews" isEqualToString :[minReviews titleOfSelectedItem]] )
  {
    [self.notifier setMinReviews: [NSNumber numberWithDouble: 15]];
  }
  if ( [@"25 Reviews" isEqualToString :[minReviews titleOfSelectedItem]] )
  {
    [self.notifier setMinReviews: [NSNumber numberWithDouble: 25]];
  }
  if ( [@"42 Reviews" isEqualToString :[minReviews titleOfSelectedItem]] )
  {
    [self.notifier setMinReviews: [NSNumber numberWithDouble: 42]];
  }

  if ( [@"No!" isEqualToString :[sound titleOfSelectedItem]] )
  {
    [self.notifier setSound: NO];
    NSLog(@"Set Sound to NO");
  }
  else
  {
    [self.notifier setSound: YES];
    NSLog(@"Set Sound to YES");
  }

  if ( [@"No!" isEqualToString :[repeater titleOfSelectedItem]] )
  {
    if ( lastReviewsAvailable == self.api.studyQueue.reviewsAvailable )
    {
      [self.notifier setReviewsAvailable: self.api.studyQueue.reviewsAvailable];
      NSLog(@"ReviewsAvailable: %@", [self.notifier reviewsAvailable]);
      [self.notifier sendNotification];
      NSLog(@"Notifications send");
    }
  }
  else
  {
    [self.notifier setReviewsAvailable: self.api.studyQueue.reviewsAvailable];
    NSLog(@"ReviewsAvailable: %@", [self.notifier reviewsAvailable]);
    [self.notifier sendNotification];
    NSLog(@"Notifications send");
  }
  lastReviewsAvailable = self.api.studyQueue.reviewsAvailable;

  NSTimer* checkApiKeyTimer;
  if ( [@"1 Minute" isEqualToString: [repeater titleOfSelectedItem]] )
  {
    checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 60
                                                        target: self
                                                      selector: @selector(intervalTimer:)
                                                      userInfo: nil
                                                       repeats: NO];
  }
  
	if ( [@"5 Minutes" isEqualToString: [repeater titleOfSelectedItem]] )
  {
    checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 300
                                                        target: self
                                                      selector: @selector(intervalTimer:)
                                                      userInfo: nil
                                                       repeats: NO];
  }
  
	if ( [@"10 Minutes" isEqualToString: [repeater titleOfSelectedItem]] )
  {
    checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 600
                                                        target: self
                                                      selector: @selector(intervalTimer:)
                                                      userInfo: nil
                                                       repeats: NO];
  }
  
	if ( [@"15 Minutes" isEqualToString: [repeater titleOfSelectedItem]] )
  {
    checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 900
                                                        target: self
                                                      selector: @selector(intervalTimer:)
                                                      userInfo: nil
                                                       repeats: NO];
  }
  
	if ( [@"No!" isEqualToString: [repeater titleOfSelectedItem]] )
  {
    checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 600
                                                        target: self
                                                      selector: @selector(intervalTimer:)
                                                      userInfo: nil
                                                       repeats: NO];
  }
}

- (IBAction)visitWaniKani: (id)sender
{
  [[NSWorkspace sharedWorkspace] openURL: self.waniKaniUrl];
}

- (IBAction)showPreferences: (id)sender
{
  [NSApp activateIgnoringOtherApps: YES];
  [window makeKeyAndOrderFront: nil];
}

- (IBAction)quit: (id)sender
{
  [self saveKeys];
  [NSApp terminate: nil];
}

- (BOOL)hasInternet
{
  NSURL* url = [[NSURL alloc] initWithString: @"https://www.wanikani.com"];
  NSURLRequest* request = [[NSURLRequest alloc] initWithURL: url
                                                cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval: 5.0];
  BOOL connectedToInternet = NO;
  if ( [NSURLConnection sendSynchronousRequest: request
                             returningResponse: nil
                                         error: nil] )
  {
    connectedToInternet = YES;
  }
  
	if ( connectedToInternet )
  {
    NSLog(@"We Have Internet!");
  }

  return connectedToInternet;
}

- (void)applicationWillTerminate: (NSNotification*)aNotification
{
  [self saveKeys];
}

@end
