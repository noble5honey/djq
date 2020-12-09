//
//  YCHEachVaillageTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/11/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHEachVaillageTableViewCell.h"

@implementation YCHEachVaillageTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)updateCellWithHeaderTitle:(NSString *)headerTitle BtnQingshui:(NSString *)qingshui qingshuiTwo:(NSString *)qingshuiTwo xinjing:(NSString *)xinjing xinjingTwo:(NSString *)xinjingTwo yanggou:(NSString *)yanggou yanggouTwo:(NSString *)yanggouTwo lianhua:(NSString *)lianhua lianhuaTwo:(NSString *)lianhuaTwo yuye:(NSString *)yuye yuyeTwo:(NSString *)yuyeTwo tianjing:(NSString *)tianjing tianjingTwo:(NSString *)tianjingTwo {
    self.headerLabel.text = headerTitle;
    
    [self.allQingShuiBtn setTitle:qingshui forState:UIControlStateNormal];
    self.allQingShuiBtn.tag = villagesButtonTypeQingShuiVillage;
    
    [self.qingShuiNOCorrectBtn setTitle:qingshuiTwo forState:UIControlStateNormal];
    self.qingShuiNOCorrectBtn.tag = villagesButtonTypeQingShuiVillageNo;
    
    [self.allXinJingBtn setTitle:xinjing forState:UIControlStateNormal];
    self.allXinJingBtn.tag = villagesButtonTypeXinJingVillage;
    
    [self.xinJingNOCorrectBtn setTitle:xinjingTwo forState:UIControlStateNormal];
    self.xinJingNOCorrectBtn.tag = villagesButtonTypeXinJingVillageNo;
    
    [self.allYangGouBtn setTitle:yanggou forState:UIControlStateNormal];
    self.allYangGouBtn.tag = villagesButtonTypeYangGouVillage;
    
    [self.yangGouNOCorrectBtn setTitle:yanggouTwo forState:UIControlStateNormal];
    self.yangGouNOCorrectBtn.tag = villagesButtonTypeYangGouVillageNO;
    
    [self.lianHuaBtn setTitle:lianhua forState:UIControlStateNormal];
    self.lianHuaBtn.tag = villagesButtonTypeLianHuaVillage;
    
    [self.lianHuaNOCorrectBtn setTitle:lianhuaTwo forState:UIControlStateNormal];
    self.lianHuaNOCorrectBtn.tag = villagesButtonTypeLianhuaVillageNo;
    
    [self.allyuYeBtn setTitle:yuye forState:UIControlStateNormal];
    self.allyuYeBtn.tag = villagesButtonTypeYuYeVillage;
    
    [self.yuYeNOCorrectBtn setTitle:yuyeTwo forState:UIControlStateNormal];
    self.yuYeNOCorrectBtn.tag = villagesButtonTypeYuYeVillageNo;
    
    [self.allJingTianBtn setTitle:tianjing forState:UIControlStateNormal];
    self.allJingTianBtn.tag = villagesButtonTypeTianJinVillage;
    
    [self.jingTianNOCorrectBtn setTitle:tianjingTwo forState:UIControlStateNormal];
    self.jingTianNOCorrectBtn.tag = villagesButtonTypeTianJinVillageNo;
}

- (void)updateCellWithHeaderTitle:(NSString *)headerTitle BtnQingshui:(NSString *)qingshui qingshuiTwo:(NSString *)qingshuiTwo xinjing:(NSString *)xinjing xinjingTwo:(NSString *)xinjingTwo {
    self.headerLabel.text = headerTitle;
    [self.allQingShuiBtn setTitle:qingshui forState:UIControlStateNormal];
    self.allQingShuiBtn.tag = recentCheckTypeSevenDay;
    [self.qingShuiNOCorrectBtn setTitle:qingshuiTwo forState:UIControlStateNormal];
    self.qingShuiNOCorrectBtn.tag = recentCheckTypeSevenDayNo;
    [self.allXinJingBtn setTitle:xinjing forState:UIControlStateNormal];
    self.allXinJingBtn.tag = recentCheckTypeMonth;
    [self.xinJingNOCorrectBtn setTitle:xinjingTwo forState:UIControlStateNormal];
    self.xinJingNOCorrectBtn.tag = recentCheckTypeMonthNo;
    self.allYangGouBtn.hidden = YES;
    self.yangGouNOCorrectBtn.hidden = YES;
    self.lianHuaBtn.hidden = YES;
    self.lianHuaNOCorrectBtn.hidden = YES;
    self.allyuYeBtn.hidden = YES;
    self.yuYeNOCorrectBtn.hidden = YES;
    self.allJingTianBtn.hidden = YES;
    self.jingTianNOCorrectBtn.hidden = YES;
}

