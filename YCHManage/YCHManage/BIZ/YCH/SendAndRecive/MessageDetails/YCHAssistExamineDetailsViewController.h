//
//  YCHAssistExamineDetailsViewController.h
//  YCHManage
//
//  Created by sunny on 2020/9/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^assistExamineDetailsViewControllerBlock)(BOOL isUpdateData);

@interface YCHAssistExamineDetailsViewController : YCHRootViewController

@property (nonatomic, copy) assistExamineDetailsViewControllerBlock assistExamineDetailsViewControllerBlock;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic;

@end

NS_ASSUME_NONNULL_END
