//
//  UIFont+Additions.m
//  SCamera
//
//  Created by Lifeng Zhang on 2018/2/7.
//  Copyright © 2018年 SCamera.com. All rights reserved.
//

#import "UIFont+Additions.h"

@implementation UIFont (Additions)

+ (UIFont *)ChinaDefaultFontNameOfSize:(CGFloat)fontSize {
    
    return [UIFont fontWithName:ChinaDefaultFontName size:fontSize];
    
}

+ (UIFont *)ChinaBoldFontNameOfSize:(CGFloat)fontSize {
    
    return [UIFont fontWithName:ChinaBoldFontName size:fontSize];
}

+ (UIFont *)ChinaMediumFontNameOfSize:(CGFloat)fontSize {
    
    return [UIFont fontWithName:ChinaMediumFontName size:fontSize];
    
}

+ (UIFont *)UMSChinaLightFontNameOfSize:(CGFloat)fontSize {
    
    if (ISIOS8 && !ISIOS9) {
        return [self ChinaDefaultFontNameOfSize:fontSize];
    }else {
        return [UIFont fontWithName:UMSChinaLightFontName size:fontSize];
    }
    
}

+ (UIFont *)UMSDefaultFontOfSize:(CGFloat)fontSize{
    //return [UIFont fontWithName:UMSDefaultFontName size:fontSize];
    return [UIFont systemFontOfSize:fontSize];
}
+ (UIFont *)UMSBoldDefaultFontOfSize:(CGFloat)fontSize{
    //return [UIFont fontWithName:UMSBoldDefaultFontName size:fontSize];
    return [UIFont boldSystemFontOfSize:fontSize];
}
+ (UIFont *)UMSItalicDefaultFontOfSize:(CGFloat)fontSize{
    //return [UIFont fontWithName:UMSItalicDefaultFontName size:fontSize];
    return [UIFont italicSystemFontOfSize:fontSize];
}

@end
