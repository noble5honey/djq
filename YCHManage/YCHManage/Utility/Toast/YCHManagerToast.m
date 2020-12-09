//
//  YCHManagerToast.m
//  YCHManage
//
//  Created by sunny on 2020/6/8.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHManagerToast.h"

#define TIME_INTERVAL               1.0

@implementation YCHManagerToast

+ (void)showToastToView:(UIView *)view text:(NSString *)text {
    
    [YCHManagerToast showToastToView:view text:text time:TIME_INTERVAL];
    
}

+ (void)showToastToView:(UIView *)view text:(NSString *)text time:(NSTimeInterval)time
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:13.0];
    hud.mode = MBProgressHUDModeText;
    hud.opacity = 0.9;
    hud.margin = 10.0;
    hud.cornerRadius = 6.0;
    hud.yOffset = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    [hud hide:YES afterDelay:time];
}

+ (void)showToastToView:(UIView *)view text:(NSString *)text time:(NSTimeInterval)time completion:(void(^)())completion
{
    [YCHManagerToast showToastToView:view text:text time:time];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

@end
