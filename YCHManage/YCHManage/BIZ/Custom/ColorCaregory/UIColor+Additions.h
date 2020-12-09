//
//  UIColor+Additions.h
//  ChinaUMS
//
//  Created by ums on 16/1/24.
//  Copyright © 2016年 ChinaUMS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (Additions)

//+ (UIColor *)getBankPrimaryColorWithBankCode:(NSString *)bankCodeStr;
//
//+ (UIColor *)getBankSecondaryColorWithBankCode:(NSString *)bankCodeStr;
//
//+ (UIColor *)getMemberLevelBackGroundColorWithLevelString:(NSString *)levelString;

- (BOOL)iSTheSameColor:(UIColor*)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color;

/*!
 @method
 @abstract   根据会员等级，获取折扣数的颜色
 @result     颜色
 */
+ (UIColor *)discountTextColorFromMemberLevelString:(NSString *)levelString;

@end
