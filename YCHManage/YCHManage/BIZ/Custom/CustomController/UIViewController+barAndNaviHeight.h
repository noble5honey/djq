//
//  UIViewController+barAndNaviHeight.h
//  YCHManage
//
//  Created by sunny on 2020/10/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (barAndNaviHeight)

//状态栏高度
- (float)statusbarHeight;

//导航栏高度+状态栏高度
- (float)navigationbarHeight;

 //Tabbar高度
- (float)tabbarHeight;

@end

NS_ASSUME_NONNULL_END
