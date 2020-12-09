//
//  YCHAssistExamineFiltrateView.h
//  YCHManage
//
//  Created by sunny on 2020/9/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YCHAssistExamineTextFieldTpye) {
    YCHAssistExamineTextFieldTpyeStart = 0,
    YCHAssistExamineTextFieldTpyeEnd
};

@protocol YCHAssistExamineFiltrateViewDelegate <NSObject>

- (void)filtrateViewCommitStartTF:(UITextField *)statTF endTF:(UITextField *)endTF;

@end

@interface YCHAssistExamineFiltrateView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *dateRangeStartTF;

@property (nonatomic, strong) UILabel *dateRangeMiddleLine;

@property (nonatomic, strong) UITextField *dateRangeEndTF;

@property (nonatomic, strong) UIButton *resetBtn;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, assign) YCHAssistExamineTextFieldTpye textFieldType;

@property (nonatomic, weak) id<YCHAssistExamineFiltrateViewDelegate>filtrateViewDelegate;

@end
