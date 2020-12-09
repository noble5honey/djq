//
//  YHCKeyValueTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/6/11.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YHCKeyValueTableViewCell.h"

@implementation YHCKeyValueTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpdateConstraints];
            self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints
{
    [self.cardNoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(23);
        make.top.equalTo(self);
        make.width.mas_equalTo(80);
        make.height.equalTo(self).with.offset(-1);
    }];
    [self.cardNoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(120);
        make.top.equalTo(self.cardNoL);
        make.width.equalTo(self).with.offset(-125);
        make.height.equalTo(self);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(23);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)updateCellContentWithCardLTitle:(NSString *)Ltitle andCardTFPlaceHolder:(NSString *)placeHolder andCardTFTitle:(NSString *)tfTitle {
    self.cardNoL.text = Ltitle;
    if (tfTitle.length > 0) {
        self.cardNoTF.text = tfTitle;
    }
    self.cardNoTF.placeholder = placeHolder;
}

-(UILabel *)cardNoL
{
    if(!_cardNoL)
    {
        _cardNoL = [[UILabel alloc]initWithFrame:CGRectZero];;
        _cardNoL.textColor = UIColorFromRGB(0x3c3c3c);
        _cardNoL.backgroundColor = [UIColor whiteColor];
        _cardNoL.font = [UIFont systemFontOfSize:14];
        [self addSubview:_cardNoL];
    }
    return _cardNoL;
}

-(UITextField *)cardNoTF
{
    if(!_cardNoTF)
    {
        _cardNoTF = [[UITextField alloc]initWithFrame:CGRectZero];
        _cardNoTF.font = [UIFont systemFontOfSize:14];
        _cardNoTF.backgroundColor = [UIColor whiteColor];
        _cardNoTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _cardNoTF.keyboardType = UIKeyboardTypeDefault;
        _cardNoTF.textColor = UIColorFromRGB(0x3c3c3c);
        _cardNoTF.tintColor = UMS_THEME_COLOR;

        [self addSubview:_cardNoTF];
        
    }
    return _cardNoTF;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end
