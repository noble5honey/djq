//
//  YCHOverviewTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/11/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHOverviewTableViewCell.h"

@implementation YCHOverviewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpdateConstraints {
    
    [self.contentBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentBackgroundView).offset(8);
        make.right.equalTo(self.contentBackgroundView).offset(-8);
        make.top.equalTo(self.contentBackgroundView).offset(8);
        make.height.mas_equalTo(25);
    }];
    
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self).offset(-(Width_Screen/2 - 16)/2);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.fisrTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.firstImageView);
        make.centerX.equalTo(self.firstImageView);
        make.top.equalTo(self.firstImageView.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    [self.firstTotalLaebl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.firstImageView);
        make.centerX.equalTo(self.firstImageView);
        make.top.equalTo(self.fisrTitleLabel.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    [self.firstLogoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.firstImageView);
        make.bottom.equalTo(self.firstTotalLaebl.mas_bottom);
    }];
    
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset((Width_Screen/2 - 16)/2);
        make.top.equalTo(self.firstImageView);
        make.width.height.equalTo(self.firstImageView);
    }];
    
    [self.secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.secondImageView);
        make.centerX.equalTo(self.secondImageView);
        make.top.equalTo(self.secondImageView.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    [self.secondTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.secondImageView);
        make.centerX.equalTo(self.secondImageView);
        make.top.equalTo(self.secondTitleLabel.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    [self.secondLogoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.secondImageView);
        make.bottom.equalTo(self.secondTotalLabel.mas_bottom);
    }];
    
}

- (void)updateCellHeaderString:(NSString *)headerStr firstTitle:(NSString *)firstTitle firstTotal:(NSString *)firstTotal secondTitle:(NSString *)secondTitle secondTotal:(NSString *)secondTotal {
    if (headerStr.length > 0) {
        self.headerLabel.text = headerStr;
    }
    if (firstTitle.length > 0) {
        self.fisrTitleLabel.text = firstTitle;
    }
    if (firstTotal.length > 0) {
        self.firstTotalLaebl.text = firstTotal;
    }
    if (secondTitle.length > 0) {
        self.secondTitleLabel.text = secondTitle;
    }
    if (secondTotal.length > 0) {
        self.secondTotalLabel.text = secondTotal;
    }
}

- (UIView *)contentBackgroundView {
    if (!_contentBackgroundView) {
        _contentBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentBackgroundView.backgroundColor = [UIColor whiteColor];
        _contentBackgroundView.layer.cornerRadius = 10;
        [self.contentView addSubview:_contentBackgroundView];
    }
    return _contentBackgroundView;
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _headerLabel.textAlignment = NSTextAlignmentLeft;
        _headerLabel.font = [UIFont ChinaDefaultFontNameOfSize:15.f];
        _headerLabel.textColor = UMS_TEXT_BLACK;
        [self.contentBackgroundView addSubview:_headerLabel];
    }
    
    return _headerLabel;
}

- (UIImageView *)firstImageView {
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home-page-file_image"]];
        [self.contentBackgroundView addSubview:_firstImageView];
    }
    return _firstImageView;
}

- (UIImageView *)secondImageView {
    if (!_secondImageView) {
        _secondImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home-page-file_image"]];
        [self.contentBackgroundView addSubview:_secondImageView];
    }
    return _secondImageView;
}

- (UIButton *)firstLogoButton {
    if (!_firstLogoButton) {
        _firstLogoButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.contentBackgroundView addSubview:_firstLogoButton];
    }
    return _firstLogoButton;
}

- (UIButton *)secondLogoButton {
    if (!_secondLogoButton) {
        _secondLogoButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.contentBackgroundView addSubview:_secondLogoButton];
    }
    return _secondLogoButton;
}

- (UILabel *)fisrTitleLabel {
    if (!_fisrTitleLabel) {
        _fisrTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _fisrTitleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13];
        _fisrTitleLabel.textColor = UMS_TEXT_BLACK;
        _fisrTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentBackgroundView addSubview:_fisrTitleLabel];
    }
    return _fisrTitleLabel;
}

- (UILabel *)firstTotalLaebl {
    if (!_firstTotalLaebl) {
        _firstTotalLaebl = [[UILabel alloc] initWithFrame:CGRectZero];
        _firstTotalLaebl.font = [UIFont UMSChinaLightFontNameOfSize:13];
        _firstTotalLaebl.textColor = UMS_TEXT_BLACK;
        _firstTotalLaebl.textAlignment = NSTextAlignmentCenter;
        [self.contentBackgroundView addSubview:_firstTotalLaebl];
    }
    return _firstTotalLaebl;
}

- (UILabel *)secondTitleLabel {
    if (!_secondTitleLabel) {
        _secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _secondTitleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13];
        _secondTitleLabel.textColor = UMS_TEXT_BLACK;
        _secondTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentBackgroundView addSubview:_secondTitleLabel];
    }
    return _secondTitleLabel;
}

- (UILabel *)secondTotalLabel {
    if (!_secondTotalLabel) {
        _secondTotalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _secondTotalLabel.font = [UIFont UMSChinaLightFontNameOfSize:13];
        _secondTotalLabel.textColor = UMS_TEXT_BLACK;
        _secondTotalLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentBackgroundView addSubview:_secondTotalLabel];
    }
    return _secondTotalLabel;
}

@end
