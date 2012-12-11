//
//  WKAppController.h
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKApi.h"
#import "WKNotifier.h"

@interface WKAppController : NSObject{
    IBOutlet NSWindow *window;
    
    NSStatusItem *statusItem;
    IBOutlet NSMenu *statusMenu;
    IBOutlet NSMenuItem *reviewsNextHourMenu;
    IBOutlet NSMenuItem *reviewsNextDayMenu;
    
    IBOutlet NSTextField *apiKeyTextfield;
    IBOutlet NSPopUpButton *minReviews;
    IBOutlet NSPopUpButton *repeater;
    IBOutlet NSPopUpButton *sound;
    
    IBOutlet NSImageView *userImage;
    IBOutlet NSTextField *userName;
    IBOutlet NSTextField *userSect;
    IBOutlet NSTextField *userLevel;
    IBOutlet NSTextField *userTopicCount;
    IBOutlet NSTextField *userPostCount;
    
    IBOutlet NSTextField *userRadicalText;
    IBOutlet NSLevelIndicator *userRadicalProgress;
    
    IBOutlet NSTextField *userKanjiText;
    IBOutlet NSLevelIndicator *userKanjiProgress;
    
    WKApi *api;
    WKNotifier *notifcation;
}

- (IBAction)showPreferences:(id)sender;
- (IBAction)quit:(id)sender;

-(void)loadKeys;
-(void)saveKeys;

@end
