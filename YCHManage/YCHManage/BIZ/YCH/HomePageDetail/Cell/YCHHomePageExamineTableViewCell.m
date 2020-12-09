//
//  YCHHomePageExamineTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/6/28.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomePageExamineTableViewCell.h"

@interface  YCHHomePageExamineTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation YCHHomePageExamineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpdateConstraints {
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.height.mas_equalTo(0.5f);
        make.bottom.right.equalTo(self);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-12);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
        make.width.mas_equalTo(100.f);
    }];
}

- (void)updateCellTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _arrowImageView.image = [UIImage imageNamed:@"arrowright-small"];
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}


- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont UMSDefaultFontOfSize:14.f];
        _titleLabel.textColor = UMS_TEXT_BLACK;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
