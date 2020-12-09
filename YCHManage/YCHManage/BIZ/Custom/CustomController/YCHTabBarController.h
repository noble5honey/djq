//
//  YCHTabBarController.h
//  YCHManage
//
//  Created by sunny on 2020/9/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHSendAndReviceViewController.h"
#import "YCHMyViewController.h"
#import "YCHOverviewViewController.h"

@interface YCHTabBarController : UITabBarController

@property (nonatomic, strong) YCHNavigationController *overviewNC;

@property (nonatomic, strong) YCHOverviewViewController *overviewVC;

@property (nonatomic, strong) YCHNavigationController *sendAndReciveNC;

@property (nonatomic, strong) YCHSendAndReviceViewController *sendAndReciveVC;

@property (nonatomic, strong) YCHMyViewController *myVC;

@property (nonatomic, strong) YCHNavigationController *myNC;

@end
