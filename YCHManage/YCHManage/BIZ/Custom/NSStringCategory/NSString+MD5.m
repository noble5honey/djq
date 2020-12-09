//
//  NSString+MD5.m
//  YCHManage
//
//  Created by sunny on 2020/9/27.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

+ (NSString *)md5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    return result;
}

@end
