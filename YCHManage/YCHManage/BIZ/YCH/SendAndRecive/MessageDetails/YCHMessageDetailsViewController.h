//
//  YCHMessageDetailsViewController.h
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef void (^messageDetailsViewControllerBlock)(BOOL isUpdateData);

@interface YCHMessageDetailsViewController : YCHRootViewController

@property (nonatomic, copy) messageDetailsViewControllerBlock messageDetailsViewControllerBlock;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic;

@end
