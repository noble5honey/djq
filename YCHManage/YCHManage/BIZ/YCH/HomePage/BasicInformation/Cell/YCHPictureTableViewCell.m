//
//  YCHPictureTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/14.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHPictureTableViewCell.h"

@implementation YCHPictureTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints {
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(self).offset(12);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
        make.width.mas_equalTo(70);
    }];
    
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(70);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.firstImageView);
    }];
    
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstImageView.mas_right).offset(20);
        make.top.bottom.width.equalTo(self.firstImageView);
    }];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.secondImageView);
    }];
    
    [self.thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondImageView.mas_right).offset(20);
        make.width.top.bottom.equalTo(self.firstImageView);
    }];
    
    [self.thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.thirdImageView);
    }];
    
}

- (void)updatePictureWithUrlArray:(NSArray *)urlPicArray {
    NSString *str = [NSString stringWithFormat:@"%@",urlPicArray];
    if ([str isEqual:@"<null>"] || urlPicArray == nil) {
        return;
    }
    for (int i = 0; i < urlPicArray.count; i++) {
        NSString *urlPathStr = [NSString stringWithFormat:@"%@%@",YCH_image_url_server,urlPicArray[i]];
        NSURL *url = [NSURL URLWithString:urlPathStr];
        if (i == 0) {
            [self.firstImageView sd_setImageWithURL:url];
            self.firstButton.enabled = YES;
        } else if (i == 1) {
            [self.secondImageView sd_setImageWithURL:url];
            self.secondButton.enabled = YES;
        } else if (i == 2) {
            [self.thirdImageView sd_setImageWithURL:url];
            self.thirdButton.enabled = YES;
        }
    }
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = UMS_TEXT_BLACK;
        _titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"店面照片:";
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)firstImageView {
    
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _firstImageView.image = [UIImage imageNamed:@"logo_login"];
//        _firstImageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_firstImageView];
    }
    return _firstImageView;
}

- (UIButton *)firstButton {
    if (!_firstButton) {
        _firstButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _firstButton.enabled = NO;
        [self.contentView addSubview:_firstButton];
    }
    return _firstButton;
}

- (UIImageView *)secondImageView {
    if (!_secondImageView) {
        _secondImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _secondImageView.image = [UIImage imageNamed:@"logo_login"];
        [self addSubview:_secondImageView];
    }
    return _secondImageView;
}

- (UIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _secondButton.enabled = NO;
        [self.contentView addSubview:_secondButton];
    }
    return _secondButton;
}

- (UIImageView *)thirdImageView {
    if (!_thirdImageView) {
        _thirdImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _thirdImageView.image = [UIImage imageNamed:@"logo_login"];
        [self addSubview:_thirdImageView];
    }
    return _thirdImageView;
}

- (UIButton *)thirdButton {
    if (!_thirdButton) {
        _thirdButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _thirdButton.enabled = NO;
        [self.contentView addSubview:_thirdButton];
    }
    return _thirdButton;
}

@end
