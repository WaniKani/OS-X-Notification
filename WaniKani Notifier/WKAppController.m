//
//  WKAppController.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKAppController.h"
#import "WKNotifier.h"

@implementation WKAppController

#define kApiKey @"ApiKey"

-(void)loadKeys{
    [apiKey setStringValue:[[NSUserDefaults standardUserDefaults] objectForKey:kApiKey]];
}

-(IBAction)Close:(id)sender{
    [[NSUserDefaults standardUserDefaults] setObject:[apiKey stringValue] forKey:kApiKey];
    [window orderOut:self];
}

-(void)checkNotification:(id)sender;{
    if([[apiKey stringValue] length] == 32)
    {
        WKNotifier *notifier = [WKNotifier alloc];
        [notifier checkReviews:[apiKey stringValue]];
    }
}

-(void)awakeFromNib{
    // Set up Statusbar Icon
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    [statusItem setMenu:statusMenu];
    [statusItem setHighlightMode:YES];
    [statusItem setImage:[NSImage imageNamed:@"menubar.png"]];
    [statusItem setAlternateImage: [NSImage imageNamed:@"menubar-invert.png"]];
    [statusItem setEnabled:YES];
    
    // Sets Default Values
    if([[NSUserDefaults standardUserDefaults] objectForKey:kApiKey] != nil)
    {
        [apiKey setStringValue:[[NSUserDefaults standardUserDefaults] objectForKey:kApiKey]];
    }
    
    // Start 5 min check timer
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval: 300 target: self selector: @selector(checkNotification:) userInfo: nil repeats: YES];
}

- (IBAction)showPreferences:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [window makeKeyAndOrderFront:nil];
}

- (IBAction)quit:(id)sender {
    [NSApp terminate:nil];
}

@end
