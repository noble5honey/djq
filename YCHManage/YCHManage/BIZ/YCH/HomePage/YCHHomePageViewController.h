//
//  YCHHomePageViewController.h
//  YCHManage
//
//  Created by sunny on 2020/6/18.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef NS_ENUM(NSUInteger, YCHHomePageTextFieldTpye) {
    YCHHomePageTextFieldTpyeFirstPageStart = 0,
    YCHHomePageTextFieldTpyeFirstPageEnd,
    YCHHomePageTextFieldTpyeSecondPageStart,
    YCHHomePageTextFieldTpyeSecondPageEnd
};

@interface YCHHomePageViewController : YCHRootViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil village:(NSString *)village isNoRectification:(BOOL)isNoRectification recentSevenDay:(NSString *)recentSevenDay recentMonth:(NSString *)recentMonth;

@end
