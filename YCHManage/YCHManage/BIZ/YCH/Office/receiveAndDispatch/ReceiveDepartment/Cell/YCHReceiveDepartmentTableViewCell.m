//
//  YCHReceiveDepartmentTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHReceiveDepartmentTableViewCell.h"

@implementation YCHReceiveDepartmentTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpdateConstraints {
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(16.f);
    }];
    
    [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectImageView.mas_right).offset(10.f);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-16.f);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.height.mas_equalTo(5);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.height.mas_equalTo(0.5);
        make.bottom.right.equalTo(self);
    }];
}

- (void)updateCellWithContent:(NSString *)itemStr{
    
    self.departmentLabel.text = itemStr;
}

- (void)departmentIsSelect:(BOOL)isSelect {
    if (isSelect) {
        self.selectImageView.image = [UIImage imageNamed:@"department-isSelect-image"];
    } else {
        self.selectImageView.image = [UIImage imageNamed:@"department-default-image"];
    }
}

- (UILabel *)departmentLabel {
    if (!_departmentLabel) {
        _departmentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _departmentLabel.font = [UIFont UMSDefaultFontOfSize:14];
        _departmentLabel.textColor = UMS_TEXT_BLACK;
        [self addSubview:_departmentLabel];
    }
    return _departmentLabel;
}

- (UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"department-default-image"]];
        [self addSubview:_selectImageView];
    }
    return _selectImageView;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [self addSubview:_selectBtn];
    }
    return _selectBtn;
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
