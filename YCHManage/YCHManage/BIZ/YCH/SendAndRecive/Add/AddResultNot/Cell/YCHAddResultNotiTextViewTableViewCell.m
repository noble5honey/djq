//
//  YCHAddResultNotiTextViewTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/24.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAddResultNotiTextViewTableViewCell.h"

@implementation YCHAddResultNotiTextViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpdateConstraints {
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
}

- (CGFloat)cellHeight {
   return  [self textHeight:self.contentTextView.text];
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

- (UITextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
//        _contentTextView.placeholder = @"请输入通告内容";
        _contentTextView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入通告内容" attributes:@{NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f],NSForegroundColorAttributeName:UMS_GRAY_150}];
        _contentTextView.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _contentTextView.placeholderColor = UMS_TEXT_FIELD_PLACEHOLDER_COLOR;
        [_contentTextView setValue:[UIFont UMSChinaLightFontNameOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _contentTextView.tintColor = UMS_THEME_COLOR;
        [self.contentView addSubview:_contentTextView];
    }
    return _contentTextView;
}

@end
