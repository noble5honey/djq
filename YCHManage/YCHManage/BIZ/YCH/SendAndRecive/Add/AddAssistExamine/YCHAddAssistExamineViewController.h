//
//  YCHAddAssistExamineViewController.h
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^addAssistExamineViewControllerBlock)(BOOL isUpdateData);

@interface YCHAddAssistExamineViewController : YCHRootViewController

@property (nonatomic, copy) addAssistExamineViewControllerBlock assistEximeViewControllerBlock;

@end

NS_ASSUME_NONNULL_END
