//
//  WKAppController.m
//  WaniKani Notifier
//
//  Created by Sebastian Szturo on 08.12.12.
//  Copyright (c) 2012 Sebastian Szturo. All rights reserved.
//

#import "WKAppController.h"
#import "WKApi.h"

@implementation WKAppController

#define kApiKey @"apiKey"
#define kMinReviews @"minReviews"
#define kRepeater @"repeater"
#define kSound @"sound"

-(void)saveKeys{
    [[NSUserDefaults standardUserDefaults] setObject:[apiKeyTextfield stringValue] forKey:kApiKey];
    [[NSUserDefaults standardUserDefaults] setObject:[minReviews titleOfSelectedItem] forKey:kMinReviews];
    [[NSUserDefaults standardUserDefaults] setObject:[repeater titleOfSelectedItem] forKey:kRepeater];
    [[NSUserDefaults standardUserDefaults] setObject:[sound titleOfSelectedItem] forKey:kSound];
}

-(void)loadKeys{
    [apiKeyTextfield setStringValue:[[NSUserDefaults standardUserDefaults] objectForKey:kApiKey]];
    [minReviews selectItemWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:kMinReviews]];
    [repeater selectItemWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:kRepeater]];
    [sound selectItemWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:kSound]];
}

-(void)awakeFromNib{
    api = [WKApi alloc];
    
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
        [self loadKeys];
        NSString *apiKeyValue = [[NSUserDefaults standardUserDefaults] objectForKey:kApiKey];
        [api setApiKey:apiKeyValue];
        NSLog(@"%@",[api apiKey]);
        [api updateAllData];
        
    }

    //Set Up API-Checker Timer
    NSTimer *checkApiKeyTimer;
    checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(intervalTimer:) userInfo: nil repeats: NO];

}

-(void)intervalTimer:(id)sender;{
    if([[apiKeyTextfield stringValue] length] == 32)
    {
        [api setApiKey:[apiKeyTextfield stringValue]];
        [api updateAllData];
        
        NSLog(@"API Key:%@/%@/%@",[apiKeyTextfield stringValue], [api apiKey], [api username]);
        
        NSString * nextReviewDateString = [api nextReviewDate];
        NSTimeInterval nextReviewInterval = [nextReviewDateString doubleValue];
        NSDate *nextReviewDate = [NSDate dateWithTimeIntervalSince1970:nextReviewInterval];
        
        NSDate *now = [NSDate date];
        
        NSDateFormatter* df_utc = [[NSDateFormatter alloc] init];
        [df_utc setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [df_utc setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
        
        NSString *utcNextReviewDate = [df_utc stringFromDate:nextReviewDate];
        NSString *utcNow= [df_utc stringFromDate:now];
        
        NSLog(@"nextReview: %@, Now: %@", utcNextReviewDate, utcNow);
        
        NSDate *reviewDate = [df_utc dateFromString:utcNextReviewDate];
        NSDate *nowDate = [df_utc dateFromString:utcNow];

        
        NSTimeInterval secondsBetween = [reviewDate timeIntervalSinceDate:nowDate];
        int secondsBetweenInt = secondsBetween;
        
        NSLog(@"secondsBetween: %d", secondsBetweenInt);
        
        if(secondsBetweenInt < -10){
            NSTimer *checkApiKeyTimer;
            checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 30 target: self selector: @selector(intervalTimer:) userInfo: nil repeats: NO];
        }
        else{
            
            NSTimer *reviewTimer;
            reviewTimer = [NSTimer scheduledTimerWithTimeInterval: secondsBetweenInt target: self selector: @selector(setupNotification:) userInfo: nil repeats: NO];
        }
        
    
        NSImage *image = [[NSImage alloc] initWithData:[NSData dataWithContentsOfURL:[api gravatar]]];
        [userImage setImage:image];
        NSLog(@"%@",userImage);
        
        [userName setStringValue:[NSString stringWithFormat:@"%@",[api username]]];
        NSLog(@"%@",[api username]);
        [userSect setStringValue:[NSString stringWithFormat:@"Sect of %@",[api title]]];
        [userLevel setStringValue:[NSString stringWithFormat:@"%@",[api level]]];
        
        [userRadicalText setStringValue:[NSString stringWithFormat:@"%@/%@",[api radicalsProgress],[api radicalsTotal]]];

        [userRadicalProgress setMaxValue:[[api radicalsTotal] doubleValue]];
        [userRadicalProgress setDoubleValue:[[api radicalsProgress] doubleValue]];
        
        [userKanjiText setStringValue:[NSString stringWithFormat:@"%@/%@",[api kanjiProgress],[api kanjiTotal]]];
        
        [userKanjiProgress setMaxValue:[[api kanjiTotal] doubleValue]];
        [userKanjiProgress setDoubleValue:[[api kanjiProgress] doubleValue]];
        
        NSLog(@"Userpanel rendered");
        
        [reviewsNextHourMenu setTitle:[NSString stringWithFormat:@"Reviews next Hour: %@",[api reviewsAvailableNextHour]]];
        [reviewsNextDayMenu setTitle:[NSString stringWithFormat:@"Reviews next Day: %@",[api reviewsAvailableNextDay]]];
         NSLog(@"%@",[api reviewsAvailableNextHour]);
        NSLog(@"Menu rendered");
        
    }
    else{
        NSTimer *checkApiKeyTimer;
        checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(intervalTimer:) userInfo: nil repeats: NO];
    }
}

- (void)setupNotification:(id)sender{
    [api updateStudyQueue];
    notifcation = [WKNotifier alloc];
    [notifcation setReviewsAvailable:[api reviewsAvailable]];
     NSLog(@"ReviewsAvailable: %@", [notifcation reviewsAvailable]);
    [notifcation sendNotification];
    NSLog(@"Notifications send");
    
    NSTimer *checkApiKeyTimer;
    checkApiKeyTimer = [NSTimer scheduledTimerWithTimeInterval: 600 target: self selector: @selector(intervalTimer:) userInfo: nil repeats: NO];
}

- (IBAction)showPreferences:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [window makeKeyAndOrderFront:nil];
}

- (IBAction)quit:(id)sender {
    [self saveKeys];
    [NSApp terminate:nil];
}


@end
