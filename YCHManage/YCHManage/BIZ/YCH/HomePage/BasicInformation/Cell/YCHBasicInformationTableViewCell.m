//
//  YCHBasicInformationTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/14.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHBasicInformationTableViewCell.h"

@implementation YCHBasicInformationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints {
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(self).offset(12);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
        make.width.mas_equalTo(150);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.titleLabel);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.right.equalTo(self).offset(-12);
    }];
}

- (void)cellUpadteWithTitle:(NSString *)title value:(NSString *)value {
    if ([value isEqual:@"<null>"]) {
        self.valueLabel.text = @"";
    } else {
        self.valueLabel.text = value;
    }
    self.titleLabel.text = title;
    
}

- (CGFloat)textHeight:(NSString *)str{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //Attribute传和label设定的一样
    NSDictionary * attributes = @{
                                  NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:13.f],
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
    //这里的size，width传label的宽，高默认都传MAXFLOAT
    CGSize textRect = CGSizeMake(Width_Screen - 184, MAXFLOAT);
    CGFloat textHeight = [str boundingRectWithSize: textRect options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        attributes:attributes
        context:nil].size.height;
    return textHeight;
}

- (CGFloat)cellHeight {
    if ([self textHeight:self.valueLabel.text] > 44) {
        return  [self textHeight:self.valueLabel.text] + 10;
    } else {
        return 44;;
    }
   
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = UMS_TEXT_BLACK;
        _titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _valueLabel.textColor = UMS_TEXT_BLACK;
        _valueLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _valueLabel.textAlignment = NSTextAlignmentLeft;
        _valueLabel.numberOfLines = 0;
        [self addSubview:_valueLabel];
    }
    return _valueLabel;
}

@end
