//
//  YCHHomePageDetailTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/6/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomePageDetailTableViewCell.h"

@implementation YCHHomePageDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
        make.width.mas_equalTo(60.f);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.height.mas_equalTo(0.5f);
        make.bottom.right.equalTo(self);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10.f);
        make.right.equalTo(self).offset(-5.f);
        make.top.bottom.equalTo(self.titleLabel);
    }];
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.detailLabel);
    }];
}

- (void)updateCellTitle:(NSString *)title detail:(NSString *)detail {
    self.titleLabel.text = title;
    self.detailLabel.text = detail;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont UMSDefaultFontOfSize:14];
        _titleLabel.textColor = UMS_GRAY_150;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (! _detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = UMS_TEXT_BLACK;
        _detailLabel.font = [UIFont UMSDefaultFontOfSize:14.f];
        _detailLabel.numberOfLines = 0;
//        _detailLabel.hidden = YES;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UIButton *)detailBtn {
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _detailBtn.backgroundColor = [UIColor clearColor];
        _detailBtn.hidden = YES;
        [self addSubview:_detailBtn];
    }
    return _detailBtn;
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
