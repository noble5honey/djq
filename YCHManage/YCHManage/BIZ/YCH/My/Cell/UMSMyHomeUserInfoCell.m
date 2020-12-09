//
//  UMSMyHomeUserInfoCell.m
//  ChinaUMS
//
//  Created by ums on 16/1/23.
//  Copyright © 2016年 ChinaUMS. All rights reserved.
//

#import "UMSMyHomeUserInfoCell.h"

#define ICON_WIDTH                          60.f
#define ICON_HEIGHT                         60.f
#define ICON_LEFT_MARGIN                    16.f
#define ICON_CORNERRADIUS                    6.f

#define BLACK_FONT_COLOR                                                 \
[UIColor colorWithRed:51 / 255.0 green:51 /255.0 blue:51 / 255.0 alpha:1.0]

#define NAME_LABEL_LEFT_MARGIN              16.f
#define NAME_LABEL_FONT                     [UIFont UMSChinaDefaultFontNameOfSize:14]

#define MYNICKNAME_LABEL_FONT               [UIFont UMSChinaDefaultFontNameOfSize:18.f]

#define ARROW_RIGHT_MARGIN                  16.f

#define My_CELL_HEIGHT                         100.f

#define NICKNAME_BOTTOM_DISTANCE_CENTERY    5.f
#define NICKNAME_LEFT_MARGIN                92.f

@implementation UMSMyHomeUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.badgeCenterOffset = CGPointMake(-40.f, CELL_HEIGHT/2);
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpConstrain];
        
    }
    return self;
}

- (void)setUpConstrain {
    
    [self.myIconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(ICON_LEFT_MARGIN);
        make.width.mas_equalTo(ICON_WIDTH);
        make.height.mas_equalTo(ICON_HEIGHT);
    }];
    
    [self.myNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(-NICKNAME_BOTTOM_DISTANCE_CENTERY);
        make.left.equalTo(self).offset(NICKNAME_LEFT_MARGIN);
    }];
    
    [self.myNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.mas_centerY).offset(NICKNAME_BOTTOM_DISTANCE_CENTERY);
        make.left.equalTo(self).offset(NICKNAME_LEFT_MARGIN);
    }];
    
//    [self.cellArrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.right.equalTo(self).with.offset(-ARROW_RIGHT_MARGIN);
//    }];

}

- (void)updateInfoCellContent {
    
    UIImage *personIconPlaceholderImage = [UIImage imageNamed:@"person-default-icon-image"];
    self.myIconIV.image = personIconPlaceholderImage;
//    [self.myIconIV setImageWithString:UserCenter.userPictUrl placeholderImage:personIconPlaceholderImage imageMaskType:MT_Default completed:nil];
    
//    if (UserCenter.userName.length == 11) {
//        self.myNameLabel.text = [UserCenter.userName stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
//    }else {
//        self.myNameLabel.text = UserCenter.userName;
//    }
//    self.myNickName.text = UserCenter.userNickName;
    self.myNickName.text = UserCenter.userName;
    self.myNameLabel.text = UserCenter.loginName;

}

+ (CGFloat)heightForCell {
    return My_CELL_HEIGHT;
}

- (UIImageView *)myIconIV {
    if (! _myIconIV) {
        _myIconIV = [[UIImageView alloc] init];
        _myIconIV.layer.cornerRadius = ICON_CORNERRADIUS;
        [_myIconIV.layer setMasksToBounds:YES];
        [self addSubview:_myIconIV];
    }
    return _myIconIV;
}

- (UILabel *)myNameLabel {
    if (! _myNameLabel) {
        _myNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _myNameLabel.font = [UIFont ChinaDefaultFontNameOfSize:14];
        _myNameLabel.textColor = UMS_GRAY_150;
        _myNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_myNameLabel];
    }
    return _myNameLabel;
}

- (UIImageView *)cellArrowIV {
    if (!_cellArrowIV) {
        _cellArrowIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowright-small"]];
        [self addSubview:_cellArrowIV];
    }
    return _cellArrowIV;
}

- (UILabel *)myNickName {
    if (!_myNickName) {
        _myNickName = [[UILabel alloc] initWithFrame:CGRectZero];
        _myNickName.font = [UIFont ChinaDefaultFontNameOfSize:18];
        _myNickName.textColor = BLACK_FONT_COLOR;
        [self addSubview:_myNickName];
    }

    return _myNickName;
}

@end
