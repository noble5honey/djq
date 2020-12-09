//
//  YCHDeductScoreViewController.h
//  YCHManage
//
//  Created by sunny on 2020/6/30.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef void (^DeductScoreViewControllerBlock)(NSIndexPath *indexPath);

@interface YCHDeductScoreViewController : YCHRootViewController

@property (nonatomic, copy) DeductScoreViewControllerBlock blockparameter;

@property (nonatomic, strong) NSIndexPath *indexPath;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil indexPath:(NSIndexPath *)indexPath;

@end
