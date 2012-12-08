//
//  WKAppDelegate.h
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WKAppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate>{
    NSStatusItem *statusItem;
    IBOutlet NSMenu *statusMenu;
    IBOutlet NSWindow *window;

}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)showPreferences:(id)sender;
- (IBAction)quit:(id)sender;

@end
