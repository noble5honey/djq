//
//  YCHCheckRecordViewController.h
//  YCHManage
//
//  Created by sunny on 2020/9/15.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRootViewController.h"

typedef NS_ENUM(NSUInteger, YCHCheckRecordTextFieldTpye) {
    YCHCheckRecordTextFieldTpyeStart = 0,
    YCHCheckRecordTextFieldTpyeEnd
};

typedef void (^checkRecordViewControllerBlock)(BOOL isUpdateData);

@interface YCHCheckRecordViewController : YCHRootViewController

@property (nonatomic, copy) checkRecordViewControllerBlock checkRecordBlock;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic;

@end