- (void)setUpdateConstraints {
    
    [self.contentBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentBackgroundView).offset(8);
        make.right.equalTo(self.contentBackgroundView).offset(-8);
        make.top.equalTo(self.contentBackgroundView).offset(8);
        make.height.mas_equalTo(25);
    }];
    
    [self.allQingShuiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerLabel);
        make.right.equalTo(self.contentBackgroundView).offset(-(Width_Screen/2 - 8));
        make.top.equalTo(self.headerLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
    }];
    
    [self.qingShuiNOCorrectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Width_Screen/2 + 8);
        make.right.equalTo(self).offset(-16);
        make.top.height.equalTo(self.allQingShuiBtn);
    }];
    
    [self.allXinJingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.allQingShuiBtn);
        make.top.equalTo(self.allQingShuiBtn.mas_bottom).offset(5);
    }];
    
    [self.xinJingNOCorrectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.qingShuiNOCorrectBtn);
        make.top.equalTo(self.qingShuiNOCorrectBtn.mas_bottom).offset(5);
    }];
    
    [self.allyuYeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.allQingShuiBtn);
        make.top.equalTo(self.allXinJingBtn.mas_bottom).offset(5);
    }];
    
    [self.yuYeNOCorrectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.qingShuiNOCorrectBtn);
        make.top.equalTo(self.xinJingNOCorrectBtn.mas_bottom).offset(5);
    }];
    
    
    [self.lianHuaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.allQingShuiBtn);
        make.top.equalTo(self.allyuYeBtn.mas_bottom).offset(5);
    }];
    
    [self.lianHuaNOCorrectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.qingShuiNOCorrectBtn);
        make.top.equalTo(self.yuYeNOCorrectBtn.mas_bottom).offset(5);
    }];
    
    [self.allYangGouBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.allQingShuiBtn);
        make.top.equalTo(self.lianHuaBtn.mas_bottom).offset(5);
    }];
    
    [self.yangGouNOCorrectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.qingShuiNOCorrectBtn);
        make.top.equalTo(self.lianHuaNOCorrectBtn.mas_bottom).offset(5);
    }];
    
    
    [self.allJingTianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.allQingShuiBtn);
        make.top.equalTo(self.allYangGouBtn.mas_bottom).offset(5);
    }];
    
    [self.jingTianNOCorrectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.qingShuiNOCorrectBtn);
        make.top.equalTo(self.yangGouNOCorrectBtn.mas_bottom).offset(5);
    }];
}

- (UIView *)contentBackgroundView {
    if (!_contentBackgroundView) {
        _contentBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentBackgroundView.backgroundColor = [UIColor whiteColor];
        _contentBackgroundView.layer.cornerRadius = 10;
        [self.contentView addSubview:_contentBackgroundView];
    }
    return _contentBackgroundView;
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _headerLabel.textAlignment = NSTextAlignmentLeft;
        _headerLabel.font = [UIFont ChinaDefaultFontNameOfSize:15.f];
        _headerLabel.textColor = UMS_TEXT_BLACK;
        [self.contentBackgroundView addSubview:_headerLabel];
    }
    
    return _headerLabel;
}

- (UIButton *)allQingShuiBtn {
    if (!_allQingShuiBtn) {
        _allQingShuiBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_allQingShuiBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _allQingShuiBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _allQingShuiBtn.layer.borderWidth = 0.5;
        _allQingShuiBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _allQingShuiBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_allQingShuiBtn];
    }
    return _allQingShuiBtn;
}

- (UIButton *)qingShuiNOCorrectBtn {
    if (!_qingShuiNOCorrectBtn) {
        _qingShuiNOCorrectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_qingShuiNOCorrectBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _qingShuiNOCorrectBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _qingShuiNOCorrectBtn.layer.borderWidth = 0.5;
        _qingShuiNOCorrectBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _qingShuiNOCorrectBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_qingShuiNOCorrectBtn];
    }
    return _qingShuiNOCorrectBtn;
}

