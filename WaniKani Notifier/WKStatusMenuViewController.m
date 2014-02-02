//
//  WKStatusMenuViewController.m
//  WaniKani Notifier
//
//  Created by Jesse Curry on 2/1/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import "WKStatusMenuViewController.h"

// Models
#import "WKUser.h"
#import "WKStudyQueue.h"
#import "WKLevelProgression.h"
#import "WKSpacedRepetitionSystemDistribution.h"

NSString* const WKStatusMenuViewControllerShowPreferences = @"WKStatusMenuViewControllerShowPreferences";

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WKStatusMenuViewController ()
// Actions and Outlets
@property (nonatomic, weak) IBOutlet NSButton* preferencesButton;
- (IBAction)preferencesAction: (id)sender;

//
@property (nonatomic, readonly) NSNotificationCenter* notificationCenter;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKStatusMenuViewController

- (id)initWithNibName: (NSString*)nibNameOrNil
               bundle: (NSBundle*)nibBundleOrNil
{
  self = [super initWithNibName: nibNameOrNil
                         bundle: nibBundleOrNil];
  if ( self )
  {
    // Initialization code here.
  }
	
  return self;
}

#pragma mark - Actions
- (IBAction)preferencesAction: (id)sender
{
	
	[self.notificationCenter postNotificationName: WKStatusMenuViewControllerShowPreferences
																				 object: self];
}

#pragma mark -
- (NSNotificationCenter*)notificationCenter
{
	return [NSNotificationCenter defaultCenter];
}

@end
