//
//  YCHReceiveAndDispatchTextFieldCell.m
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHReceiveAndDispatchTextFieldCell.h"

@implementation YCHReceiveAndDispatchTextFieldCell

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
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo(80.f);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.height.equalTo(self);
        make.right.equalTo(self).offset(-16);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont UMSDefaultFontOfSize:14];
        _titleLabel.textColor = UMS_GRAY_150;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"截止日期" attributes:attDic];
            _inputTextField.attributedPlaceholder = attPlace;
        } else {
            [_inputTextField setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        }
//        [_inputTextField setValue:UMS_GRAY_180 forKeyPath:@"_placeholderLabel.textColor"];
//        [_inputTextField setValue:[UIFont ChinaDefaultFontNameOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _inputTextField.font = [UIFont ChinaDefaultFontNameOfSize:14.f];
        _inputTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _inputTextField.textColor = [UIColor colorWithRed:59 / 255.0 green:59 / 255.0 blue:59 / 255.0 alpha:1.0];
        _inputTextField.backgroundColor = [UIColor whiteColor];
        _inputTextField.tintColor = UMS_THEME_COLOR;
        [self.contentView addSubview:_inputTextField];
    }
    return _inputTextField;
}

@end
