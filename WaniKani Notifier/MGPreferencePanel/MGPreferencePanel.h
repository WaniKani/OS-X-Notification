	//
	//  MGPreferencePanel.h
	//  MGPreferencePanel
	//
	//  Revised by Michael on 03/03/12.
	//  Copyleft 2003-2012 MOApp Software Manufactory.
	//
    // License?
    // Do What The Fuck You Want To Public License, Version 2.


#import <Cocoa/Cocoa.h>

@interface MGPreferencePanel : NSObject
{
	IBOutlet NSView *view1;
	IBOutlet NSView *view2;
	IBOutlet NSView *view3;
	IBOutlet NSView *contentView;
	IBOutlet NSWindow *window;
}

- (void) mapViewsToToolbar;
- (void) firstPane;
- (IBAction) changePanes: (id) sender;

@end
