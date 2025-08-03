#import "ViewController.h"
#import <HXSDK/HXSDK.h>
#import "AppDelegate.h"

@interface ViewController() <HXIconAdViewDelegate>{
    HXIconAdView *_serviceView;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSArray<NSValue *>*excludedFrames;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _excludedFrames = @[
        [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 200, 50, 50)], // 其他视图的 frame
        // 添加更多需要避开的 frame...
    ];
}

- (IBAction)ubiXShow:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate loadUbiX];
}

- (IBAction)ptgShow:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate loadPTG];
}

- (IBAction)loadService:(id)sender {
    // 生成随机位置
    CGSize adSize = CGSizeMake(50, 50);
    CGRect randomFrame = [self randomNonOverlappingFrameWithSize:adSize excludedFrames:_excludedFrames];

    _serviceView = [[HXIconAdView alloc] initWithFrame:randomFrame];
    
    _serviceView.delegate = self;
    _serviceView.controller = self;
    _serviceView.posId = @"11111236";
    _serviceView.showCloseView = YES;
//    _serviceView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_serviceView];
    [_serviceView loadAd];
}

// 生成不重叠的随机位置（返回 CGRect）
- (CGRect)randomNonOverlappingFrameWithSize:(CGSize)size excludedFrames:(NSArray<NSValue *> *)excludedFrames {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // 最大尝试次数（避免无限循环）
    NSInteger maxAttempts = 50;
    for (NSInteger i = 0; i < maxAttempts; i++) {
        // 随机 x 和 y（确保在屏幕内）
        CGFloat randomX = arc4random_uniform(screenWidth - size.width);
        CGFloat randomY = arc4random_uniform(screenHeight - size.height);
        CGRect randomFrame = CGRectMake(randomX, randomY, size.width, size.height);
        
        // 检查是否与已有 frame 重叠
        BOOL isOverlapping = NO;
        for (NSValue *value in excludedFrames) {
            CGRect excludedFrame = [value CGRectValue];
            if (CGRectIntersectsRect(randomFrame, excludedFrame)) {
                isOverlapping = YES;
                break;
            }
        }
        
        // 如果不重叠，返回
        if (!isOverlapping) {
            return randomFrame;
        }
    }
    
    // 如果多次尝试后仍重叠，返回默认位置（屏幕右下角）
    return CGRectMake(screenWidth - size.width, screenHeight - size.height, size.width, size.height);
}

- (void)showLog:(NSString *)logStr {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *logS = self.textView.text;
        NSString *log = nil;
        if (![logS isEqualToString:@""]) {
            log = [NSString stringWithFormat:@"%@\n%@", logS, logStr];
        } else {
            log = [NSString stringWithFormat:@"%@", logStr];
        }
        self.textView.text = log;
        [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
    });
}

#pragma mark - HXIconAdViewDelegate

/**
 广告获取成功
 
 @param serviceAdView banner实例
 */
- (void)hx_serviceAdViewDidReceived:(HXIconAdView *)serviceAdView{
    NSLog(@"hx_serviceAdViewDidReceived");
}

/**
 广告拉取失败
 
 @param serviceAdView banner实例
 @param error 错误描述
 */
- (void)hx_serviceAdViewFailToReceived:(HXIconAdView *)serviceAdView error:(NSError *)error{
    hxShowAlert([NSString stringWithFormat:@"hx_serviceAdViewFailToReceived", error], self);
    NSLog(@"hx_serviceAdViewFailToReceived: %@", error);
}

/**
 广告点击
 
 @param serviceAdView 广告实例
 @param loadingPageURL 广告落地页地址，当渠道为bwt，并且customLoadingPage为YES时有值
 */
- (void)hx_serviceAdViewClicked:(HXIconAdView *)serviceAdView loadingPageURL:(NSString *)loadingPageURL{
    NSLog(@"hx_serviceAdViewClicked: %@", loadingPageURL);
}

/**
 广告关闭
 
 @param serviceAdView 广告实例
 */
- (void)hx_serviceAdViewClose:(HXIconAdView *)serviceAdView{
    NSLog(@"hx_serviceAdViewClose");
}

/**
 广告展示
 
 @param serviceAdView 广告实例
 */
- (void)hx_serviceAdViewExposure:(HXIconAdView *)serviceAdView{
    NSLog(@"hx_serviceAdViewExposure");
}

/**
 关闭落地页
 
 @param serviceAdView 广告实例
 */
- (void)hx_serviceAdViewCloseLandingPage:(HXIconAdView *)serviceAdView{
    NSLog(@"hx_serviceAdViewCloseLandingPage");
}

- (void)hx_serviceAdViewClickedReport:(nonnull HXIconAdView *)serviceAdView {
    NSLog(@"hx_serviceAdViewClickedReport");
}


- (void)hx_serviceAdViewExposureReport:(nonnull HXIconAdView *)serviceAdView {
    NSLog(@"hx_serviceAdViewExposureReport");
}

@end
