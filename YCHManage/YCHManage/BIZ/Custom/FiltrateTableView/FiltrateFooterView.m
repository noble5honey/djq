//
//  FiltrateFooterView.m
//  YCHManage
//
//  Created by sunny on 2020/9/18.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "FiltrateFooterView.h"

@interface FiltrateFooterView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation FiltrateFooterView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpContraints];
    }
    return self;
}

- (void)setUpContraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(60);
    }];
    
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(60);
    }];
}

-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _resetButton.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13];
        [_resetButton setBackgroundColor:[UIColor orangeColor]];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_resetButton.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(15, 15)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = _resetButton.bounds;
//        maskLayer.path = maskPath.CGPath;
//        _resetButton.layer.mask = maskLayer;
        [self addSubview:_resetButton];
    }
    return _resetButton;
}

- (UIButton *)ensureButton {
    if (!_ensureButton) {
        _ensureButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _ensureButton.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13];
        [_ensureButton setBackgroundColor:[UIColor redColor]];
        _ensureButton.backgroundColor = [UIColor redColor];
        [_ensureButton setTitle:@"确定" forState:UIControlStateNormal];
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_ensureButton.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 0)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = _ensureButton.bounds;
//        maskLayer.path = maskPath.CGPath;
//        _ensureButton.layer.mask = maskLayer;
        [self addSubview:_ensureButton];
    }
    return _ensureButton;
}

@end
