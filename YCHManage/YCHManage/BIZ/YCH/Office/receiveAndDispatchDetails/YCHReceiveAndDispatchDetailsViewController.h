//
//  YCHReceiveAndDispatchDetailsViewController.h
//  YCHManage
//
//  Created by sunny on 2020/7/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef void (^YCHReceiveAndDispatchDetailsViewControllerBlock)(void);

@interface YCHReceiveAndDispatchDetailsViewController : YCHRootViewController

@property (nonatomic, copy) YCHReceiveAndDispatchDetailsViewControllerBlock examineViewControllerBlock;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic;

@end
