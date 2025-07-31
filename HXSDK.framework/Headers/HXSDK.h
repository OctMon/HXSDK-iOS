#import <Foundation/Foundation.h>

#if __has_include(<HXSDK/HXSplashAd.h>)
#import <HXSDK/HXSplashAd.h>
#endif

#if __has_include(<HXSDK/HXSplashAdDelegate.h>)
#import <HXSDK/HXSplashAdDelegate.h>
#endif

#if __has_include(<HXSDK/HXIconAdView.h>)
#import <HXSDK/HXIconAdView.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface HXSDK : NSObject

+ (void)setAppId:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
