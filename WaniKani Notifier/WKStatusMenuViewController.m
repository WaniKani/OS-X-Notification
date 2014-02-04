//
//  WKStatusMenuViewController.m
//  WaniKani Notifier
//
//  Created by Jesse Curry on 2/1/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import "WKStatusMenuViewController.h"

#import "WKApi.h"

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
@property (nonatomic, readonly) WKApi* api;
@property (nonatomic, readonly) WKUser* user;
@property (nonatomic, readonly) WKStudyQueue* studyQueue;
@property (nonatomic, readonly) WKLevelProgression* levelProgression;
@property (nonatomic, readonly) WKSpacedRepetitionSystemDistribution* srsDistribution;
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
	if ( self.api.isUpdating == NO )
	{
		[self.api updateAllData];
	}
}

- (IBAction)preferencesAction: (id)sender
{
	[self.notificationCenter postNotificationName: WKStatusMenuViewControllerShowPreferences
																				 object: self];
}

#pragma mark -
- (WKApi*)api
{
	return [WKApi sharedInstance];
}

- (WKUser*)user
{
	return self.api.user;
}

+ (NSSet*)keyPathsForValuesAffectingUser
{
	return [NSSet setWithObjects: @"api", nil];
}

- (WKStudyQueue*)studyQueue
{
	return self.api.studyQueue;
}

+ (NSSet*)keyPathsForValuesAffectingStudyQueue
{
	return [NSSet setWithObjects: @"api", nil];
}

- (WKLevelProgression*)levelProgression
{
	return self.api.levelProgression;
}

+ (NSSet*)keyPathsForValuesAffectingLevelProgression
{
	return [NSSet setWithObjects: @"api", nil];
}

- (WKSpacedRepetitionSystemDistribution*)srsDistribution
{
	return self.api.srsDistribution;
}

+ (NSSet*)keyPathsForValuesAffectingSrsDistribution
{
	return [NSSet setWithObjects: @"api", nil];
}

- (NSNotificationCenter*)notificationCenter
{
	return [NSNotificationCenter defaultCenter];
}

@end
