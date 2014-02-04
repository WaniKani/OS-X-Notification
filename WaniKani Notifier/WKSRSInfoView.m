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
    _titleTextField = [[NSTextField alloc] initWithFrame: CGRectMake(0, 0, 82, 22)];
		_titleTextField.textColor = COLOR_WHITE;
		[self addSubview: _titleTextField];
		
		_numberTextField = [[NSTextField alloc] initWithFrame: CGRectMake(0, 22, 82, 40)];
		_numberTextField.textColor = COLOR_WHITE;
		[self addSubview: _numberTextField];
  }
	
  return self;
}

- (void)drawRect: (NSRect)dirtyRect
{
	[super drawRect: dirtyRect];
	
	CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
	CGContextSetFillColorWithColor(context, self.levelInfo.color.CGColor);
	CGContextFillRect(context, NSRectToCGRect(dirtyRect));
}

#pragma mark -


@end
