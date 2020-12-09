//
//  YCHScoreQueryTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/6/17.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHScoreQueryTableViewCell.h"

@implementation YCHScoreQueryTableViewCell

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
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.width.mas_equalTo((Width_Screen-10)*0.2);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
    }];
    
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right);
        make.width.mas_equalTo((Width_Screen-10)*0.2);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
    }];
    
    [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemLabel.mas_right);
        make.width.mas_equalTo((Width_Screen-10)*0.4);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reasonLabel.mas_right);
        make.width.mas_equalTo((Width_Screen-10)*0.2);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
    }];
    
}

- (void)updateCellWithDate:(NSString *)date item:(NSString *)item reason:(NSString *)reason value:(NSString *)value {
    self.dateLabel.text = date;
    self.itemLabel.text = item;
    self.reasonLabel.text = reason;
    self.valueLabel.text = value;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel.textColor = UMS_TEXT_BLACK;
        _dateLabel.font = [UIFont ChinaDefaultFontNameOfSize:12.f];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UILabel *)itemLabel {
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _itemLabel.textColor = UMS_TEXT_BLACK;
        _itemLabel.font = [UIFont ChinaDefaultFontNameOfSize:12.f];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_itemLabel];
    }
    return _itemLabel;
}

- (UILabel *)reasonLabel {
    if (!_reasonLabel) {
        _reasonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _reasonLabel.textColor = UMS_TEXT_BLACK;
        _reasonLabel.font = [UIFont ChinaDefaultFontNameOfSize:12.f];
        _reasonLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_reasonLabel];
    }
    return _reasonLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _valueLabel.textColor = UMS_TEXT_BLACK;
        _valueLabel.font = [UIFont ChinaDefaultFontNameOfSize:12.f];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_valueLabel];
    }
    return _valueLabel;
}

@end
