//
//  YCHMessageDetailsKeyValueTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHMessageDetailsKeyValueTableViewCell.h"

@implementation YCHMessageDetailsKeyValueTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpdateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.width.mas_equalTo(65.f);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(8);
        make.top.equalTo(self);
        make.right.equalTo(self).offset(-12);
        make.bottom.equalTo(self.titleLabel);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

- (void)updateCellWithDictionary:(NSDictionary *)dictionary {
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont ChinaDefaultFontNameOfSize:14.f];
        _titleLabel.textColor = UMS_TEXT_BLACK;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"收件人的:";
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _contentLabel.textColor = UMS_TEXT_BLACK;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"安达市多啊啊所多阿斯达阿斯达安达市多爱上打阿斯达爱上爱上大叔啊大叔啊大叔";
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
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
