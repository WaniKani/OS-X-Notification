//
//  WKColors.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 2/1/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#ifndef WaniKani_Notifier_WKColors_h
#define WaniKani_Notifier_WKColors_h

////////////////////////////////////////////////////////////////////////////////////////////////////
// Colors
#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed: (r) green: (g) blue: (b) alpha: (a)]
#define COLOR_RGB(r,g,b) COLOR_RGBA((r)/255.0, (g)/255.0, (b)/255.0, 1.0)

// SRS Levels
#define COLOR_APPRENTICE		(COLOR_RGB(221, 0, 147))
#define COLOR_GURU					(COLOR_RGB(136, 45, 158))
#define COLOR_MASTER				(COLOR_RGB(41, 77, 219))
#define COLOR_ENLIGHTENED		(COLOR_RGB(0, 147, 221))
#define COLOR_BURNED				(COLOR_RGB(67, 67, 67))

#endif
