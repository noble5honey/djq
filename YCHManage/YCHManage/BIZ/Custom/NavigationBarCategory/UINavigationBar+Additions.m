//
//  UINavigationBar+Additions.m
//  ChinaUMS
//
//  Created by ums on 15/12/22.
//  Copyright © 2015年 ChinaUMS. All rights reserved.
//

#import "UINavigationBar+Additions.h"

@implementation UINavigationBar (Additions)

- (void)updateNaviBarTintColor:(UIColor *)tintColor
                    titleColor:(UIColor *)titleColor
               backgroundColor:(UIColor *)backgroundColor
                needBottomLine:(BOOL)needBottomLine
               needTranslucent:(BOOL)needTranslucent
{
 
    if (titleColor) {
        NSDictionary * titleAttributesDict= @{NSForegroundColorAttributeName:titleColor};
        self.titleTextAttributes = titleAttributesDict;
    }
    
    CGFloat redValue, greenValue, blueValue, alphaValue;
    
    if ([backgroundColor getRed:&redValue green:&greenValue blue:&blueValue alpha:&alphaValue]) {
        
    }
//    [self setBarTintColor:tintColor];
    self.backgroundColor = [UIColor clearColor];
    if ([backgroundColor iSTheSameColor:[UIColor clearColor]]) {
        [self setBackgroundImage:[UIImage createImageViewWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
        [self setBackIndicatorTransitionMaskImage:[UIImage createImageViewWithColor:[UIColor clearColor]]];
        [self setShadowImage:[UIImage createImageViewWithColor:[UIColor clearColor]]];
    }else if (backgroundColor) {
        [self setBackgroundImage:[UIImage createImageViewWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
    }
    
    if (needBottomLine) {
        self.barStyle = UIBaselineAdjustmentAlignBaselines;
    }else {
        self.barStyle = UIBaselineAdjustmentNone;
    }
    
    if (needTranslucent) {
        self.translucent = YES;
    }else {
        self.translucent = NO;
    }
    
    if ([backgroundColor iSTheSameColor:UMS_NAV_BACKGROUND_COLOR]) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        NSDictionary * titleAttributesDict= @{NSForegroundColorAttributeName:UMS_TEXT_BLACK};
        self.titleTextAttributes = titleAttributesDict;
    } else if ([backgroundColor iSTheSameColor:UMS_NAVI_ORANGE_COLOR]) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        NSDictionary * titleAttributesDict= @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        self.titleTextAttributes = titleAttributesDict;
    }
    
}

- (void)addBlurEffect {
    
    CGRect bounds = self.bounds;
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEffectView.frame = bounds;
    visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:visualEffectView];
    self.backgroundColor = [UIColor clearColor];
    [self sendSubviewToBack:visualEffectView];
    
}

#pragma mark --添加图片加文字的barButtonItem

+ (UIBarButtonItem *)creatImageTitleLeftBarButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title image:(UIImage *)image titleFont:(UIFont *)titleFont titleImageMargin:(CGFloat)margin {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonWidth = [title sizeWithAttributes:@{NSFontAttributeName:titleFont}].width;
    button.frame = CGRectMake(0, 0, buttonWidth+image.size.width+margin, 30);
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -margin, 0, 0)];
    
    button.titleLabel.font = titleFont;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, margin, 0, 0)];
    [button setTitleColor:UMS_THEME_COLOR forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return buttonItem;
}

@end
