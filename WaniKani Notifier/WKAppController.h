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
    NSStatusItem *statusItem;
    IBOutlet NSMenu *statusMenu;
    IBOutlet NSWindow *window;
    IBOutlet NSTextField *apiKeyTextfield;
    
    WKApi *api;
    WKNotifier *notifcation;
}

- (IBAction)showPreferences:(id)sender;
- (IBAction)quit:(id)sender;

-(void)loadKeys;
-(void)saveKeys;

@end
