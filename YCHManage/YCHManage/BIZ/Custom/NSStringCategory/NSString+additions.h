//
//  NSString+additions.h
//  YCHManage
//
//  Created by sunny on 2020/6/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+MD5.h"

@interface NSString (additions)

//判断字符串中是否含有空格
+ (BOOL)isHaveEmptyString:(NSString *)str;

//时间戳变为格式时间
+ (NSString *)ConvertStrToTime:(NSString *)timeStr;

// 获取当前时间
+ (NSString *)getCurrentDate;

// 获取当前时间戳
+ (NSString *)getCurrentTimestamp;

+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

@end
