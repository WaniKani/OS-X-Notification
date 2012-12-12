//
//  MGPreferencePanel.m
//  MGPreferencePanel
//
//  Created by Michael on 29.03.10.
//  Copyright 2010 MOApp Software Manufactory. All rights reserved.
//


#define WINDOW_TOOLBAR_HEIGHT 78

#import "MGPreferencePanel.h"

// Default panes

NSString * const View1ItemIdentifier = @"View1ItemIdentifier";
NSString * const View1IconImageName = @"View1Icon";

NSString * const View2ItemIdentifier = @"View2ItemIdentifier";
NSString * const View2IconImageName = @"View2Icon";

NSString * const View3ItemIdentifier = @"View3ItemIdentifier";
NSString * const View3IconImageName = @"View3Icon";



@implementation MGPreferencePanel



-(void)	awakeFromNib
{
	[self mapViewsToToolbar];
	[self firstPane];
	[window center];
	//[window close];
}


-(void) mapViewsToToolbar
{
	// Application title
	NSString *app = @"myApp";
	
    NSToolbar *toolbar = [window toolbar];
	if(toolbar == nil)
	{
		toolbar = [[NSToolbar alloc] initWithIdentifier: [NSString stringWithFormat: @"%@.mgpreferencepanel.toolbar", app]];
	}
	
    [toolbar setAllowsUserCustomization: NO];
    [toolbar setAutosavesConfiguration: NO];
    [toolbar setDisplayMode: NSToolbarDisplayModeIconAndLabel];
    
    [toolbar setDelegate: self]; // 10.4 - otherwise use <NSToolbarDelegate>
    [window setToolbar: toolbar];
	[window setTitle: NSLocalizedString(@"General", @"")];
	
	if([toolbar respondsToSelector: @selector(setSelectedItemIdentifier:)])
	{
		[toolbar setSelectedItemIdentifier: View1ItemIdentifier];
	}
	
}


-(NSArray*) toolbarSelectableItemIdentifiers: (NSToolbar*)toolbar
{
	return [NSArray arrayWithObjects:
			View1ItemIdentifier,
			View2ItemIdentifier,
			View3ItemIdentifier,
			nil];
}


-(IBAction) changePanes: (id)sender
{
	NSView *view = nil;
	
	switch ([sender tag])
	{
		case 0:
			[window setTitle: NSLocalizedString(@"General", @"")];
			view = view1;
			break;
		case 1:
			[window setTitle: NSLocalizedString(@"User", @"")];
			view = view2;
			break;
		case 2:
			[window setTitle: NSLocalizedString(@"Advanced", @"")];
			view = view3;
			break;
		default:
			break;
	}
	
	NSRect windowFrame = [window frame];
	windowFrame.size.height = [view frame].size.height + WINDOW_TOOLBAR_HEIGHT;
	windowFrame.size.width = [view frame].size.width;
	windowFrame.origin.y = NSMaxY([window frame]) - ([view frame].size.height + WINDOW_TOOLBAR_HEIGHT);
	
	if ([[contentView subviews] count] != 0)
	{
		[[[contentView subviews] objectAtIndex:0] removeFromSuperview];
	}
	
	[window setFrame:windowFrame display:YES animate:YES];
	[contentView setFrame:[view frame]];
	[contentView addSubview:view];
}


-(void) firstPane
{
	NSView *view = nil;
	view = view1;
	
	NSRect windowFrame = [window frame];
	windowFrame.size.height = [view frame].size.height + WINDOW_TOOLBAR_HEIGHT;
	windowFrame.size.width = [view frame].size.width;
	windowFrame.origin.y = NSMaxY([window frame]) - ([view frame].size.height + WINDOW_TOOLBAR_HEIGHT);
	
	if ([[contentView subviews] count] != 0)
	{
		[[[contentView subviews] objectAtIndex:0] removeFromSuperview];
	}
	
	[window setFrame:windowFrame display:YES animate:YES];
	[contentView setFrame:[view frame]];
	[contentView addSubview:view];
}


- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    return [NSArray arrayWithObjects:
			View1ItemIdentifier,
			View2ItemIdentifier,
			View3ItemIdentifier,
			nil];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
    return [NSArray arrayWithObjects:
			View1ItemIdentifier,
			View2ItemIdentifier,
			View3ItemIdentifier,
			NSToolbarSeparatorItemIdentifier,
			NSToolbarSpaceItemIdentifier,
			NSToolbarFlexibleSpaceItemIdentifier,
			nil];
}





- (NSToolbarItem*)toolbar:(NSToolbar*)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)willBeInsertedIntoToolbar;
{
	NSToolbarItem *item = nil;
	
    if ([itemIdentifier isEqualToString:View1ItemIdentifier]) {
		
        item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        [item setPaletteLabel:NSLocalizedString(@"General", @"")];
        [item setLabel:NSLocalizedString(@"General", @"")];
        [item setImage:[NSImage imageNamed:NSImageNamePreferencesGeneral]];
		[item setAction:@selector(changePanes:)];
        [item setToolTip:NSLocalizedString(@"", @"")];
		[item setTag:0];
    }
	else if ([itemIdentifier isEqualToString:View2ItemIdentifier]) {
		
        item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        [item setPaletteLabel:NSLocalizedString(@"User", @"")];
        [item setLabel:NSLocalizedString(@"User", @"")];
        [item setImage:[NSImage imageNamed:NSImageNameUser]];
		[item setAction:@selector(changePanes:)];
        [item setToolTip:NSLocalizedString(@"", @"")];
		[item setTag:1];
    }
	else if ([itemIdentifier isEqualToString:View3ItemIdentifier]) {
		
        item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        [item setPaletteLabel:NSLocalizedString(@"Advanced", @"")];
        [item setLabel:NSLocalizedString(@"Advanced", @"")];
        [item setImage:[NSImage imageNamed:NSImageNameAdvanced]];
		[item setAction:@selector(changePanes:)];
        [item setToolTip:NSLocalizedString(@"", @"")];
		[item setTag:2];
    }
	return item;
}



@end