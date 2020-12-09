//
//  YCHHomePageEmptyView.m
//  YCHManage
//
//  Created by sunny on 2020/6/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomePageEmptyView.h"

@interface YCHHomePageEmptyView ()

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *describeLabel;

@end

@implementation YCHHomePageEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpConstrains];
    }
    return self;
}

- (void)setUpConstrains {
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset([YCHManageDevice screenAdaptiveSizeWithIp6Size:71.5f]);
    }];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.logoImageView.mas_bottom).offset([YCHManageDevice screenAdaptiveSizeWithIp6Size:40.f]);
    }];
}

-(UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home-page-empty-image"]];
        [self addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (UILabel *)describeLabel {
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _describeLabel.text = @"暂时没有相关记录哦";
        _describeLabel.font = [UIFont UMSDefaultFontOfSize:15.f];
        _describeLabel.textColor = UMS_GRAY_150;
        [self addSubview:_describeLabel];
    }
    return _describeLabel;
}

@end
