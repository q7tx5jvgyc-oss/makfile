#import <UIKit/UIKit.h>

@interface ZSFakeTouch : NSObject
+ (instancetype)sharedInstance;
- (void)simulateTouch:(CGPoint)point type:(int)type;
@end

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // هنا يتم بناء النافذة 4x5 والأزرار
        UIWindow *win = [[UIWindow alloc] initWithFrame:CGRectMake(50, 100, 300, 400)];
        win.backgroundColor = [UIColor blackColor];
        win.hidden = NO;
        win.windowLevel = UIWindowLevelAlert;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setFrame:CGRectMake(10, 10, 280, 50)];
        [btn setTitle:@"بدء النقر" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startClicking) forControlEvents:UIControlEventTouchUpInside];
        [win addSubview:btn];
        
        [win makeKeyAndVisible];
    });
}
%new
- (void)startClicking {
    // محاكاة نقرة باستخدام ZSFakeTouch
    [[%c(ZSFakeTouch) sharedInstance] simulateTouch:CGPointMake(500, 500) type:1];
}
%end
