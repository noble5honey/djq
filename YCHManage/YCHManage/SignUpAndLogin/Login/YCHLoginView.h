//
//  YCHLoginView.h
//  YCHManage
//
//  Created by sunny on 2020/6/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSDeformationButton.h"
#import "YCHLoginSegmentedControl.h"
#import "YCHLoginPasswordView.h"

typedef NS_ENUM(NSInteger,SegmentedIndexType){
    SegmentedIndexTypeManager = 0,
    SegmentedIndexTypeVisitor
};

@interface YCHLoginView : UIView

@property (nonatomic,assign)BOOL  currentType;

@property (nonatomic, strong) YCHLoginSegmentedControl * _Nullable segmentedControl;

@property (nonnull, nonatomic, strong) YCHLoginPasswordView *loginPasswordView;

@property (nonatomic, strong) UIButton * _Nullable forgetPassWordButton;

@property (nonatomic, strong) UIButton * _Nullable queryButton;

@property (nonatomic, strong) UIButton * _Nullable registerButton;

@end
