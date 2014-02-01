//
//  WKDefines.h
//  WaniKani Notifier
//
//  Created by Jesse Curry on 1/31/14.
//  Copyright (c) 2014 Sebastian Szturo. All rights reserved.
//

#ifndef WaniKani_Notifier_WKDefines_h
#define WaniKani_Notifier_WKDefines_h

////////////////////////////////////////////////////////////////////////////////////////////////////
// Class Safety
#define FORCE_STRING(x)					((x) ? (x) : @"")
#define SAFE_STRING(str)        ([str isKindOfClass: [NSString class]] ? str : nil)
#define SAFE_NUMBER(num)        ([num isKindOfClass: [NSNumber class]] ? num : nil)
#define SAFE_ARRAY(arr)         ([arr isKindOfClass: [NSArray class]] ? arr : nil)
#define SAFE_DICTIONARY(dict)   ([dict isKindOfClass: [NSDictionary class]] ? dict : nil)


#endif
