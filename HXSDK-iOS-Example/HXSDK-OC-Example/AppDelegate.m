#import "AppDelegate.h"

#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <HXSDK/HXSDK.h>

@interface AppDelegate ()<HXSplashAdDelegate>
{
    HXSplashAd *_splashAd;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [HXSDK setAppId:@"71004"];
    
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadUbiX];
            });
        }];
    } else {
        // iOS 14以下版本直接加载广告
        [self loadUbiX];
    }
    return YES;
}

- (void)loadUbiX {
    [self loadAd:@"15042297"];
}

- (void)loadPTG {
    [self loadAd:@"11111231"];
}

- (void)loadAd:(NSString *)placementId {
    _splashAd = [[HXSplashAd alloc] initWithPlacementId:placementId];
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    for (UIWindow *w in [UIApplication sharedApplication].windows) {
        if (w.isKeyWindow) {
            window = w;
            break;
        }
    }
    _splashAd.rootViewController = window.rootViewController;
    _splashAd.delegate = self;
    [_splashAd loadAd];
    NSLog(@"广告单元：%@", _splashAd.placementId);
}


#pragma mark - HXSplashAdDelegate -

/// 开屏加载成功
- (void)hxSplashAdDidLoad:(nonnull HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (splashAd.isValid) {
        UIWindow *keyWindow = nil;
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if (window.isKeyWindow) {
                keyWindow = window;
                break;
            }
        }

        if (keyWindow) {
            [splashAd showAdToWindow:keyWindow bottomView:nil];
        } else {
            NSLog(@"无法获取有效 keyWindow");
        }
    } else {
        NSLog(@"广告已过期");
    }
    
}

/// 开屏广告被点击了
- (void)hxSplashAdDidClick:(nonnull HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏广告关闭了
- (void)hxSplashAdDidClose:(nonnull HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏广告跳过了
- (void)hxSplashAdDidClickSkip:(nonnull HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}


- (void)hxSplashAdDidFinishConversion:(nonnull HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

- (void)hxSplashAdDidShow:(nonnull HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏加载失败
- (void)hxSplashAdFailedToLoad:(nonnull HXSplashAd *)splashAd withError:(nonnull NSError *)error {
    hxShowAlert([NSString stringWithFormat:@"hxSplashAdFailedToLoad", error], _splashAd.rootViewController);
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏广告展示失败
- (void)hxSplashAdFailedToShow:(nonnull HXSplashAd *)splashAd withError:(nonnull NSError *)error {
    hxShowAlert([NSString stringWithFormat:@"hxSplashAdFailedToShow", error], _splashAd.rootViewController);
    NSLog(@"开屏广告展示失败%s error = %@",__func__,error);
}

/// 开屏广告将要展示
- (void)hxSplashAdWillShow:(nonnull HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

@end
