//
//  YCHcheckRecordTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/15.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHcheckRecordTableViewCell.h"

@implementation YCHcheckRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints {
    //height 25    total 190.5
    [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.itemValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemTitleLabel.mas_right).offset(10);
        make.top.bottom.equalTo(self.itemTitleLabel);
        make.right.equalTo(self).offset(-16);
    }];
    //height 25
    [self.scoreTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(self.itemTitleLabel);
        make.top.equalTo(self.itemTitleLabel.mas_bottom).offset(5);
    }];
    
    [self.scoreValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.itemValueLabel);
        make.top.equalTo(self.scoreTitleLabel);
    }];
    //height 25
    [self.dateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.scoreTitleLabel);
        make.top.equalTo(self.scoreTitleLabel.mas_bottom).offset(5);
    }];
    
    [self.dateValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.scoreValueLabel);
        make.top.equalTo(self.dateTitleLabel);
    }];
    //25
    [self.deadlineTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.dateTitleLabel);
        make.top.equalTo(self.dateTitleLabel.mas_bottom).offset(5);
    }];
    
    [self.deadlineValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.scoreValueLabel);
        make.top.equalTo(self.deadlineTitleLabel);
    }];
    
    [self.fixButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        make.top.equalTo(self).offset(30);
    }];
    //height 45
    [self.reasonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.deadlineTitleLabel);
        make.top.equalTo(self.deadlineTitleLabel.mas_bottom).offset(5);
    }];
    
    [self.reasonValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.deadlineValueLabel);
        make.top.equalTo(self.reasonTitleLabel);
        make.right.equalTo(self).offset(-12);
//        make.height.mas_equalTo([self reasonLabelHeight]);
    }];
    //height 70.5
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reasonValueLabel);
        make.top.equalTo(self.reasonValueLabel.mas_bottom).offset(5);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.firstImageView);
    }];
    
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstImageView.mas_right).offset(10);
        make.top.width.height.equalTo(self.firstImageView);
    }];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.secondImageView);
    }];
    
    [self.thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondImageView.mas_right).offset(10);
        make.top.width.height.equalTo(self.secondImageView);
    }];
    
    [self.thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.thirdImageView);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(self).offset(12);
        make.height.mas_equalTo(0.5);
    }];
}

- (CGFloat)reasonLabelHeight {
//    CGFloat height = [self textHeight:self.reasonValueLabel.text];
//    if (height > 40) {
//        return [self textHeight:self.reasonValueLabel.text];
//    } else {
//        return 40;
//    }
    return [self textHeight:self.reasonValueLabel.text];
}

- (CGFloat)cellHeight {
    return (175.5 + [self reasonLabelHeight]);
}

- (CGFloat)textHeight:(NSString *)str{
    NSString *str1 = [NSString stringWithFormat:@"%@",str];
    if ([str1 isEqual:@"<null>"] || str1.length == 0) {
        str1 = @"";
        return 40;
    } else {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        //Attribute传和label设定的一样
        NSDictionary * attributes = @{
                                      NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:13.f],
                                      NSParagraphStyleAttributeName: paragraphStyle
                                      };
        //这里的size，width传label的宽，高默认都传MAXFLOAT
        CGSize textRect = CGSizeMake(Width_Screen - 118, MAXFLOAT);
        CGFloat textHeight = [str boundingRectWithSize: textRect options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
            attributes:attributes
            context:nil].size.height;
        return textHeight;
    }
}


- (void)updateCellContentWithDic:(NSDictionary *)contentDic {
    self.itemValueLabel.text = [NSString stringWithFormat:@"%@",contentDic[@"matterName"]];
    self.scoreValueLabel.text = [NSString stringWithFormat:@"%@",contentDic[@"matterScore"]] ;
    self.dateValueLabel.text = [NSString ConvertStrToTime:contentDic[@"createTime"]];
    NSString *str = [NSString stringWithFormat:@"%@",contentDic[@"checkRemarks"]];
    if ([str isEqual:@"<null>"]) {
        str = @"";
    }
    self.reasonValueLabel.text = str;
    
    NSString *rectificationPeriod = [NSString stringWithFormat:@"%@",contentDic[@"rectificationPeriod"]];
    NSString *rectificationPeriodStr = @"";
    if ([rectificationPeriod isEqual:@"<null>"] || [rectificationPeriod isEqual:@"0"]) {
        rectificationPeriodStr = @"";
    } else {
        rectificationPeriodStr = [NSString stringWithFormat:@"%@天",rectificationPeriod];
    }
    self.deadlineValueLabel.text = rectificationPeriodStr;
}

- (void)updateCellWithPicArray:(NSArray *)picArray {
    if (picArray == nil || [picArray isKindOfClass:[NSNull class]]) {
        return;
    }
    for (int i = 0; i < picArray.count; i++) {
        NSString *urlPathStr = [NSString stringWithFormat:@"%@%@",YCH_image_url_server,picArray[i]];
        NSURL *url = [NSURL URLWithString:urlPathStr];
        if (i == 0) {
            [self.firstImageView sd_setImageWithURL:url];
            self.firstButton.enabled = YES;
//            self.firstButton.layer.borderWidth = 0.5;
        } else if (i == 1) {
            [self.secondImageView sd_setImageWithURL:url];
            self.secondButton.enabled = YES;
//            self.secondButton.layer.borderWidth = 0.5;
        } else if (i == 2) {
            [self.thirdImageView sd_setImageWithURL:url];
            self.thirdButton.enabled = YES;
//            self.thirdButton.layer.borderWidth = 0.5;
        }
    }
}

