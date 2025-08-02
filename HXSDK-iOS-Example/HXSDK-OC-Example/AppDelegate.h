#import <UIKit/UIKit.h>

static inline void hxShowAlert(NSString *message, UIViewController *sender) {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [sender presentViewController:alert animated:YES completion:nil];
}

@interface AppDelegate : UIResponder <UIApplicationDelegate>

- (void)loadUbiX;

- (void)loadPTG;

@end

