//
//  YCHAddResultNotiTextFieldTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAddResultNotiTextFieldTableViewCell.h"

@implementation YCHAddResultNotiTextFieldTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpdateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-16);
    }];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"标题";
        _titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _titleLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)contentTF {
    
    if (!_contentTF) {
        _contentTF = [[UITextField alloc] init];
        _contentTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入标题" attributes:@{NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f],NSForegroundColorAttributeName:UMS_GRAY_150}];
        _contentTF.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _contentTF.translatesAutoresizingMaskIntoConstraints = NO;
        _contentTF.textColor = UMS_TEXT_BLACK;
        _contentTF.returnKeyType = UIReturnKeyNext;
        _contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _contentTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _contentTF.autocorrectionType = UITextAutocorrectionTypeNo;
        _contentTF.keyboardType = UIKeyboardTypeDefault;
        _contentTF.tintColor = UMS_THEME_COLOR;
        [self.contentView addSubview:_contentTF];
    }
    return _contentTF;
}

@end
