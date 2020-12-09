//
//  YCHAddResultNotiDateTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAddResultNotiDateTableViewCell.h"

@implementation YCHAddResultNotiDateTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpdateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [self.dateRangeStartTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.centerY.equalTo(self);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:110.f]);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
    }];
    
    [self.dateRangeMiddleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeStartTF.mas_right).offset(10.f);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(10);
    }];
    
    [self.dateRangeEndTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeMiddleLine.mas_right).offset(10.f);
        make.top.equalTo(self.dateRangeStartTF);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:110.f]);
        make.height.equalTo(self.dateRangeStartTF);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"日期范围";
        _titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _titleLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)dateRangeStartTF {
    if (!_dateRangeStartTF) {
        _dateRangeStartTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _dateRangeStartTF.placeholder = @"请选择起始日期";
        _dateRangeStartTF.tintColor = UMS_THEME_COLOR;
        _dateRangeStartTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请选择起始日期" attributes:attDic];
            _dateRangeStartTF.attributedPlaceholder = attPlace;
        } else {
            [_dateRangeStartTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        }
        _dateRangeStartTF.textColor = UMS_TEXT_BLACK;
        _dateRangeStartTF.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
        leftView.backgroundColor = [UIColor clearColor];
        _dateRangeStartTF.leftView = leftView;
        _dateRangeStartTF.leftViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:_dateRangeStartTF];
    }
    return _dateRangeStartTF;
}

- (UIView *)dateRangeMiddleLine {
    if (!_dateRangeMiddleLine) {
        _dateRangeMiddleLine = [[UIView alloc] initWithFrame:CGRectZero];
        _dateRangeMiddleLine.backgroundColor = UMS_TEXT_BLACK;
        [self addSubview:_dateRangeMiddleLine];
    }
    return _dateRangeMiddleLine;
}

- (UITextField *)dateRangeEndTF {
    if (!_dateRangeEndTF) {
        _dateRangeEndTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _dateRangeEndTF.placeholder = @"请选择截止日期";
        _dateRangeEndTF.tintColor = UMS_THEME_COLOR;
        _dateRangeEndTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请选择截止日期" attributes:attDic];
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
        [self.contentView addSubview:_dateRangeEndTF];
    }
    return _dateRangeEndTF;
}

@end
