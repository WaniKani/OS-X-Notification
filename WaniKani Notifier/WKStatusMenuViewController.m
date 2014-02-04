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

// Views
#import "WKSRSInfoView.h"

NSString* const WKStatusMenuViewControllerShowPreferences = @"WKStatusMenuViewControllerShowPreferences";

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WKStatusMenuViewController ()
// Actions and Outlets
@property (nonatomic, weak) IBOutlet NSButton* refreshButton;
- (IBAction)refreshAction: (id)sender;
@property (nonatomic, weak) IBOutlet NSTextField* refreshStatusTextField;
@property (nonatomic, weak) IBOutlet NSButton* preferencesButton;
- (IBAction)preferencesAction: (id)sender;

@property (nonatomic, weak) IBOutlet WKSRSInfoView*		apprenticeInfoView;
@property (nonatomic, weak) IBOutlet WKSRSInfoView*		guruInfoView;
@property (nonatomic, weak) IBOutlet WKSRSInfoView*		masterInfoView;
@property (nonatomic, weak) IBOutlet WKSRSInfoView*		enlightenedInfoView;
@property (nonatomic, weak) IBOutlet WKSRSInfoView*		burnedInfoView;

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

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	self.apprenticeInfoView.levelInfo = self.srsDistribution.apprenticeLevelInfo;
	self.guruInfoView.levelInfo = self.srsDistribution.guruLevelInfo;
	self.masterInfoView.levelInfo = self.srsDistribution.masterLevelInfo;
	self.enlightenedInfoView.levelInfo = self.srsDistribution.enlightenLevelInfo;
	self.burnedInfoView.levelInfo = self.srsDistribution.burnedLevelInfo;
}

#pragma mark - Actions
- (IBAction)refreshAction: (id)sender
{
	
}

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
