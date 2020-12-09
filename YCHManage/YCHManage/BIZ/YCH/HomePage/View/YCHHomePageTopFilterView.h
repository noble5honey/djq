//
//  YCHHomePageTopFilterView.h
//  YCHManage
//
//  Created by sunny on 2020/6/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJDropdownMenu.h"
//日期范围
@interface YCHHomePageTopFilterView : UIView 

@property (nonatomic, strong) UILabel *dateRangeLabel;

@property (nonatomic, strong) UITextField *startTF;

@property (nonatomic, strong) UILabel *middleLineLabel;

@property (nonatomic, strong) UITextField *endTF;

//分值范围
@property (nonatomic, strong) UILabel *valueRangeLabel;

@property (nonatomic, strong) UITextField *minTF;

@property (nonatomic, strong) UILabel *lineLable;

@property (nonatomic, strong) UITextField *maxTF;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UIButton *resetBtn;

@end
