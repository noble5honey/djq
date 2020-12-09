//
//  YCHManagerToast.h
//  YCHManage
//
//  Created by sunny on 2020/6/8.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCHManagerToast : NSObject

+ (void)showToastToView:(UIView *)view text:(NSString *)text time:(NSTimeInterval)time;

+ (void)showToastToView:(UIView *)view text:(NSString *)text;

+ (void)showToastToView:(UIView *)view text:(NSString *)text time:(NSTimeInterval)time completion:(void(^)())completion;

@end
