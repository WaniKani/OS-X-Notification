//
//  WKSRSInfoView.m
//  WaniKani Notifier
//
//  Created by Jesse Curry on 2/1/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#import "WKSRSInfoView.h"

//
#import "WKSpacedRepetitionLevelInfo.h"
#import "WKColors.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WKSRSInfoView ()
@property (nonatomic, strong) NSColor* color;
@property (nonatomic, strong) NSTextField*	titleTextField;
@property (nonatomic, strong) NSTextField*	numberTextField;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WKSRSInfoView

+ (void)initialize
{
	[self exposeBinding: @"levelInfo"];
}

- (id)initWithFrame: (NSRect)frame
{
  self = [super initWithFrame: frame];
  if ( self )
  {
		CGFloat width = frame.size.width;
		
    _titleTextField = [[NSTextField alloc] initWithFrame: CGRectMake(0, 34, width, 22)];
		_titleTextField.textColor = COLOR_WHITE;
		[_titleTextField setDrawsBackground: NO];
		[_titleTextField setBordered: NO];
		[_titleTextField setSelectable: NO];
		[_titleTextField setAlignment: NSCenterTextAlignment];
		[_titleTextField setFont: [NSFont systemFontOfSize: 11.0]];
		NSShadow* titleShadow = [[NSShadow alloc] init];
		titleShadow.shadowOffset = CGSizeMake(1.0, 1.0);
		titleShadow.shadowColor = [NSColor darkGrayColor];
		titleShadow.shadowBlurRadius = 1.0;
		[_titleTextField setShadow: titleShadow];
		[self addSubview: _titleTextField];
		
		[_titleTextField bind: @"value"
								 toObject: self
							withKeyPath: @"levelInfo.title"
									options: nil];
		
		_numberTextField = [[NSTextField alloc] initWithFrame: CGRectMake(0, 0, width, 40)];
		_numberTextField.textColor = COLOR_WHITE;
		[_numberTextField setDrawsBackground: NO];
		[_numberTextField setBordered: NO];
		[_numberTextField setSelectable: NO];
		[_numberTextField setAlignment: NSCenterTextAlignment];
		[_numberTextField setFont: [NSFont boldSystemFontOfSize: 26.0]];
		NSShadow* numShadow = [[NSShadow alloc] init];
		numShadow.shadowOffset = CGSizeMake(1.0, 1.0);
		numShadow.shadowColor = [NSColor darkGrayColor];
		numShadow.shadowBlurRadius = 2.0;
		[_numberTextField setShadow: numShadow];
		[self addSubview: _numberTextField];
		
		[_numberTextField bind: @"value"
									toObject: self
							 withKeyPath: @"levelInfo.totalCount"
									 options: nil];
  }
	
  return self;
}

- (void)drawRect: (NSRect)dirtyRect
{
	[NSGraphicsContext saveGraphicsState];

	[self.levelInfo.color set];
	NSRectFill(dirtyRect);
	
	[NSGraphicsContext restoreGraphicsState];
}

#pragma mark -


@end
