# iOS 广告SDK接入文档

## **前提条件**

* 推荐Xcode 12及以上版本

* 支持iOS 11.0或更高版本

## 导入 SDK

使用CocoaPods导入SDK

```shell
pod 'HXSDK/LY', '3.1.2'
```

1.将SKAdNetwork ID 添加到 info.plist 中，以保证 SKAdNetwork 的正确运行
```xml
<key>SKAdNetworkItems</key>
  <array>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>22mmun2rn5.skadnetwork</string>
    </dict>
  </array>
```

2.将LSApplicationQueriesSchemes 添加到 info.plist 中，以保证精准投放
```xml
<key>LSApplicationQueriesSchemes</key>
   <array>
       <string>tbopen</string>
       <string>tmall</string>
       <string>wireless1688</string>
       <string>alipays</string>
       <string>taobaoliveshare</string>
       <string>youku</string>
       <string>eleme</string>
       <string>fleamarket</string>
       <string>dingtalk</string>
       <string>taobaotravel</string>
       <string>dydeeplink</string>
       <string>changba</string>
       <string>mogujie</string>
       <string>snssdk143</string>
       <string>snssdk1128</string>
       <string>snssdk2329</string>
       <string>snssdk8663</string>
       <string>snssdk32</string>
       <string>dragon1967</string>
       <string>jdmobile</string>
       <string>openjd</string>
       <string>vipshop</string>
       <string>imeituan</string>
       <string>dianping</string>
       <string>meituanwaimai</string>
       <string>ksnebula</string>
       <string>baiduboxapp</string>
       <string>baiduboxlite</string>
       <string>iqiyi</string>
       <string>yanxuan</string>
       <string>orpheus</string>
       <string>onetravel</string>
       <string>kfhxzdriver</string>
       <string>wbmain</string>
       <string>wbganji</string>
       <string>sinaweibo</string>
       <string>autohome</string>
       <string>ctrip</string>
       <string>bilibili</string>
       <string>iting</string>
       <string>soul</string>
       <string>zhihu</string>
       <string>xhsdiscover</string>
       <string>dewuapp</string>
       <string>smzdm</string>
       <string>taoumaimai</string>
       <string>sohunews</string>
       <string>sohuvideo</string>
       <string>pinduoduo</string>
   </array>
```

## 全局配置

**iOS 14 AppTrackingTransparency**

iOS 14 开始，在应用调用 App Tracking Transparency framework 向用户请求应用跟踪权限之前，IDFA 将不可用。如果应用没有向用户发出请求，则 IDFA 将自动清零，这可能会导致广告收入出现重大损失。因为用户必须授权IDFA。

应用开发者可以控制请求 App Tracking Transparency 框架来申请跟踪权限的时机。

要显示用于访问 IDFA 的 App Tracking Transparency 授权请求，请更新 Info.plist 以添加 NSUserTrackingUsageDescription 键，值为描述应用如何使用 IDFA 的自定义消息。 以下是示例描述文字：

```xml
<key>NSUserTrackingUsageDescription</key>
<string>需要获取您设备的广告标识符，以为您提供更好的广告体验</string>
```

要显示授权请求对话框，请调用 [requestTrackingAuthorizationWithCompletionHandler:](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization)。 我们建议您在授权回调之后再加载广告，以便如果用户允许跟踪权限，则 SDK 可以在广告请求中使用 IDFA，示例代码如下：

```objective-c
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
- (void)requestIDFA {
       if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 加载广告
            });
        }];
    } else {
        
    }
}
```

SKAdNetwork（SKAN）是 Apple 的归因解决方案，可帮助广告客户在保持用户隐私的同时衡量广告活动。 使用 Apple 的 SKAdNetwork 后，即使 IDFA 不可用，广告网络也可以正确获得应用安装的归因结果。 访问 https://developer.apple.com/documentation/storekit/skadnetwork 了解更多信息。

1. 应用编译环境升级至 `Xcode 12.0 及以上版本`
2. 将 SKAdNetwork ID 添加到 info.plist 中，以保证 `SKAdNetwork` 的正确运行

```xml
<key>SKAdNetworkItems</key>
  <array>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>22mmun2rn5.skadnetwork</string>
    </dict>
  </array>
```

## SDK初始化

加载广告之前，请先使用 HXSDK 应用 ID 进行初始化，此操作仅需执行一次，最好是在应用启动时执行。

```objective-c
#import #import <HXSDK/HXSDK.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [HXSDK initWithAppIdWithAppId:appId];
    return YES;
}

@end
```

## 开屏广告

开屏广告用于当用户进入您的应用展示，一般会展示 5 秒（部分可以跳过），倒计时结束会自动关闭。与插屏广告不同，开屏广告可以轻松地展示应用品牌（Logo 和名称），以便用户了解他们看到广告的环境。

### 开屏广告加载

初始化开屏广告对象，使用开屏广告id加载广告。

以下示例演示了如何在 AppDelegate 的 application:didFinishLaunchingWithOptions: 方法中创建并请求开屏广告。

```objective-c
#import #import <HXSDK/HXSDK.h>

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
@end
```

### 开屏广告事件

设置开屏广告的delegate，delegate遵守并实现HXSplashAdDelegate，可以监听广告的生命周期事件。

```objective-c
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
```
