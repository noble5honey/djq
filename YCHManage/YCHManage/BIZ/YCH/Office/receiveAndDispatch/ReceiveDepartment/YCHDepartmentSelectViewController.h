//
//  YCHDepartmentSelectViewController.h
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef void (^YCHDepartmentSelectViewControllerBlock)(NSArray *departmentReusltArray);

@interface YCHDepartmentSelectViewController : YCHRootViewController

@property (nonatomic, copy) YCHDepartmentSelectViewControllerBlock departmentResultblock;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil itemArray:(NSArray *)itemArray selectArray:(NSArray *)selectArray;

@end
