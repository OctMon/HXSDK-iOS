//
//  AppDelegate.m
//  HXSDK-OC-Example
//
//  Created by 李蒙 on 2025/6/13.
//

#import "AppDelegate.h"

#import <HXSDK/HXSDK.h>

@interface AppDelegate () <HXSplashAdDelegate>

@property (nonatomic, strong) HXSplashAd *splashAd;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [HXSDK initWithAppIdWithAppId:@"71004"];
    [self.splashAd loadAd];
    return YES;
}

#pragma mark - get -
- (HXSplashAd *)splashAd {
    if (!_splashAd) {
        _splashAd = [[HXSplashAd alloc] initWithPlacementId:@"11111231"];
        _splashAd.delegate = self;
        _splashAd.rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;
    }
    return _splashAd;
}

#pragma mark - HXSplashAdDelegate -

/// 开屏加载成功
- (void)hxSplashAdDidLoad:(HXSplashAd *)splashAd {
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

/// 开屏加载失败
- (void)hxSplashAd:(HXSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏广告被点击了
- (void)hxSplashAdDidClick:(HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏广告关闭了
- (void)hxSplashAdDidClose:(HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

///  开屏广告将要展示
- (void)hxSplashAdWillVisible:(HXSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

///  开屏广告展示失败
- (void)hxSplashAdVisibleError:(HXSplashAd *)splashAd error:(NSError *)error {
    NSLog(@"开屏广告展示失败%s error = %@",__func__,error);
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
