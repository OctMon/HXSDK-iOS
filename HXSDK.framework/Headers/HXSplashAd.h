#import <UIKit/UIKit.h>

#import "HXSplashAdDelegate.h"

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

- (void)sendWinNotice:(long)secondPrice;

- (void)sendLossNotice:(NSDictionary *)secondPrice;

- (NSInteger)eCPM;

- (NSString *)placementId;

- (void)destroy;

@end

NS_ASSUME_NONNULL_END
