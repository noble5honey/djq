//
//  YCHManageLodingActivity.h
//  YCHManage
//
//  Created by sunny on 2020/6/8.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YCHManageLodingActivity : NSObject

+ (void)showLoadingActivityInView:(UIView *)superView;

+ (void)hideLoadingActivityInView:(UIView *)superView;

@end
