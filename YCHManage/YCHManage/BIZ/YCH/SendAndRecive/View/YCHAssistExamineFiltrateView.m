//
//  YCHAssistExamineFiltrateView.m
//  YCHManage
//
//  Created by sunny on 2020/9/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAssistExamineFiltrateView.h"
#import "BJDatePickerView.h"

@interface YCHAssistExamineFiltrateView ()

@property (nonatomic, strong) BJDatePicker *datePicker;

@end

@implementation YCHAssistExamineFiltrateView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpConstraints];
    }
    
    return self;
}

- (void)setUpConstraints {
    [self.dateRangeStartTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.top.equalTo(self);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:90.f]);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
    }];
    
    [self.dateRangeMiddleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeStartTF.mas_right).offset(5.f);
        make.centerY.equalTo(self.dateRangeStartTF);
    }];
    
    [self.dateRangeEndTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeMiddleLine.mas_right).offset(5.f);
        make.top.equalTo(self.dateRangeStartTF);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:90.f]);
        make.height.equalTo(self.dateRangeStartTF);
    }];
    
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeEndTF.mas_right).offset(5);
        make.top.equalTo(self.dateRangeEndTF);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
        make.width.mas_equalTo(55);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.resetBtn.mas_right).offset(5);
        make.top.equalTo(self.dateRangeEndTF);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
        make.width.mas_equalTo(55);
    }];
}

- (void)cancelDatePicker {
    if (self.textFieldType == YCHAssistExamineTextFieldTpyeStart) {
        [self.dateRangeStartTF resignFirstResponder];
    } else if (self.textFieldType == YCHAssistExamineTextFieldTpyeEnd) {
        [self.dateRangeEndTF resignFirstResponder];
    }
}

- (void)commit {
    if (self.filtrateViewDelegate && [self.filtrateViewDelegate respondsToSelector:@selector(filtrateViewCommitStartTF:endTF:)]) {
        [self.filtrateViewDelegate filtrateViewCommitStartTF:self.dateRangeStartTF endTF:self.dateRangeEndTF];
    }
    
}

#pragma mark----UITextFieldDelegate----
//无遮盖 输入框进入编辑状态 BJDatePicker替换键盘
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.dateRangeStartTF) {
        self.textFieldType = YCHAssistExamineTextFieldTpyeStart;
        self.dateRangeStartTF.inputView = self.datePicker;
    } else if (textField == self.dateRangeEndTF) {
        self.textFieldType = YCHAssistExamineTextFieldTpyeEnd;
        self.dateRangeEndTF.inputView = self.datePicker;
    }
}

- (UITextField *)dateRangeStartTF {
    if (!_dateRangeStartTF) {
        _dateRangeStartTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _dateRangeStartTF.placeholder = @"起始日期";
        _dateRangeStartTF.tintColor = UMS_THEME_COLOR;
        _dateRangeStartTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"起始日期" attributes:attDic];
            _dateRangeStartTF.attributedPlaceholder = attPlace;
        } else {
            [_dateRangeStartTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        }
        _dateRangeStartTF.textColor = UMS_TEXT_BLACK;
        _dateRangeStartTF.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
        leftView.backgroundColor = [UIColor clearColor];
        _dateRangeStartTF.leftView = leftView;
        _dateRangeStartTF.delegate = self;
        _dateRangeStartTF.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:_dateRangeStartTF];
    }
    return _dateRangeStartTF;
}

- (UILabel *)dateRangeMiddleLine {
    if (!_dateRangeMiddleLine) {
        _dateRangeMiddleLine = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateRangeMiddleLine.textColor = UMS_TEXT_BLACK;
        _dateRangeMiddleLine.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _dateRangeMiddleLine.text = @"-";
        [self addSubview:_dateRangeMiddleLine];
    }
    return _dateRangeMiddleLine;
}

- (UITextField *)dateRangeEndTF {
    if (!_dateRangeEndTF) {
        _dateRangeEndTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _dateRangeEndTF.placeholder = @"截止日期";
        _dateRangeEndTF.tintColor = UMS_THEME_COLOR;
        _dateRangeEndTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"截止日期" attributes:attDic];
            _dateRangeEndTF.attributedPlaceholder = attPlace;
        } else {
            [_dateRangeEndTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        }
        _dateRangeEndTF.textColor = UMS_TEXT_BLACK;
        _dateRangeEndTF.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
        leftView.backgroundColor = [UIColor clearColor];
        _dateRangeEndTF.leftView = leftView;
        _dateRangeEndTF.leftViewMode = UITextFieldViewModeAlways;
        _dateRangeEndTF.delegate = self;
        [self addSubview:_dateRangeEndTF];
    }
    return _dateRangeEndTF;
}

- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _resetBtn.layer.borderColor  = [UIColor whiteColor].CGColor;
        _resetBtn.layer.borderWidth  = 1;
        _resetBtn.layer.cornerRadius = 3;
        [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        _resetBtn.backgroundColor = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
        [self addSubview:_resetBtn];
    }
    return _resetBtn;
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _commitBtn.layer.borderColor  = [UIColor whiteColor].CGColor;
        _commitBtn.layer.borderWidth  = 1;
        _commitBtn.layer.cornerRadius = 3;
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        [_commitBtn setTitle:@"完成" forState:UIControlStateNormal];
        _commitBtn.backgroundColor = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
        [_commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commitBtn];
    }
    return _commitBtn;
}

- (BJDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker=[BJDatePicker shareDatePicker];
        [_datePicker.cancelBtn addTarget:self action:@selector(cancelDatePicker) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        [_datePicker datePickerDidSelected:^(NSString *date) {
            if (weakSelf.textFieldType == YCHAssistExamineTextFieldTpyeStart) {
                weakSelf.dateRangeStartTF.text=date;
                [weakSelf.dateRangeStartTF resignFirstResponder];
                NSLog(@"第二页面开始时间：%@",date);
            } else if (weakSelf.textFieldType == YCHAssistExamineTextFieldTpyeEnd) {
                weakSelf.dateRangeEndTF.text=date;
                [weakSelf.dateRangeEndTF resignFirstResponder];
                NSLog(@"第二页面结束时间：%@",date);
            }
        }];
    }
    return _datePicker;
}

@end
