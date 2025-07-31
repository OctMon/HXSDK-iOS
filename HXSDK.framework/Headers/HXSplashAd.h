#import <UIKit/UIKit.h>

#if __has_include(<HXSDK/HXSplashAdDelegate.h>)
#import <HXSDK/HXSplashAdDelegate.h>
#else
#import <HXSplashAdDelegate.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface HXSplashAd : NSObject
{
    NSString *_reqId;
}
@property (nonatomic, weak) id<HXSplashAdDelegate> delegate;
@property (nonatomic, weak) UIViewController *rootViewController;

@property (nonatomic, assign, readonly) BOOL isValid;

- (instancetype)initWithPlacementId:(NSString *)placementId;
- (void)loadAd;
- (void)showAdToWindow:(UIWindow *)window;
- (void)showAdToWindow:(UIWindow *)window bottomView:(nullable UIView *)bottomView;

- (NSInteger)eCPM;

- (void)destroy;

@end

NS_ASSUME_NONNULL_END
