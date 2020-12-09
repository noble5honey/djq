//
//  YCHCorrectAndDetailsViewController.h
//  YCHManage
//
//  Created by sunny on 2020/9/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef void (^YCHCorrectAndDetailsViewControllerBlock)(BOOL isSendSuccess);

typedef NS_ENUM(NSUInteger, YCHCorrectOrDetailsTpye) {
    YCHCheckRecordTypeCorrect = 0,
    YCHCheckRecordTypeDetails
};

@interface YCHCorrectAndDetailsViewController : YCHRootViewController

@property (nonatomic, copy) YCHCorrectAndDetailsViewControllerBlock blockparameter;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic type:(YCHCorrectOrDetailsTpye)type;

@end
