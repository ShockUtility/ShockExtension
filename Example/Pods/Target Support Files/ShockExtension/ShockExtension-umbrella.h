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

#import "TOActivityChrome.h"
#import "TOActivitySafari.h"

FOUNDATION_EXPORT double ShockExtensionVersionNumber;
FOUNDATION_EXPORT const unsigned char ShockExtensionVersionString[];

