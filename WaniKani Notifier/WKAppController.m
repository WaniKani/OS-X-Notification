//
//  WKAppController.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKAppController.h"
#import "WKAppDelegate.h"
#import "WKNotifier.h"

@implementation WKAppController

#define kApiKey @"ApiKey"

-(void)loadKeys{
    [apiKey setStringValue:[[NSUserDefaults standardUserDefaults] objectForKey:kApiKey]];
}

-(IBAction)Close:(id)sender{
    [[NSUserDefaults standardUserDefaults] setObject:[apiKey stringValue] forKey:kApiKey];
    
    WKAppDelegate* appDelegate = [[NSApplication sharedApplication] delegate];
    [[appDelegate window] orderOut:self];
}

-(void)checkNotification:(id)sender;{
    if([[apiKey stringValue] length] == 32)
    {
        WKNotifier *notifier = [WKNotifier alloc];
        [notifier checkReviews:[apiKey stringValue]];
    }
}

-(void)awakeFromNib{
    if([[NSUserDefaults standardUserDefaults] objectForKey:kApiKey] != nil)
    {
        [apiKey setStringValue:[[NSUserDefaults standardUserDefaults] objectForKey:kApiKey]];
    }
        
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval: 300 target: self selector: @selector(checkNotification:) userInfo: nil repeats: YES];
}

@end
