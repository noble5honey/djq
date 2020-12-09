//
//  YCHManageViewControllerManager.h
//  YCHManage
//
//  Created by sunny on 2020/6/9.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "YCHHomePageViewController.h"
#import "YCHTabBarController.h"

#define ViewControllerManager [YCHManageViewControllerManager sharedInstance]

@interface YCHManageViewControllerManager : NSObject

@property (nonatomic, strong) YCHNavigationController *rootController;
@property (nonatomic, strong) YCHHomePageViewController *homepageController;

@property (nonatomic, strong) YCHTabBarController *tabBarController;


+ (instancetype)sharedInstance;

- (void)showLaunchView;

- (void)showTabController;

- (void)showWelcomeView;

- (void)showLoginView;

- (void)showHomePage;

@end
