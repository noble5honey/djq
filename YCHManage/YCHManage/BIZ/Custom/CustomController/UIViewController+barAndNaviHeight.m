//
//  UIViewController+barAndNaviHeight.m
//  YCHManage
//
//  Created by sunny on 2020/10/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "UIViewController+barAndNaviHeight.h"

@implementation UIViewController (barAndNaviHeight)

- (float)statusbarHeight {
    //状态栏高度
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (float)navigationbarHeight {
    //导航栏高度+状态栏高度
    return self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (float)tabbarHeight {
    //Tabbar高度
    return self.tabBarController.tabBar.bounds.size.height;
}

@end
