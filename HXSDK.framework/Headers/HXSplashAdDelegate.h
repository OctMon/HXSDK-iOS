#import <Foundation/Foundation.h>

@class HXSplashAd;

NS_ASSUME_NONNULL_BEGIN

@protocol HXSplashAdDelegate <NSObject>

/// 广告请求成功且素材加载完成，此时可调用 showAd 展示广告
- (void)hxSplashAdDidLoad:(HXSplashAd *)splashAd;

/// 广告请求失败
- (void)hxSplashAdFailedToLoad:(HXSplashAd *)splashAd withError:(NSError *)error;

/// 广告即将展示
- (void)hxSplashAdWillShow:(HXSplashAd *)splashAd;

/// 广告展示完毕
- (void)hxSplashAdDidShow:(HXSplashAd *)splashAd;

/// 广告展示失败
- (void)hxSplashAdFailedToShow:(HXSplashAd *)splashAd withError:(NSError *)error;

/// 广告点击回调
- (void)hxSplashAdDidClick:(HXSplashAd *)splashAd;

/// 广告点击跳过
- (void)hxSplashAdDidClickSkip:(HXSplashAd *)splashAd;

/// 广告关闭回调（跳过/倒计时结束/点击后关闭）
- (void)hxSplashAdDidClose:(HXSplashAd *)splashAd;

/// 广告转化完成（关闭落地页或跳转其他应用）
- (void)hxSplashAdDidFinishConversion:(HXSplashAd *)splashAd;

@end

NS_ASSUME_NONNULL_END
