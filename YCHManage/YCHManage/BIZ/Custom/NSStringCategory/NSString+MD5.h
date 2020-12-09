//
//  NSString+MD5.h
//  YCHManage
//
//  Created by sunny on 2020/9/27.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

+ (NSString *)md5:(NSString *)string;

@end

