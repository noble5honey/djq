//
//  NSString+additions.m
//  YCHManage
//
//  Created by sunny on 2020/6/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "NSString+additions.h"

@implementation NSString (additions)

+ (BOOL)isHaveEmptyString:(NSString *)str {
    
    NSRange range = [str rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
}

//时间戳变为格式时间
+ (NSString *)ConvertStrToTime:(NSString *)timeStr {
    timeStr = [NSString stringWithFormat:@"%@",timeStr];
    if ([timeStr isEqual:@"<null>"]) {
        return @"";
    }
    long long time = [timeStr longLongValue];
    NSString *timeToStr = [NSString stringWithFormat:@"%@",timeStr];
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;
    if (timeToStr.length == 13) {
        time = [timeToStr longLongValue] / 1000;
    }
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString*timeString=[formatter stringFromDate:date];
    return timeString;
}

// 获取当前时间
+ (NSString *)getCurrentDate {
    NSDate *currentDate = [NSDate date]; // 获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd"]; // 设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate]; // 将时间转化成字符串
    return dateString;
}

// 获取当前时间戳
+ (NSString *)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format {
    //[NSString timeSwitchTimestamp:self.startDateStr andFormatter:@"YYYY-MM-dd"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //(@"YYYY-MM-dd hh:mm:ss")设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    //将字符串按formatter转成nsdate
    NSDate* date = [formatter dateFromString:formatTime];
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue]*1000;
    NSString *timeStr = [NSString stringWithFormat:@"%ld",(long)timeSp];
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeStr;
}

@end
