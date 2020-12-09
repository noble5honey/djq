//
//  YCHMessageDetailsContentTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHMessageDetailsContentTableViewCell.h"

@implementation YCHMessageDetailsContentTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (CGFloat)cellHeight {
    return [self textHeight:self.contentLabel.text] + 20;
}

- (CGFloat)textHeight:(NSString *)str{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //Attribute传和label设定的一样
    NSDictionary * attributes = @{
                                  NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:15.f],
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
    //这里的size，width传label的宽，高默认都传MAXFLOAT
    CGSize textRect = CGSizeMake(Width_Screen - 32, MAXFLOAT);
    CGFloat textHeight = [str boundingRectWithSize: textRect options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        attributes:attributes
        context:nil].size.height;
    return textHeight;
}

- (void)setUpdateConstraints {
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _contentLabel.textColor = UMS_TEXT_BLACK;
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"各位同事下午好\n    阿斯达困难的拉没收到 阿斯达拿速度慢啦等凉快吗对啦收到了吗是贷款吗马拉松卡都看完新电视是那你看拿年卡SDK那SDK拿手的年卡速度快柠家军你山东济南是年卡多难看是的你看我打卡仕达考试的卡死缴纳看端午节玩家是断手加上了免费送开发吗乱收费吗爱上你看我马拉喀什麻辣大魔王上了免费送开发吗乱收费吗爱上你看我马拉喀什麻辣大魔王上了免费送开发吗乱收费吗爱上你看我马拉喀什麻辣大魔王上了免费送开发吗乱收费吗爱上你看我马拉喀什麻辣大魔王上了免费送开发吗乱收费吗爱上你看我马拉喀什麻辣大魔王上了免费送开发吗乱收费吗爱上你看我马拉喀什麻辣大魔王上了免费送开发吗乱收费吗爱上你看我马拉喀什麻辣大魔王上了免费送开发吗乱收费吗爱上你看我马拉喀什麻辣大魔王111";
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
