//
//  WKAppController.h
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKAppController : NSObject{
    IBOutlet NSTextField *apiKey;
}

-(IBAction)Close:(id)sender;
-(void)loadKeys;

@end
