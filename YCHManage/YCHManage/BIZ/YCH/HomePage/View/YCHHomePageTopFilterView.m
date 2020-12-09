//
//  YCHHomePageTopFilterView.m
//  YCHManage
//
//  Created by sunny on 2020/6/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomePageTopFilterView.h"

@interface YCHHomePageTopFilterView() <UITextFieldDelegate>

@end

@implementation YCHHomePageTopFilterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpConstrains];
//        self.backgroundColor = UMS_TABLE_BG_COLOR;
//        self.backgroundColor = [UIColor whiteColor];
         self.backgroundColor = [UIColor colorWithRed:238.0 / 255.0 green:242.0 / 255.0 blue:245.0 /255.0 alpha:1.0];

    }
    return self;
}

- (void)setUpConstrains {
    [self.dateRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.top.equalTo(self).offset(5.f);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:60.f]);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
    }];
    
    [self.startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeLabel.mas_right).offset(10.f);
        make.top.equalTo(self.dateRangeLabel);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:100.f]);
        make.height.equalTo(self.dateRangeLabel);
    }];
    
    [self.middleLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startTF.mas_right).offset(10.f);
        make.centerY.equalTo(self.dateRangeLabel);
    }];
    
    [self.endTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleLineLabel.mas_right).offset(10.f);
        make.top.equalTo(self.dateRangeLabel);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:100.f]);
        make.height.equalTo(self.dateRangeLabel);
    }];
    
    [self.valueRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeLabel);
        make.top.equalTo(self.dateRangeLabel.mas_bottom).offset(8.f);
        make.width.height.mas_equalTo(self.dateRangeLabel);
    }];
    
    [self.minTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startTF);
        make.top.equalTo(self.valueRangeLabel);
        make.width.height.mas_equalTo(self.startTF);
    }];
    
    [self.lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleLineLabel);
        make.centerY.equalTo(self.minTF);
    }];
    
    [self.maxTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.endTF);
        make.top.equalTo(self.valueRangeLabel);
        make.width.height.mas_equalTo(self.endTF);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.minTF.mas_right).offset(-20);
//        make.left.equalTo(self.resetBtn.mas_right);
//        make.top.bottom.equalTo(self.resetBtn);
//        make.width.equalTo(self.resetBtn);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
        make.width.mas_equalTo(60);
        make.top.equalTo(self.maxTF.mas_bottom).offset(8.f);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(166);
//        make.top.equalTo(self.maxTF.mas_bottom).offset(8.f);
//        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
//        make.width.mas_equalTo(60);
        make.width.height.mas_equalTo(self.commitBtn);
        make.right.equalTo(self.commitBtn.mas_left);
        make.top.equalTo(self.commitBtn);
    }];
        
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    限制只能输入数字
    if (textField == self.startTF || textField == self.endTF) {
        return NO;
    }
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
                if([textField.text length] == 0){
                    if(single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                //输入的字符是否是小数点
                if (single == '.') {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian = YES;
                        return YES;
                         
                    } else {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                } else {
                    if (isHaveDian) {//存在小数点
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 8) {
                            return YES;
                        } else {
                            return NO;
                        }
                    } else {
                        return YES;
                    }
                }
            } else {//输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else {
            return YES;
        }
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    if (textField == self.minTF) {
        if (textField.text.length == 3) {
            [YCHManagerToast showToastToView:self text:@"请输入0-99整数"];
            textField.text = @"";
        }
    }
    if (textField == self.maxTF) {
        if ([textField.text intValue] > 100) {
            [YCHManagerToast showToastToView:self text:@"请输入0-100整数"];
            textField.text = @"";
        }
    }
}


- (UILabel *)dateRangeLabel {
    if (!_dateRangeLabel) {
        _dateRangeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateRangeLabel.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
        _dateRangeLabel.text = @"时间范围 :";
        _dateRangeLabel.textColor = UMS_TEXT_BLACK;
        [self addSubview:_dateRangeLabel];
    }
    return _dateRangeLabel;
}

- (UITextField *)startTF {
    if (!_startTF) {
        _startTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _startTF.placeholder = @"请选择起始日期";
        _startTF.tintColor = UMS_THEME_COLOR;
        _startTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请选择起始日期" attributes:attDic];
            _startTF.attributedPlaceholder = attPlace;
        } else {
            [_startTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];

        }
        _startTF.textColor = UMS_TEXT_BLACK;
        _startTF.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
        leftView.backgroundColor = [UIColor clearColor];
        _startTF.leftView = leftView;
        _startTF.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:_startTF];
    }
    return _startTF;
}

