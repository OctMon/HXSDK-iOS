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

- (void)hxSplashAdDidClick:(nonnull HXSplashAd *)splashAd {
    NSLog(@"hxSplashAdDidClick");
}

- (void)hxSplashAdDidClickSkip:(nonnull HXSplashAd *)splashAd {
    NSLog(@"hxSplashAdDidClickSkip");
}

- (void)hxSplashAdDidClose:(nonnull HXSplashAd *)splashAd {
    NSLog(@"hxSplashAdDidClose");
}

- (void)hxSplashAdDidFinishConversion:(nonnull HXSplashAd *)splashAd {
    NSLog(@"hxSplashAdDidFinishConversion");
}

- (void)hxSplashAdDidLoad:(nonnull HXSplashAd *)splashAd {
    NSLog(@"hxSplashAdDidLoad");
    // 创建底部视图
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 120)];
    bottomView.backgroundColor = [UIColor lightGrayColor];

    // 添加 Logo 标签
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:bottomView.bounds];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"Your App Logo";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor blueColor];
    [bottomView addSubview:titleLabel];

    // 检查广告有效性
    if (splashAd.isValid) {
        // 获取 keyWindow
        UIWindow *keyWindow = nil;
        if (@available(iOS 13.0, *)) {
            NSSet<UIScene *> *scenes = [UIApplication sharedApplication].connectedScenes;
            for (UIScene *scene in scenes) {
                if ([scene isKindOfClass:[UIWindowScene class]]) {
                    UIWindowScene *windowScene = (UIWindowScene *)scene;
                    for (UIWindow *window in windowScene.windows) {
                        if (window.isKeyWindow) {
                            keyWindow = window;
                            break;
                        }
                    }
                }
                if (keyWindow) break;
            }
        }
        
        if (keyWindow) {
            [splashAd showAdToWindow:keyWindow bottomView:bottomView];
        } else {
            NSLog(@"无法获取有效 keyWindow");
        }
    } else {
        NSLog(@"当前广告无效不进行展示");
    }
}

- (void)hxSplashAdDidShow:(nonnull HXSplashAd *)splashAd {
    NSLog(@"hxSplashAdDidShow");
}

- (void)hxSplashAdFailedToLoad:(nonnull HXSplashAd *)splashAd withError:(nonnull NSError *)error {
    hxShowAlert([NSString stringWithFormat:@"hxSplashAdFailedToLoad", error], _splashAd.rootViewController);
    NSLog(@"hxSplashAdFailedToLoad: %@", error);
}

- (void)hxSplashAdFailedToShow:(nonnull HXSplashAd *)splashAd withError:(nonnull NSError *)error {
    hxShowAlert([NSString stringWithFormat:@"hxSplashAdFailedToShow", error], _splashAd.rootViewController);
    NSLog(@"hxSplashAdFailedToShow: %@", error);
}

- (void)hxSplashAdWillShow:(nonnull HXSplashAd *)splashAd {
    NSLog(@"hxSplashAdWillShow");
}

@end
