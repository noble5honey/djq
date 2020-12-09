//
//  YCHExamineViewController.h
//  YCHManage
//
//  Created by sunny on 2020/6/28.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^YCHExamineViewControllerBlock)(void);

@interface YCHExamineViewController : YCHRootViewController

@property (nonatomic, copy) YCHExamineViewControllerBlock examineViewControllerBlock;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic;

@end

NS_ASSUME_NONNULL_END
