//
//  YCHReceiveDetailsTextViewTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/7/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHReceiveDetailsTextViewTableViewCell.h"

@implementation YCHReceiveDetailsTextViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.top.equalTo(self).offset(3.f);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(75.f);
    }];
    
    [self.recordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.titleLabel.mas_right).offset(5.f);
        make.right.equalTo(self).offset(-16.f);
        make.height.mas_equalTo(self);
    }];
}

- (UITextView *)recordTextView {
    if (!_recordTextView) {
        _recordTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _recordTextView.placeholder = @"请填写相关记录";
        //        [_recordTextView setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        _recordTextView.font = [UIFont ChinaDefaultFontNameOfSize:14.f];
        _recordTextView.placeholderColor = UMS_TEXT_FIELD_PLACEHOLDER_COLOR;
        [_recordTextView setValue:[UIFont ChinaDefaultFontNameOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        [_recordTextView setValue:UMS_GRAY_180 forKeyPath:@"_placeholderLabel.textColor"];
        _recordTextView.tintColor = UMS_THEME_COLOR;
        _recordTextView.textColor = [UIColor colorWithRed:59 / 255.0 green:59 / 255.0 blue:59 / 255.0 alpha:1.0];
        [self addSubview:_recordTextView];
    }
    return _recordTextView;
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


@end
