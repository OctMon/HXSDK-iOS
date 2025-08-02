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

@interface KXBiddingLossType : NSObject

// MARK: - 竞价失败信息键值
/// 竞败原因（值类型：String）
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossInfoKey_LossReason;

/// 竞胜方平台（值类型：String）
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossInfoKey_WinPlatform;

/// 竞胜方价格（值类型：Int64）
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossInfoKey_WinPrice;

/// 竞胜广告素材地址（值类型：[String]）
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossInfoKey_WinMaterialURLs;

// MARK: - 竞价失败原因
/// 内部错误
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossReason_Error;

/// 响应超时
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossReason_Timeout;

/// 素材过滤
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossReason_MaterialFiler;

/// 低于底价
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossReason_LessThanFloor;

/// 价格劣势
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossReason_LowerPrice;

/// 被占量
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossReason_BeOccupied;

/// 其他原因
@property (class, nonatomic, copy, readonly) NSString *kHXBiddingLossReason_Other;

@end

@interface HXSDK : NSObject

+ (void)setAppId:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
