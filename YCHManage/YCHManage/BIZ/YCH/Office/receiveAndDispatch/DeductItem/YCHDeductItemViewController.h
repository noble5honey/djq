//
//  YCHDeductItemViewController.h
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^YCHDeductItemViewControllerBlock)(NSString *deductItemStr);

@interface YCHDeductItemViewController : YCHRootViewController

@property (nonatomic, copy) YCHDeductItemViewControllerBlock deductItemStrblock;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil itemArray:(NSArray *)itemArray selectArray:(NSArray *)selectArray;

@end

NS_ASSUME_NONNULL_END
