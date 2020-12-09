//
//  YCHScrollBannerView.m
//  YCHManage
//
//  Created by sunny on 2020/11/20.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHScrollBannerView.h"

@implementation YCHScrollBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpConstrains];
    }
    return self;
}

- (void)setUpConstrains {
    [self.nameTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    [self.nameDetailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameTitleLable.mas_right);
        make.top.bottom.equalTo(self.nameTitleLable);
        make.right.equalTo(self);
    }];
    
    [self.departmentTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameTitleLable);
        make.top.equalTo(self.nameTitleLable.mas_bottom).offset(5);
    }];
    
    [self.departmentDetailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameDetailsLabel);
        make.top.equalTo(self.nameDetailsLabel.mas_bottom).offset(5);
    }];
    
    [self.timeTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.departmentTitleLable);
        make.top.equalTo(self.departmentTitleLable.mas_bottom).offset(5);
    }];
    
    [self.timeDetailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.departmentDetailsLabel);
        make.top.equalTo(self.departmentDetailsLabel.mas_bottom).offset(5);
    }];
}

- (UILabel *)nameTitleLable {
    if (!_nameTitleLable) {
        _nameTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameTitleLable.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _nameTitleLable.textColor = UMS_TEXT_BLACK;
        _nameTitleLable.text = @"渔家乐名称:";
        [self addSubview:_nameTitleLable];
    }
    return _nameTitleLable;;
}

- (UILabel *)nameDetailsLabel {
    if (!_nameDetailsLabel) {
        _nameDetailsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameDetailsLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _nameDetailsLabel.numberOfLines = 0;
        _nameDetailsLabel.textColor = UMS_TEXT_BLACK;
        [self addSubview:_nameDetailsLabel];
    }
    return _nameDetailsLabel;
}

- (UILabel *)departmentTitleLable {
    if (!_departmentTitleLable) {
        _departmentTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _departmentTitleLable.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _departmentTitleLable.textColor = UMS_TEXT_BLACK;
        _departmentTitleLable.text = @"检查部门:";
        [self addSubview:_departmentTitleLable];
    }
    return _departmentTitleLable;
}

- (UILabel *)departmentDetailsLabel {
    if (!_departmentDetailsLabel) {
        _departmentDetailsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _departmentDetailsLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _departmentDetailsLabel.textColor = UMS_TEXT_BLACK;
        [self addSubview:_departmentDetailsLabel];
    }
    return _departmentDetailsLabel;
}

- (UILabel *)timeTitleLable {
    if (!_timeTitleLable) {
        _timeTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeTitleLable.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _timeTitleLable.textColor = UMS_TEXT_BLACK;
        _timeTitleLable.text = @"检查时间:";
        [self addSubview:_timeTitleLable];
    }
    return _timeTitleLable;
}

- (UILabel *)timeDetailsLabel {
    if (!_timeDetailsLabel) {
        _timeDetailsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeDetailsLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _timeDetailsLabel.textColor = UMS_TEXT_BLACK;
        [self addSubview:_timeDetailsLabel];
    }
    return _timeDetailsLabel;
}

@end
