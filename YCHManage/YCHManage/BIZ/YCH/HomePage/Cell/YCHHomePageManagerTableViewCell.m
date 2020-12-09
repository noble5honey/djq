//
//  YCHHomePageManagerTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/6/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomePageManagerTableViewCell.h"

@implementation YCHHomePageManagerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints {
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.codeTitleLabel.mas_bottom).offset(5.f);
    }];
    
    [self.hotelTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
//        make.width.mas_equalTo((Width_Screen-50-24-10)/2);
        make.width.mas_equalTo(90);
        make.top.equalTo(self).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.hotelvalueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelTitleLabel.mas_right).offset(10);
//        make.width.equalTo(self.hotelTitleLabel);
        make.right.equalTo(self.scoreLabel.mas_left).offset(-5);
        make.top.equalTo(self.hotelTitleLabel);
        make.bottom.equalTo(self.hotelTitleLabel);
    }];
    
    [self.codeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelTitleLabel);
        make.right.equalTo(self.hotelTitleLabel);
        make.top.equalTo(self.hotelTitleLabel.mas_bottom).offset(5);
        make.height.equalTo(self.hotelTitleLabel);
    }];
    
    [self.codeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelvalueLabel);
        make.right.equalTo(self.scoreLabel.mas_left).offset(-5);
        make.top.bottom.equalTo(self.codeTitleLabel);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self).offset(17.f);
    }];
    
    [self.basicInformationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelTitleLabel);
        make.top.equalTo(self.codeTitleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicInformationBtn.mas_right).offset(10);
        make.top.equalTo(self.basicInformationBtn);
        make.width.equalTo(self.basicInformationBtn);
        make.height.mas_equalTo(self.basicInformationBtn);
    }];
    
}

- (void)updateCellWithName:(NSString *)name code:(NSString *)code score:(NSString *)score levelStr:(NSString *)levelStr {
    self.hotelvalueLabel.text = name;
    self.codeValueLabel.text = code;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@ 分",score];
    if (score.integerValue < 90) {
        self.scoreLabel.textColor = [UIColor redColor];
    } else {
        self.scoreLabel.textColor = UMS_TEXT_BLACK;
    }
}

- (void)showBottomButton {
    self.middleLine.hidden = YES;
    self.bottomLine.hidden = NO;
    self.recordBtn.hidden = NO;
    self.basicInformationBtn.hidden = NO;
}

- (void)hiddenBottomButton {
    self.middleLine.hidden = NO;
    self.bottomLine.hidden = YES;
    self.recordBtn.hidden = YES;
    self.basicInformationBtn.hidden = YES;
}

- (void)settingPermission:(NSString *)isPermission {
    if ([isPermission isEqual:@"1"]) {
        self.basicInformationBtn.enabled = YES;
        self.recordBtn.enabled = YES;
        self.basicInformationBtn.layer.backgroundColor = UMS_THEME_COLOR.CGColor;
        self.recordBtn.layer.backgroundColor = UMS_THEME_COLOR.CGColor;
    } else {
        self.basicInformationBtn.enabled = NO;
        self.recordBtn.enabled = NO;
        self.basicInformationBtn.layer.backgroundColor = UMS_GRAY_220.CGColor;
        self.recordBtn.layer.backgroundColor = UMS_GRAY_220.CGColor;
    }
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        _bottomLine.hidden = YES;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIView *)middleLine {
    if (!_middleLine) {
        _middleLine = [[UIView alloc] initWithFrame:CGRectZero];
        _middleLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_middleLine];
    }
    return _middleLine;
}

- (UILabel *)hotelTitleLabel {
    if (!_hotelTitleLabel) {
        _hotelTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hotelTitleLabel.textColor = UMS_TEXT_BLACK;
        _hotelTitleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _hotelTitleLabel.textAlignment = NSTextAlignmentLeft;
        _hotelTitleLabel.text = @"渔家乐名称:";
        [self addSubview:_hotelTitleLabel];
    }
    return _hotelTitleLabel;
}

- (UILabel *)hotelvalueLabel {
    if (!_hotelvalueLabel) {
        _hotelvalueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hotelvalueLabel.textColor = UMS_TEXT_BLACK;
        _hotelvalueLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _hotelvalueLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_hotelvalueLabel];
    }
    return _hotelvalueLabel;
}

- (UILabel *)codeTitleLabel {
    if (!_codeTitleLabel) {
        _codeTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _codeTitleLabel.textColor = UMS_TEXT_BLACK;
        _codeTitleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _codeTitleLabel.textAlignment = NSTextAlignmentLeft;
        _codeTitleLabel.text = @"法人身份证号:";
        [self addSubview:_codeTitleLabel];
    }
    return _codeTitleLabel;
}

- (UILabel *)codeValueLabel {
    if (!_codeValueLabel) {
        _codeValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _codeValueLabel.textColor = UMS_TEXT_BLACK;
        _codeValueLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _codeValueLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_codeValueLabel];
    }
    return _codeValueLabel;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _scoreLabel.textColor = UMS_TEXT_BLACK;
        _scoreLabel.font = [UIFont ChinaDefaultFontNameOfSize:15.f];
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_scoreLabel];
    }
    return _scoreLabel;
}

- (UIButton *)basicInformationBtn {
    if (!_basicInformationBtn) {
        _basicInformationBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _basicInformationBtn.layer.cornerRadius = 3.f;
        _basicInformationBtn.layer.backgroundColor = UMS_THEME_COLOR.CGColor;
        [_basicInformationBtn setTitle:@"基本信息" forState:UIControlStateNormal];
        _basicInformationBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _basicInformationBtn.hidden = YES;
        [self.contentView addSubview:_basicInformationBtn];
    }
    return _basicInformationBtn;
}

- (UIButton *)recordBtn {
    if (!_recordBtn) {
        _recordBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _recordBtn.layer.cornerRadius = 3.f;
        _recordBtn.layer.backgroundColor = UMS_THEME_COLOR.CGColor;
        [_recordBtn setTitle:@"检查记录" forState:UIControlStateNormal];
        _recordBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _recordBtn.hidden = YES;
        [self.contentView addSubview:_recordBtn];
    }
    return _recordBtn;
}

@end
