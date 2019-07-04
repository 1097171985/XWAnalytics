#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "XWAnalyticsManager.h"
#import "XWAspects.h"

FOUNDATION_EXPORT double XWAnalyticsVersionNumber;
FOUNDATION_EXPORT const unsigned char XWAnalyticsVersionString[];