- (UIButton *)allXinJingBtn {
    if (!_allXinJingBtn) {
        _allXinJingBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_allXinJingBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _allXinJingBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _allXinJingBtn.layer.borderWidth = 0.5;
        _allXinJingBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _allXinJingBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_allXinJingBtn];
    }
    return _allXinJingBtn;
}

- (UIButton *)xinJingNOCorrectBtn {
    if (!_xinJingNOCorrectBtn) {
        _xinJingNOCorrectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_xinJingNOCorrectBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _xinJingNOCorrectBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _xinJingNOCorrectBtn.layer.borderWidth = 0.5;
        _xinJingNOCorrectBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _xinJingNOCorrectBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_xinJingNOCorrectBtn];
    }
    return _xinJingNOCorrectBtn;
}

- (UIButton *)allYangGouBtn {
    if (!_allYangGouBtn) {
        _allYangGouBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_allYangGouBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _allYangGouBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _allYangGouBtn.layer.borderWidth = 0.5;
        _allYangGouBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _allYangGouBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_allYangGouBtn];
    }
    return _allYangGouBtn;
}

- (UIButton *)yangGouNOCorrectBtn {
    if (!_yangGouNOCorrectBtn) {
        _yangGouNOCorrectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_yangGouNOCorrectBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _yangGouNOCorrectBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _yangGouNOCorrectBtn.layer.borderWidth = 0.5;
        _yangGouNOCorrectBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _yangGouNOCorrectBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_yangGouNOCorrectBtn];
    }
    return _yangGouNOCorrectBtn;
}

- (UIButton *)lianHuaBtn {
    if (!_lianHuaBtn) {
        _lianHuaBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_lianHuaBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _lianHuaBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _lianHuaBtn.layer.borderWidth = 0.5;
        _lianHuaBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _lianHuaBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_lianHuaBtn];
    }
    return _lianHuaBtn;
}

- (UIButton *)lianHuaNOCorrectBtn {
    if (!_lianHuaNOCorrectBtn) {
        _lianHuaNOCorrectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_lianHuaNOCorrectBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _lianHuaNOCorrectBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _lianHuaNOCorrectBtn.layer.borderWidth = 0.5;
        _lianHuaNOCorrectBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _lianHuaNOCorrectBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_lianHuaNOCorrectBtn];
    }
    return _lianHuaNOCorrectBtn;
}

- (UIButton *)allyuYeBtn {
    if (!_allyuYeBtn) {
        _allyuYeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_allyuYeBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _allyuYeBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _allyuYeBtn.layer.borderWidth = 0.5;
        _allyuYeBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _allyuYeBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_allyuYeBtn];
    }
    return _allyuYeBtn;
}

- (UIButton *)yuYeNOCorrectBtn {
    if (!_yuYeNOCorrectBtn) {
        _yuYeNOCorrectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_yuYeNOCorrectBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _yuYeNOCorrectBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _yuYeNOCorrectBtn.layer.borderWidth = 0.5;
        _yuYeNOCorrectBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _yuYeNOCorrectBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_yuYeNOCorrectBtn];
    }
    return _yuYeNOCorrectBtn;
}

- (UIButton *)allJingTianBtn {
    if (!_allJingTianBtn) {
        _allJingTianBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_allJingTianBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _allJingTianBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _allJingTianBtn.layer.borderWidth = 0.5;
        _allJingTianBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _allJingTianBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_allJingTianBtn];
    }
    return _allJingTianBtn;
}

- (UIButton *)jingTianNOCorrectBtn {
    if (!_jingTianNOCorrectBtn) {
        _jingTianNOCorrectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_jingTianNOCorrectBtn setTitleColor:UMS_TEXT_BLACK forState:UIControlStateNormal];
        _jingTianNOCorrectBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _jingTianNOCorrectBtn.layer.borderWidth = 0.5;
        _jingTianNOCorrectBtn.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _jingTianNOCorrectBtn.layer.cornerRadius = 5;
        [self.contentBackgroundView addSubview:_jingTianNOCorrectBtn];
    }
    return _jingTianNOCorrectBtn;
}

@end
