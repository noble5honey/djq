//
//  YCHTableViewFooterView.m
//  YCHManage
//
//  Created by sunny on 2020/6/11.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHTableViewFooterView.h"

#define WIDTH_RATIO 1.2f

@implementation YCHTableViewFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        [self setUpConstraints];
    }
    return self;
}

-(void)setUpConstraints {
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self).with.offset(-20);
        make.top.equalTo(self).with.offset(30);
        make.height.mas_equalTo(40);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self.nextBtn.mas_bottom).offset(5);
    }];
}

- (UIButton *)nextBtn {
    if(!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn.layer setCornerRadius:4.0];
        [_nextBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_nextBtn setBackgroundColor:UMS_THEME_COLOR];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 20.0f;
        [self addSubview:_nextBtn];
    }
    return _nextBtn;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipsLabel.font = [UIFont UMSChinaLightFontNameOfSize:12.f];
//        _tipsLabel.textColor = UMS_GRAY_150;
        _tipsLabel.textColor = [UIColor redColor];
        _tipsLabel.numberOfLines = 0;
        [self addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

@end
