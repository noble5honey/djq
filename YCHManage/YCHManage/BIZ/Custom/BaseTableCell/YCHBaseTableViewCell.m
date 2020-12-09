//
//  YCHBaseTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/6/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHBaseTableViewCell.h"

@implementation YCHBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [self.titleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(60);
        make.right.equalTo(self.arrowImageView.mas_left).offset(-5);
    }];
    
    [self.displayContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.titleLabel.mas_right);
        make.right.equalTo(self.titleContentLabel.mas_left);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(14.f);
        make.right.equalTo(self).offset(-16.f);
        make.centerY.equalTo(self);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
//    self.titleContentLabel.frame = CGRectMake(self.frame.size.width - 140, 0, 100, self.frame.size.height);
//    self.arrowImageView.frame = CGRectMake(self.frame.size.width - 30, (self.frame.size.height - 9)/2, 14, 14);
//    self.lineView.frame = CGRectMake(16, self.frame.size.height - 0.5, self.frame.size.width - 16, 0.5);
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _titleLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)titleContentLabel {
    if (!_titleContentLabel) {
        _titleContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleContentLabel.textAlignment = NSTextAlignmentRight;
        _titleContentLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _titleContentLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
        [self addSubview:_titleContentLabel];
    }
    return _titleContentLabel;
}

- (UILabel *)displayContentLB {
    if (!_displayContentLB) {
        _displayContentLB = [[UILabel alloc] initWithFrame:CGRectZero];
        _displayContentLB.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _displayContentLB.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
        [self addSubview:_displayContentLB];
    }
    return _displayContentLB;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowright-small"]];
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.hidden = YES;
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end
