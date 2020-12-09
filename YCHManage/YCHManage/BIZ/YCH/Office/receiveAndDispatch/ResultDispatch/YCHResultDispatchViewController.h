//
//  YCHResultDispatchViewController.h
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef void (^ResultDispatchViewControllerBlock)(BOOL isSendSuccess);

@interface YCHResultDispatchViewController : YCHRootViewController

@property (nonatomic, copy) ResultDispatchViewControllerBlock blockparameter;

@end
