import UIKit
import AppTrackingTransparency

import HXSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, HXSplashAdDelegate {
    
    var window: UIWindow?
    
    var splashAd: HXSplashAd?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        HXSDK.initWithAppId(appId: "xxxxx")
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                // 处理授权状态
                DispatchQueue.main.async {
                    self.loadAd()
                }
            }
        } else {
            // iOS 14 以下版本直接加载广告
            self.loadAd()
        }
        
        return true
    }
    
    func loadAd() {
        splashAd = HXSplashAd(placementId: "xxxxxxxx")
        splashAd?.rootViewController = window?.rootViewController
        splashAd?.delegate = self
        splashAd?.loadAd()
    }
    
    // MARK: - Delegate Protocol
    
    func hxSplashAdDidLoad(_ splashAd: HXSplashAd) {
        debugPrint("hxSplashAdDidLoad")
        // 创建底部视图
        let screenWidth = UIScreen.main.bounds.width
        let bottomView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 120))
        bottomView.backgroundColor = .lightGray
        
        // 添加 Logo 标签
        let titleLabel = UILabel(frame: bottomView.bounds)
        titleLabel.textAlignment = .center
        titleLabel.text = "Your App Logo"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .blue
        bottomView.addSubview(titleLabel)
        
        // 检查广告有效性
        if splashAd.isValid {
            if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                splashAd.showAdToWindow(keyWindow, bottomView: bottomView)
            } else {
                debugPrint("无法获取有效 keyWindow")
            }
        } else {
            debugPrint("当前广告无效不进行展示")
        }
    }
    
    func hxSplashAdFailedToLoad(_ splashAd: HXSplashAd, withError error: any Error) {
        debugPrint("hxSplashAdFailedToLoad: \(error)")
    }
    
    func hxSplashAdWillShow(_ splashAd: HXSplashAd) {
        debugPrint("hxSplashAdWillShow")
    }
    
    func hxSplashAdDidShow(_ splashAd: HXSplashAd) {
        debugPrint("hxSplashAdDidShow")
    }
    
    func hxSplashAdFailedToShow(_ splashAd: HXSplashAd, withError error: any Error) {
        debugPrint("hxSplashAdFailedToShow: \(error)")
    }
    
    func hxSplashAdDidClick(_ splashAd: HXSplashAd) {
        debugPrint("hxSplashAdDidClick")
    }
    
    func hxSplashAdDidFinishConversion(_ splashAd: HXSplashAd, interactionType: HXAdInteractionType) {
        debugPrint("hxSplashAdDidFinishConversion: \(interactionType.description)")
    }
    
    func hxSplashAdDidClickSkip(_ splashAd: HXSplashAd) {
        debugPrint("hxSplashAdDidClickSkip")
    }
    
    func hxSplashAdDidClose(_ splashAd: HXSplashAd) {
        debugPrint("hxSplashAdDidClose")
    }
    
}

