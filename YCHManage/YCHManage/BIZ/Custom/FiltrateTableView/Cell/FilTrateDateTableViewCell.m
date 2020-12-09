//
//  FilTrateDateTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/18.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "FilTrateDateTableViewCell.h"

@implementation FilTrateDateTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpdateConstraints {
    
    [self.startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.f);
        make.centerY.equalTo(self);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:100.f]);
        make.height.mas_equalTo(30);
    }];
    
    [self.middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startTF.mas_right).offset(10.f);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(1);
    }];
    
    [self.endTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleLine.mas_right).offset(10.f);
        make.centerY.equalTo(self);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:100.f]);
        make.height.equalTo(self.startTF);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startTF.mas_left);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

- (UITextField *)startTF {
    if (!_startTF) {
        _startTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _startTF.placeholder = @"起始日期";
        _startTF.tintColor = UMS_THEME_COLOR;
        _startTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"起始日期" attributes:attDic];
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

- (UIView *)middleLine {
    if (!_middleLine) {
        _middleLine = [[UIView alloc] initWithFrame:CGRectZero];
        _middleLine.backgroundColor = UMS_TEXT_BLACK;
        [self addSubview:_middleLine];
    }
    return _middleLine;
}

- (UITextField *)endTF {
    if (!_endTF) {
        _endTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _endTF.placeholder = @"截止日期";
        _endTF.tintColor = UMS_THEME_COLOR;
        _endTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"截止日期" attributes:attDic];
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

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end
