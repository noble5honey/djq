//
//  YCHRequestAssistCheckViewController.h
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef void (^RequestAssistCheckViewControllerBlock)(BOOL isSendSuccess);

@interface YCHRequestAssistCheckViewController : YCHRootViewController

@property (nonatomic, copy) RequestAssistCheckViewControllerBlock blockparameter;

@end
