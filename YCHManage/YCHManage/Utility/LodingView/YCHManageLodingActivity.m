//
//  YCHManageLodingActivity.m
//  YCHManage
//
//  Created by sunny on 2020/6/8.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHManageLodingActivity.h"

@implementation YCHManageLodingActivity

+ (void)showLoadingActivityInView:(UIView *)superView {
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
}

+ (void)hideLoadingActivityInView:(UIView *)superView {
    [MBProgressHUD hideHUDForView:superView animated:YES];
    [self removeAllHudWithView:[self mainWindow]];
}

+ (void)removeAllHudWithView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subView;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:NO];
        } else {
            [self removeAllHudWithView:subView];
        }
    }
}

+ (UIWindow *)mainWindow {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)]) {
        return [app.delegate window];
    } else {
        return [app keyWindow];
    }
}

@end
