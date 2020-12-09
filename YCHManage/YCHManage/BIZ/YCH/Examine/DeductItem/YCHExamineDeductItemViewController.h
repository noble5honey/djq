//
//  YCHExamineDeductItemViewController.h
//  YCHManage
//
//  Created by sunny on 2020/9/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef void (^examineDeductItemViewControllerBlock)(NSDictionary *selectedDic,NSIndexPath *indexpath);

@interface YCHExamineDeductItemViewController : YCHRootViewController

@property (nonatomic, copy) examineDeductItemViewControllerBlock blockparameter;

@property (nonatomic, assign) BOOL isCheckNoti;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil indexPath:(NSIndexPath *)indexPath;

@end
