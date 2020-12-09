//
//  YCHLogoutTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/10/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHLogoutTableViewCell.h"

@implementation YCHLogoutTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpConstrain];
        
    }
    return self;
}

- (void)setUpConstrain {
    [self.logoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
}

- (UILabel *)logoutLabel {
    
    if (!_logoutLabel) {
        _logoutLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _logoutLabel.text = @"退出登录";
        _logoutLabel.font = [UIFont ChinaDefaultFontNameOfSize:18.f];
        _logoutLabel.textAlignment = NSTextAlignmentCenter;
        _logoutLabel.textColor = UMS_TEXT_BLACK;
        [self addSubview:_logoutLabel];
    }
    return _logoutLabel;
}

@end