- (UILabel *)itemTitleLabel {
    if (!_itemTitleLabel) {
        _itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _itemTitleLabel.textColor = UMS_TEXT_BLACK;
        _itemTitleLabel.text = @"扣分项目:";
        _itemTitleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _itemTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_itemTitleLabel];
    }
    return _itemTitleLabel;
}

- (UILabel *)itemValueLabel {
    if (!_itemValueLabel) {
        _itemValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _itemValueLabel.textColor = UMS_TEXT_BLACK;
        _itemValueLabel.text = @"消防安全";
        _itemValueLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _itemValueLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_itemValueLabel];
    }
    return _itemValueLabel;
}

- (UILabel *)scoreTitleLabel {
    if (!_scoreTitleLabel) {
        _scoreTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _scoreTitleLabel.textColor = UMS_TEXT_BLACK;
        _scoreTitleLabel.text = @"扣分分数:";
        _scoreTitleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _scoreTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_scoreTitleLabel];
    }
    return _scoreTitleLabel;
}

- (UILabel *)scoreValueLabel {
    if (!_scoreValueLabel) {
        _scoreValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _scoreValueLabel.textColor = UMS_TEXT_BLACK;
        _scoreValueLabel.text = @"10";
        _scoreValueLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _scoreValueLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_scoreValueLabel];
    }
    return _scoreValueLabel;
}

- (UILabel *)dateTitleLabel {
    if (!_dateTitleLabel) {
        _dateTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateTitleLabel.textColor = UMS_TEXT_BLACK;
        _dateTitleLabel.text = @"检查日期:";
        _dateTitleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _dateTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_dateTitleLabel];
    }
    return _dateTitleLabel;
}

- (UILabel *)dateValueLabel {
    if (!_dateValueLabel) {
        _dateValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateValueLabel.textColor = UMS_TEXT_BLACK;
        _dateValueLabel.text = @"2020-09-15";
        _dateValueLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _dateValueLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_dateValueLabel];
    }
    return _dateValueLabel;
}

- (UILabel *)deadlineTitleLabel {
    if (!_deadlineTitleLabel) {
        _deadlineTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _deadlineTitleLabel.textColor = UMS_TEXT_BLACK;
        _deadlineTitleLabel.text = @"整改期限:";
        _deadlineTitleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _deadlineTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_deadlineTitleLabel];
    }
    return _deadlineTitleLabel;
}

- (UILabel *)deadlineValueLabel {
    if (!_deadlineValueLabel) {
        _deadlineValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _deadlineValueLabel.textColor = UMS_TEXT_BLACK;
        _deadlineValueLabel.text = @"";
        _deadlineValueLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _deadlineValueLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_deadlineValueLabel];
    }
    return _deadlineValueLabel;
}

- (UILabel *)reasonTitleLabel {
    if (!_reasonTitleLabel) {
        _reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _reasonTitleLabel.textColor = UMS_TEXT_BLACK;
        _reasonTitleLabel.text = @"扣分原因:";
        _reasonTitleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _reasonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_reasonTitleLabel];
    }
    return _reasonTitleLabel;
}

- (UILabel *)reasonValueLabel {
    if (!_reasonValueLabel) {
        _reasonValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _reasonValueLabel.textColor = UMS_TEXT_BLACK;
        _reasonValueLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _reasonValueLabel.numberOfLines = 0;
        _reasonValueLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_reasonValueLabel];
    }
    return _reasonValueLabel;
}

- (UIButton *)fixButton {
    if (!_fixButton) {
        _fixButton = [[UIButton alloc] initWithFrame:CGRectZero];
//        [_fixButton setTitle:@"整改详情" forState:UIControlStateNormal];
        _fixButton.backgroundColor = UMS_THEME_COLOR;
        _fixButton.layer.cornerRadius = 4;
        _fixButton.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        [self.contentView addSubview:_fixButton];
    }
    return _fixButton;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIImageView *)firstImageView {
    
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _firstImageView.image = [UIImage imageNamed:@"logo_login"];
        [self.contentView addSubview:_firstImageView];
    }
    return _firstImageView;
}

- (UIButton *)firstButton {
    if (!_firstButton) {
        _firstButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _firstButton.enabled = NO;
        [self.contentView addSubview:_firstButton];
    }
    return _firstButton;
}

- (UIImageView *)secondImageView {
    if (!_secondImageView) {
        _secondImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _secondImageView.image = [UIImage imageNamed:@"logo_login"];
        [self.contentView addSubview:_secondImageView];
    }
    return _secondImageView;
}

- (UIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _secondButton.enabled = NO;
        [self.contentView addSubview:_secondButton];
    }
    return _secondButton;
}

- (UIImageView *)thirdImageView {
    if (!_thirdImageView) {
        _thirdImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _thirdImageView.image = [UIImage imageNamed:@"logo_login"];
        [self.contentView addSubview:_thirdImageView];
    }
    return _thirdImageView;
}

- (UIButton *)thirdButton {
    if (!_thirdButton) {
        _thirdButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _thirdButton.enabled = NO;
        [self.contentView addSubview:_thirdButton];
    }
    return _thirdButton;
}

@end
