//
//  UIImage+Additions.h
//  ChinaUMS
//
//  Created by ums on 15/12/22.
//  Copyright © 2015年 ChinaUMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (UIImage *)createImageViewWithColor:(UIColor *)color;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *)maskWithImage:(UIImage *)maskImage;

- (UIImage*)lineCircleMaskWithImage:(UIImage*)maskImage;

/**
 *  生成条形码图片
 *
 *  @param code   需要生产条形码的原始数据
 *  @param width  条形码的宽度
 *  @param height 条形码的高度
 *
 *  @return 生成条形码的图片
 */
+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;


/**
 *  生成二维码图片
 *
 *  @param code   需要生产条形码的原始数据
 *  @param width  条形码的宽度
 *  @param height 条形码的高度
 *
 *  @return 生成二维码的图片
 */
+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

/**
 *  拿到启动页的图片
 *
 *  @return UIImage
 */
+ (UIImage *)getLaunchImage;

/**
 *  获取拉伸后的图片
 *
 *  @return UIImage
 */
- (UIImage *)stretchedImage;

/**
 压缩图片

 @param image 图片
 @param maxFileSize 压缩后的内存大小
 @return data
 */
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

/**
 *  改变图片尺寸
 *
 *  @return UIImage
 */
- (UIImage *)resizeWithSize:(CGSize)size;

@end
