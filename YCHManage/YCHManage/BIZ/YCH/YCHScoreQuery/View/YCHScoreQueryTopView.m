//
//  YCHScoreQueryTopView.m
//  YCHManage
//
//  Created by sunny on 2020/6/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHScoreQueryTopView.h"

#define SEARCHBAR_RIGHT_MARGIN                  52.f

@implementation YCHScoreQueryTopView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpConstrains];
        self.backgroundColor = [UIColor colorWithRed:238.0 / 255.0 green:242.0 / 255.0 blue:245.0 /255.0 alpha:1.0];
    }
    return self;
}

- (void)setUpConstrains {
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
//        make.right.equalTo(self).offset(-SEARCHBAR_RIGHT_MARGIN);
        make.right.equalTo(self).offset(-60.f);
    }];
    
//    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.bottom.equalTo(self);
//        make.left.equalTo(self.searchBar.mas_right);
//    }];
    
    [self.filtrateIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchBar.mas_right).offset(3.f);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(15.f);
    }];
    
    [self.filtrateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.filtrateIV.mas_right).offset(5.f);
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(15.f);
    }];
    
    [self.filtrateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.filtrateIV);
        make.top.bottom.right.equalTo(self);
    }];
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//        [_confirmBtn setTintColor:UMS_THEME_COLOR];
        [_confirmBtn setTitleColor:UMS_THEME_COLOR forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _confirmBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

- (UMSSearchBar *)searchBar {
    if (! _searchBar) {
        _searchBar = [[UMSSearchBar alloc] initWithBackgroundColor:[UIColor clearColor]];
        _searchBar.tintColor = UMS_THEME_COLOR;
        _searchBar.showsCancelButton = NO;
        _searchBar.keyboardType = UIKeyboardTypeDefault;
        _searchBar.translucent  = YES;
        _searchBar.placeholder = @"输入渔家乐名称";
        UITextField *textfield;
        if (@available(iOS 13.0, *)) {
            textfield = _searchBar.searchTextField;
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"输入渔家乐名称" attributes:attDic];
            textfield.attributedPlaceholder = attPlace;
            for(id cc in [_searchBar subviews]) {
               for (id zz in [cc subviews]) {
                   for (id gg in [zz subviews]) {
                       if([gg isKindOfClass:[UIButton class]]){
                          UIButton *cancelButton = (UIButton *)gg;
                           [cancelButton setTitleColor:UMS_THEME_COLOR forState:UIControlStateNormal];
                           [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
                       }
                   }
                }
             }
        } else {
            textfield = [_searchBar valueForKey:@"_searchField"];
            [textfield setValue:[UIFont UMSChinaLightFontNameOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
            [textfield setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
            [_searchBar setValue:@"取消"forKey:@"_cancelButtonText"];
        }
        
        [self addSubview:_searchBar];
    }
    return _searchBar;
}

- (UIImageView *)filtrateIV {
    if (!_filtrateIV) {
        _filtrateIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filtrate_image"]];
        [self addSubview:_filtrateIV];
    }
    return _filtrateIV;
}

- (UILabel *)filtrateLB {
    if (!_filtrateLB) {
        _filtrateLB = [[UILabel alloc] initWithFrame:CGRectZero];
        _filtrateLB.text = @"筛选";
        _filtrateLB.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
        _filtrateLB.textColor = UMS_TEXT_BLACK;
        [self addSubview:_filtrateLB];
    }
    return _filtrateLB;
}

- (UIButton *)filtrateBtn {
    if (!_filtrateBtn) {
        _filtrateBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [self addSubview:_filtrateBtn];
    }
    return _filtrateBtn;
}

@end
