//
//  YCHReceiveAndDispatchTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/7/20.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHReceiveAndDispatchTableViewCell.h"

@implementation YCHReceiveAndDispatchTableViewCell

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
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.width.mas_equalTo((Width_Screen-20)*0.35);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
    }];
    
    [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.width.mas_equalTo((Width_Screen-20)*0.35);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.departmentLabel.mas_right);
        make.width.mas_equalTo((Width_Screen-20)*0.2);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-8);
    }];
}

- (void)updateCellWith:(NSString *)name departmentStr:(NSString *)departmentStr dateStr:(NSString *)dateStr {
    self.nameLabel.text = name;
    self.departmentLabel.text = departmentStr;
    self.dateLabel.text = dateStr;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = UMS_TEXT_BLACK;
        _nameLabel.font = [UIFont ChinaDefaultFontNameOfSize:12.f];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)departmentLabel {
    if (!_departmentLabel) {
        _departmentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _departmentLabel.textColor = UMS_TEXT_BLACK;
        _departmentLabel.font = [UIFont ChinaDefaultFontNameOfSize:12.f];
        _departmentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_departmentLabel];
    }
    return _departmentLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _arrowImageView.image = [UIImage imageNamed:@"arrowright-small"];
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
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

@end
