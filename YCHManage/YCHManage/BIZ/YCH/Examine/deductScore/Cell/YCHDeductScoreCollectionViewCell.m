//
//  YCHDeductScoreCollectionViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/6/30.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHDeductScoreCollectionViewCell.h"

@interface YCHDeductScoreCollectionViewCell ()

@property (nonatomic, strong) UIView *selectedView;

@end

@implementation YCHDeductScoreCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpConstrains];
    }
    return self;
}


- (void)setUpConstrains {
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.height.mas_equalTo(50);
    }];
    
}

- (void)updateCellTitle:(NSString *)title {
    
    self.title.text = title;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.backgroundColor = [UIColor whiteColor];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.layer.cornerRadius = 25.f;
        _title.layer.masksToBounds = 25.f;
        _title.font = [UIFont ChinaMediumFontNameOfSize:24.f];
        [self addSubview:_title];
    }
    return _title;
}

@end
