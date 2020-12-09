//
//  YCHBasicInfoScalePictureView.m
//  YCHManage
//
//  Created by sunny on 2020/9/15.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHBasicInfoScalePictureView.h"

@implementation YCHBasicInfoScalePictureView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpConstrains];
    }
    return self;
}



- (void)setUpConstrains {
//    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self);
//        make.height.mas_equalTo(kIs_iPhoneX ? 88 : 64);
//    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(kIs_iPhoneX ? (49.0 + 34.0):(49.0));
    }];
    
    [self.scaleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView);
        make.centerY.equalTo(self.bottomView);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.closeImageView);
    }];
}

- (void)updateViewWihtImage:(UIImage *)image {
    self.scaleImageView.image = image;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectZero];
        _topView.backgroundColor = [UIColor blackColor];
        [self addSubview:_topView];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor blackColor];
        [self addSubview:_bottomView];
    }
    return _bottomView;
}

- (UIImageView *)scaleImageView {
    if (!_scaleImageView) {
        _scaleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_scaleImageView];
    }
    return _scaleImageView;
}

- (UIImageView *)closeImageView {
    if (!_closeImageView) {
        _closeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close_white_color"]];
        [self.bottomView addSubview:_closeImageView];
    }
    return _closeImageView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self addSubview:_closeButton];
    }
    return _closeButton;
}

@end
