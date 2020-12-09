//
//  YCHExamineTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/6/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHExamineTableViewCell.h"

@implementation YCHExamineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints {
    [self.recordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10.f);
        make.left.equalTo(self).offset(16.f);
        make.right.equalTo(self).offset(-16.f);
        make.height.mas_equalTo(120);
    }];
    
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16.f);
        make.top.equalTo(self.recordTextView.mas_bottom);
        make.height.mas_equalTo(20.f);
        make.left.equalTo(self).offset(16.f);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.top.equalTo(self.tagLabel.mas_bottom);
        make.width.height.mas_equalTo(80.f);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.addButton);
        make.width.height.mas_equalTo(60.f);
    }];
    
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.addButton);
        make.width.height.mas_equalTo(80.f);
    }];
    
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showImageView.mas_right).offset(10);
        make.top.width.height.equalTo(self.showImageView);
    }];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.secondImageView);
    }];
    
    [self.thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondImageView.mas_right).offset(10);
        make.top.height.width.equalTo(self.secondImageView);
    }];
    
    [self.thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.thirdImageView);
    }];
}

- (CGFloat)cellHeight {
    return 120 + [self textHeight:self.recordTextView.text];
}

- (CGFloat)textHeight:(NSString *)str{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //Attribute传和label设定的一样
    NSDictionary * attributes = @{
                                  NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f],
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
    //这里的size，width传label的宽，高默认都传MAXFLOAT
    CGSize textRect = CGSizeMake(Width_Screen - 32, MAXFLOAT);
    CGFloat textHeight = [str boundingRectWithSize: textRect options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        attributes:attributes
        context:nil].size.height;
    return textHeight;
}

- (void)updateCellShowPictureWithPictureArray:(NSArray *)picArray {
    NSString *str = [NSString stringWithFormat:@"%@",picArray];
    if ([str isEqualToString:@"<null>"]) {
        return;
    }
    for (int i = 0; i < picArray.count; i++) {
        NSString *urlPathStr = [NSString stringWithFormat:@"%@%@",YCH_image_url_server,picArray[i]];
        NSURL *url = [NSURL URLWithString:urlPathStr];
        if (i == 0) {
            [self.showImageView sd_setImageWithURL:url];
//            self.showImageView.layer.borderWidth = 0.5;
            self.addButton.enabled = YES;
        } else if (i == 1) {
            [self.secondImageView sd_setImageWithURL:url];
            self.secondButton.enabled = YES;
//            self.secondImageView.layer.borderWidth = 0.5;
        } else if (i == 2) {
            [self.thirdImageView sd_setImageWithURL:url];
            self.thirdButton.enabled = YES;
//            self.thirdImageView.layer.borderWidth = 0.5;
        }
    }
}

- (void)nativeUpdateCellPictureWithPictureArray:(NSArray<UIImage *> *)picArray {
    for (int i = 0; i < picArray.count; i++) {
        if (i == 0) {
            self.secondImageView.image = picArray[i];
            self.secondButton.enabled = YES;
        } else if (i == 1) {
            self.thirdImageView.image = picArray[i];
            self.thirdButton.enabled = YES;
        } else {
            self.showImageView.image = picArray[i];
        }
    }
}

- (void)updateCellWithCorrectItemDic:(NSDictionary *)correctItemDic {
//    self.recordTextView.userInteractionEnabled = NO;
    self.recordTextView.text = correctItemDic[@"rectificationRemark"];
}

- (UITextView *)recordTextView {
    if (!_recordTextView) {
        _recordTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _recordTextView.placeholder = @"请填写相关记录";
        _recordTextView.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _recordTextView.placeholderColor = UMS_TEXT_FIELD_PLACEHOLDER_COLOR;
        [_recordTextView setValue:[UIFont UMSChinaLightFontNameOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        [self.contentView addSubview:_recordTextView];
    }
    return _recordTextView;
}

- (UILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tagLabel.textColor = UMS_TEXT_FIELD_PLACEHOLDER_COLOR;
        _tagLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _tagLabel.text = @"0/150";
        _tagLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_tagLabel];
    }
    return _tagLabel;
}

- (UIImageView *)addImageView {
    if (!_addImageView) {
        _addImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"examine_add_image"]];
        [self addSubview:_addImageView];
    }
    return _addImageView;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _addButton.backgroundColor = [UIColor clearColor];
        _addButton.layer.borderWidth = 1.f;
        _addButton.layer.borderColor = UMS_GRAY_220.CGColor;
        [self.contentView addSubview:_addButton];
    }
    return _addButton;
}

- (UIImageView *)secondImageView {
    if (!_secondImageView) {
        _secondImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_secondImageView];
    }
    return _secondImageView;
}

- (UIImageView *)thirdImageView {
    if (!_thirdImageView) {
        _thirdImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_thirdImageView];
    }
    return _thirdImageView;
}

- (UIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _secondButton.enabled = NO;
        [self.contentView addSubview:_secondButton];
    }
    return _secondButton;
}

- (UIButton *)thirdButton {
    if (!_thirdButton) {
        _thirdButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _thirdButton.enabled = NO;
        [self.contentView addSubview:_thirdButton];
    }
    return _thirdButton;
}

- (UIImageView *)showImageView {
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_showImageView];
    }
    return _showImageView;
}
@end
