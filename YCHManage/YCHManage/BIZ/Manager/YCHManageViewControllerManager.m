//
//  YCHManageViewControllerManager.m
//  YCHManage
//
//  Created by sunny on 2020/6/9.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHManageViewControllerManager.h"
#import "YCHLoginViewController.h"

@interface YCHManageViewControllerManager ()


@end

@implementation YCHManageViewControllerManager

static YCHManageViewControllerManager *sharedInstance = nil;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[YCHManageViewControllerManager alloc] init];
        
    });
    return sharedInstance;
}

- (void)showLaunchView {
    
//    AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//    UMSLaunchViewController *launchViewController = [[UMSLaunchViewController alloc] initWithNibName:nil bundle:nil];
//
//    appdelegate.window.rootViewController = launchViewController;
    
}

- (void)showTabController {


    AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    YCHTabBarController *tabBarController = [[YCHTabBarController alloc] init];
    appdelegate.window.rootViewController = tabBarController;

    self.tabBarController.selectedIndex = 0;

    self.rootController = self.tabBarController.viewControllers[0];
    
}

- (void)showWelcomeView {
    
//    AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//    UMSWelcomeViewController *welcomeViewController = [[UMSWelcomeViewController alloc] init];
//
//    appdelegate.window.rootViewController = welcomeViewController;
    
}

- (void)showHomePage {
    
//    AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
//
//    appdelegate.window.rootViewController = self.homepageController;
    
//    self.rootController = self.homepageController;
    
    AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    YCHHomePageViewController *homepage = [[YCHHomePageViewController alloc] init];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homepage];
    
    appdelegate.window.rootViewController = nav;
    
    self.rootController = (YCHNavigationController *)nav;
}

- (void)showLoginView {
    
    UINavigationController *navT =  self.tabBarController.selectedViewController;

    [navT popToRootViewControllerAnimated:NO];

    AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;


    YCHLoginViewController *loginController = [[YCHLoginViewController alloc] init];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginController];
    
    appdelegate.window.rootViewController = nav;
    
    self.rootController = (YCHNavigationController *)nav;
    
}

@end
