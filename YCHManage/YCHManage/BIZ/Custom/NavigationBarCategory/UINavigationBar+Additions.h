//
//  UINavigationBar+Additions.h
//  ChinaUMS
//
//  Created by ums on 15/12/22.
//  Copyright © 2015年 ChinaUMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Additions)

- (void)updateNaviBarTintColor:(UIColor *)tintColor
                    titleColor:(UIColor *)titleColor
               backgroundColor:(UIColor *)backgroundColor
                needBottomLine:(BOOL)needBottomLine
               needTranslucent:(BOOL)needTranslucent;

- (void)addBlurEffect;

+ (UIBarButtonItem *)creatImageTitleLeftBarButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title image:(UIImage *)image titleFont:(UIFont *)titleFont titleImageMargin:(CGFloat)margin;


@end
