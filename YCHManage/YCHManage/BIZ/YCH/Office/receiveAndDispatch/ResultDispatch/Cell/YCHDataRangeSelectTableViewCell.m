//
//  YCHDataRangeSelectTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHDataRangeSelectTableViewCell.h"

@implementation YCHDataRangeSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints {
    [self.dateRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(self);
    }];
    
    [self.startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeLabel.mas_right).offset(10.f);
        make.centerY.equalTo(self);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:100.f]);
        make.height.mas_equalTo(self.frame.size.height*0.8);
    }];
    
    [self.middleLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startTF.mas_right).offset(10.f);
        make.centerY.equalTo(self.dateRangeLabel);
    }];
    
    [self.endTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleLineLabel.mas_right).offset(10.f);
        make.centerY.equalTo(self);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:100.f]);
        make.height.mas_equalTo(self.frame.size.height*0.8);
    }];
}

- (UILabel *)dateRangeLabel {
    if (!_dateRangeLabel) {
        _dateRangeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateRangeLabel.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
        _dateRangeLabel.text = @"日期范围";
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
        [_startTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
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
        [_endTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
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

@end
