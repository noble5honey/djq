//
//  UIColor+Additions.m
//  ChinaUMS
//
//  Created by ums on 16/1/24.
//  Copyright © 2016年 ChinaUMS. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

//+ (UIColor *)getBankPrimaryColorWithBankCode:(NSString *)bankCodeStr {
//
//    NSDictionary *banksColorDict = [UMSPlistManager gainBanksColorDict];
//
//    if (bankCodeStr.length > 0) {
//        NSString *colorValueStr = banksColorDict[bankCodeStr][@"primary_color"];
//        if (colorValueStr.length == 6) {
//            unsigned red = 0;
//            NSScanner *scanner = [NSScanner scannerWithString:[colorValueStr substringWithRange:NSMakeRange(0,2)]];
//            [scanner scanHexInt:&red];
//            unsigned green = 0;
//            scanner = [NSScanner scannerWithString:[colorValueStr substringWithRange:NSMakeRange(2,2)]];
//            [scanner scanHexInt:&green];
//            unsigned blue = 0;
//            scanner = [NSScanner scannerWithString:[colorValueStr substringWithRange:NSMakeRange(4,2)]];
//            [scanner scanHexInt:&blue];
//            return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
//        }
//
//    }
//    return [UIColor blackColor];
//
//}

//+ (UIColor *)getBankSecondaryColorWithBankCode:(NSString *)bankCodeStr {
//
//    NSDictionary *banksColorDict = [UMSPlistManager gainBanksColorDict];
//
//    if (bankCodeStr.length > 0) {
//        NSString *colorValueStr = banksColorDict[bankCodeStr][@"secondary_color"];
//        if (colorValueStr.length == 6) {
//            unsigned red = 0;
//            NSScanner *scanner = [NSScanner scannerWithString:[colorValueStr substringWithRange:NSMakeRange(0,2)]];
//            [scanner scanHexInt:&red];
//            unsigned green = 0;
//            scanner = [NSScanner scannerWithString:[colorValueStr substringWithRange:NSMakeRange(2,2)]];
//            [scanner scanHexInt:&green];
//            unsigned blue = 0;
//            scanner = [NSScanner scannerWithString:[colorValueStr substringWithRange:NSMakeRange(4,2)]];
//            [scanner scanHexInt:&blue];
//            return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
//        }
//
//    }
//    return [UIColor blackColor];
//
//}

//+ (UIColor *)getMemberLevelBackGroundColorWithLevelString:(NSString *)levelString {
//
//    NSDictionary *memberLevelColorDic = [UMSPlistManager gainMemberLevelColorDict];
//
//    if (levelString.length == 0) {
//        levelString = @"L001";
//    }
//    NSString *colorValueStr = memberLevelColorDic[levelString];
//    if (colorValueStr.length == 6) {
//            unsigned red = 0;
//            NSScanner *scanner = [NSScanner scannerWithString:[colorValueStr substringWithRange:NSMakeRange(0,2)]];
//            [scanner scanHexInt:&red];
//            unsigned green = 0;
//            scanner = [NSScanner scannerWithString:[colorValueStr substringWithRange:NSMakeRange(2,2)]];
//            [scanner scanHexInt:&green];
//            unsigned blue = 0;
//            scanner = [NSScanner scannerWithString:[colorValueStr substringWithRange:NSMakeRange(4,2)]];
//            [scanner scanHexInt:&blue];
//            return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
//    }
//
//    return [UIColor blackColor];
//}

- (BOOL)iSTheSameColor:(UIColor*)color {

    CGFloat oRedValue, oGreenValue, oBlueValue, oAlphaValue;
    CGFloat redValue, greenValue, blueValue, alphaValue;
    
    if ([self getRed:&oRedValue green:&oGreenValue blue:&oBlueValue alpha:&oAlphaValue] &&
        [color getRed:&redValue green:&greenValue blue:&blueValue alpha:&alphaValue]) {
        
        if (oRedValue == redValue &&
            oGreenValue == greenValue &&
            oBlueValue == blueValue) {
            return YES;
        }
        
    }
    return NO;
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)discountTextColorFromMemberLevelString:(NSString *)levelString {
    UIColor *textColor;
    NSInteger switchInteger = [[[levelString componentsSeparatedByString:@"L"] lastObject] integerValue];
    switch (switchInteger) {
        case 1:
            textColor = [UIColor colorWithRed:255 / 255.0 green:140 / 255.0 blue:100 / 255.0 alpha:1];
            break;
        case 2:
            textColor = [UIColor colorWithRed:157 / 255.0 green:186 / 255.0 blue:198 / 255.0 alpha:1];
            break;
        case 3:
            textColor = UMS_YELLOW_COLOR;
            break;
        case 4:
            textColor = [UIColor colorWithRed:84 / 255.0 green:199 / 255.0 blue:234 / 255.0 alpha:1];
            break;
        case 5:
            textColor = [UIColor colorWithRed:199 / 255.0 green:73 / 255.0 blue:226 / 255.0 alpha:1];
            break;
            
        default:
            textColor = UMS_YELLOW_COLOR;
            break;
    }
    return textColor;
}

@end