- (UILabel *)middleLineLabel {
    if (!_middleLineLabel) {
        _middleLineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _middleLineLabel.textColor = UMS_TEXT_BLACK;
        _middleLineLabel.font = [UIFont ChinaDefaultFontNameOfSize:14.f];
        _middleLineLabel.text = @"-";
        [self addSubview:_middleLineLabel];
    }
    return _middleLineLabel;
}

- (UITextField *)endTF {
    if (!_endTF) {
        _endTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _endTF.placeholder = @"请选择截止日期";
        _endTF.tintColor = UMS_THEME_COLOR;
        _endTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请选择截止日期" attributes:attDic];
            _endTF.attributedPlaceholder = attPlace;
        } else {
            [_endTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        }
        _endTF.textColor = UMS_TEXT_BLACK;
        _endTF.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
        leftView.backgroundColor = [UIColor clearColor];
        _endTF.leftView = leftView;
        _endTF.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:_endTF];
    }
    return _endTF;
}

- (UILabel *)valueRangeLabel {
    if (!_valueRangeLabel) {
        _valueRangeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _valueRangeLabel.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
        _valueRangeLabel.text = @"分值范围 :";
        _valueRangeLabel.textColor = UMS_TEXT_BLACK;
        [self addSubview:_valueRangeLabel];
    }
    return _valueRangeLabel;
}

- (UITextField *)minTF {
    if (!_minTF) {
        _minTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _minTF.placeholder = @"请输入分值下限";
        _minTF.tintColor = UMS_THEME_COLOR;
        _minTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请输入分值下限" attributes:attDic];
            _minTF.attributedPlaceholder = attPlace;
        } else {
            [_minTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        }
        _minTF.textColor = UMS_TEXT_BLACK;
        _minTF.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
        leftView.backgroundColor = [UIColor clearColor];
        _minTF.leftView = leftView;
        _minTF.leftViewMode = UITextFieldViewModeAlways;
        _minTF.delegate = self;
        _minTF.keyboardType = UIKeyboardTypePhonePad;
        [self addSubview:_minTF];
    }
    return _minTF;
}

- (UILabel *)lineLable {
    if (!_lineLable) {
        _lineLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _lineLable.textColor = UMS_TEXT_BLACK;
        _lineLable.font = [UIFont ChinaDefaultFontNameOfSize:14.f];
        _lineLable.text = @"-";
        [self addSubview:_lineLable];
    }
    return _lineLable;
}

- (UITextField *)maxTF {
    if (!_maxTF) {
        _maxTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _maxTF.placeholder = @"请输入分值上限";
        _maxTF.tintColor = UMS_THEME_COLOR;
        _maxTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请输入分值上限" attributes:attDic];
            _maxTF.attributedPlaceholder = attPlace;
        } else {
            [_maxTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        }
        _maxTF.textColor = UMS_TEXT_BLACK;
        _maxTF.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
        leftView.backgroundColor = [UIColor clearColor];
        _maxTF.leftView = leftView;
        _maxTF.leftViewMode = UITextFieldViewModeAlways;
        _maxTF.delegate = self;
        _maxTF.keyboardType = UIKeyboardTypePhonePad;
        [self addSubview:_maxTF];
    }
    return _maxTF;
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _commitBtn.layer.borderColor  = [UIColor whiteColor].CGColor;
        _commitBtn.layer.borderWidth  = 1;
        _commitBtn.layer.cornerRadius = 3;
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = [UIFont ChinaDefaultFontNameOfSize:14.f];
        [_commitBtn setTitle:@"完成" forState:UIControlStateNormal];
//        _commitBtn.backgroundColor = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
        _commitBtn.backgroundColor = [UIColor redColor];
        [self addSubview:_commitBtn];
    }
    return _commitBtn;
}

- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _resetBtn.layer.borderColor  = [UIColor whiteColor].CGColor;
        _resetBtn.layer.borderWidth  = 1;
        _resetBtn.layer.cornerRadius = 3;
        [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont ChinaDefaultFontNameOfSize:14.f];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
//        _resetBtn.backgroundColor = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
        _resetBtn.backgroundColor = [UIColor orangeColor];
        [self addSubview:_resetBtn];
    }
    return _resetBtn;
}

@end
