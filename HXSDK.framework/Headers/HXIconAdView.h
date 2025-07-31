#import <Foundation/Foundation.h>

#if __has_include(<CXHAdSDK-Core/CXHAdSDK.h>)
#import <CXHAdSDK-Core/CXHAdSDK.h>
#import <CXHAdSDK-Core/CXHAdSDKServiceAdView.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HXIconAdViewDelegate;

@interface HXIconAdView : UIView

/**
 广告生命周期代理
*/
@property (nonatomic, weak) id<HXIconAdViewDelegate> delegate;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 广告刷新时间间隔，30-120s之间.
*/
@property (nonatomic, assign) int refershTime;

/**
 是否展示关闭按钮，默认不展示，为YES则展示
*/
@property (nonatomic, assign) BOOL showCloseView;

/**
 viewControllerForPresentingModalView
 详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
*/
@property (nonatomic, weak) UIViewController *controller;

- (id)new NS_UNAVAILABLE;
- (id)init NS_UNAVAILABLE;

/*
 初始化bannerView
 @param frame 期望的banner视图尺寸
*/
- (instancetype)initWithFrame:(CGRect)frame;

/**
 拉取并展示广告
*/
- (void)loadAd;

- (void)reloadData;

- (void)setAdScenes:(NSDictionary *)scenes;

/**
 获取广告的竞价价格，单位分，为0则表示未成功获取到广告，或者不支持竞价，开启该功能需要联系媒介商务
 */
- (NSInteger)getBidPrice;
/**
 发送竞价成功上报
 @param price 赢价价格，单位分
 */
- (void)sendWinNotice:(NSInteger)price;

/**
 发送竞价失败上报
 @param price 赢价价格，单位分
 */
- (void)sendLossNotice:(NSInteger)price;

@end

@protocol HXIconAdViewDelegate <NSObject>

/**
 广告获取成功
 
 @param serviceAdView banner实例
 */
- (void)hx_serviceAdViewDidReceived:(HXIconAdView *)serviceAdView;

/**
 广告拉取失败
 
 @param serviceAdView banner实例
 @param error 错误描述
 */
- (void)hx_serviceAdViewFailToReceived:(HXIconAdView *)serviceAdView error:(NSError *)error;

/**
 广告点击
 
 @param serviceAdView 广告实例
 @param loadingPageURL 广告落地页地址，当渠道为bwt，并且customLoadingPage为YES时有值
 */
- (void)hx_serviceAdViewClicked:(HXIconAdView *)serviceAdView loadingPageURL:(NSString *)loadingPageURL;

/**
 广告关闭
 
 @param serviceAdView 广告实例
 */
- (void)hx_serviceAdViewClose:(HXIconAdView *)serviceAdView;

/**
 广告展示
 
 @param serviceAdView 广告实例
 */
- (void)hx_serviceAdViewExposure:(HXIconAdView *)serviceAdView;

/**
 广告展示上报
 
 @param serviceAdView 广告实例
 */
- (void)hx_serviceAdViewExposureReport:(HXIconAdView *)serviceAdView;

/**
 广告点击上报
 
 @param serviceAdView 广告实例
 */
- (void)hx_serviceAdViewClickedReport:(HXIconAdView *)serviceAdView;

/**
 关闭落地页
 
 @param serviceAdView 广告实例
 */
- (void)hx_serviceAdViewCloseLandingPage:(HXIconAdView *)serviceAdView;

@end

NS_ASSUME_NONNULL_END

#endif
