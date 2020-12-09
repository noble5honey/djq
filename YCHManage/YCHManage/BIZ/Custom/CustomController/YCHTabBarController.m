//
//  YCHTabBarController.m
//  YCHManage
//
//  Created by sunny on 2020/9/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHTabBarController.h"

#define TAB_BAR_TINT_COLOR                                                      \
[UIColor colorWithRed:231 / 255.0 green:90 / 255.0 blue:39 / 255.0 alpha:1.0]

@interface YCHTabBarController () <UITabBarControllerDelegate>

@end

@implementation YCHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundImage = [UIImage createImageViewWithColor:UMS_NAV_BACKGROUND_COLOR];
    [self.tabBar setShadowImage:[UIImage createImageViewWithColor:[UIColor clearColor]]];
    self.tabBar.tintColor = UMS_THEME_COLOR;
    
    self.delegate = self;
    
    [self initSubViewControllers];
}

- (void)initSubViewControllers {
    
    //首页
    self.overviewVC = [[YCHOverviewViewController alloc] initWithNibName:nil bundle:nil];
    self.overviewNC = [[YCHNavigationController alloc] initWithRootViewController:self.overviewVC];
    self.overviewNC.tabBarItem.title = @"渔家乐概览";
    
    UIImage * homePageImage = [UIImage imageNamed:@"TabBar-homePage-default"];
    UIGraphicsBeginImageContext(CGSizeMake(24, 24));
    [homePageImage drawInRect:CGRectMake(0.0f, 0.0f, 24, 24)];
    homePageImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.overviewNC.tabBarItem.image = homePageImage;
//    self.homePageNC.tabBarItem.image = [UIImage imageNamed:@"TabBar-homePage-default"];
    UIImage * homePageImageSelect = [UIImage imageNamed:@"TabBar-homePage-selected"];
    UIGraphicsBeginImageContext(CGSizeMake(24, 24));
    [homePageImageSelect drawInRect:CGRectMake(0.0f, 0.0f, 24, 24)];
    homePageImageSelect = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.overviewNC.tabBarItem.selectedImage = homePageImageSelect;
//    self.homePageNC.tabBarItem.selectedImage = [UIImage imageNamed:@"TabBar-homePage-selected"];
    [self.overviewNC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    //通告
    self.sendAndReciveVC = [[YCHSendAndReviceViewController alloc] initWithNibName:nil bundle:nil];
    self.sendAndReciveNC = [[YCHNavigationController alloc] initWithRootViewController:self.sendAndReciveVC];
    self.sendAndReciveNC.tabBarItem.title = @"通告";
    self.sendAndReciveNC.tabBarItem.image = [UIImage imageNamed:@"TabBar-notiPage-default"];
    self.sendAndReciveNC.tabBarItem.selectedImage = [UIImage imageNamed:@"TabBar-notiPage-selected"];
    [self.sendAndReciveNC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    //我的
    self.myVC = [[YCHMyViewController alloc] initWithNibName:nil bundle:nil];
    self.myNC = [[YCHNavigationController alloc] initWithRootViewController:self.myVC];
    self.myNC.tabBarItem.title = @"我的";
//    self.myNC.tabBarItem.image = [UIImage imageNamed:@"TabBar-myPage-default"];
//    self.myNC.tabBarItem.selectedImage = [UIImage imageNamed:@"TabBar-myPage-selected"];
    [self.myNC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    UIImage * myImage = [UIImage imageNamed:@"TabBar-myPage-default"];
    UIGraphicsBeginImageContext(CGSizeMake(24, 24));
    [myImage drawInRect:CGRectMake(0.0f, 0.0f, 24, 24)];
    myImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.myNC.tabBarItem.image = myImage;
    UIImage *myImageSelected = [UIImage imageNamed:@"TabBar-myPage-selected"];
    UIGraphicsBeginImageContext(CGSizeMake(24, 24));
    [myImageSelected drawInRect:CGRectMake(0.0f, 0.0f, 24, 24)];
    myImageSelected = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.myNC.tabBarItem.selectedImage = myImageSelected;
    self.viewControllers = @[self.overviewNC, self.sendAndReciveNC, self.myNC];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSUInteger selectedTab = [self whichTabSelectedAccordingViewController:viewController];
    self.selectedIndex = selectedTab;
    return YES;
}

- (NSUInteger)whichTabSelectedAccordingViewController:(UIViewController*)viewController {
    
//    YCHNavigationController * nc = (YCHNavigationController *)viewController;
    
    UIViewController * vc = viewController;
    if ([vc isKindOfClass:[YCHHomePageViewController class]]) {
        ViewControllerManager.rootController = self.overviewNC;
        return 0;
    } else if ([vc isKindOfClass:[YCHSendAndReviceViewController class]]) {
        ViewControllerManager.rootController = self.sendAndReciveNC;
        return 1;
    } else {
        return 2;
    }
    
}
    


@end
