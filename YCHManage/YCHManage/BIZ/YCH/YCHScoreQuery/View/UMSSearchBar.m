//
//  UMSSearchBar.m
//  ChinaUMS
//
//  Created by macj on 16/1/19.
//  Copyright © 2016年 ChinaUMS. All rights reserved.
//

#import "UMSSearchBar.h"

#define SEARCHBAR_HEIGHT 44.f

@implementation UMSSearchBar

- (instancetype)initWithBackgroundColor:(UIColor *)bgColor {
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = bgColor;
        self.backgroundImage = [self imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, SEARCHBAR_HEIGHT)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        self.backgroundImage = [self imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, SEARCHBAR_HEIGHT)];
    }
    return self;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)modifyStyleByTraversal {
    // 修改搜索框背景图片为自定义的灰色
//    UIColor *backgroundImageColor = UMS_THEME_COLOR;
//    UIImage* clearImg = [self imageWithColor:backgroundImageColor andHeight:45.0];
//    self.backgroundImage = clearImg;
    // 修改搜索框光标颜色
    self.tintColor = UMS_THEME_COLOR;
    // 修改搜索框的搜索图标
    [self setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    for (UIView *view in self.subviews.lastObject.subviews) {
        if([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            UITextField *textField = (UITextField *)view;
            //添加话筒按钮
//            [self addVoiceButton:textField];
            //设置输入框的背景颜色
            textField.clipsToBounds = YES;
            textField.backgroundColor = [UIColor whiteColor];
            
            //设置输入框边框的圆角以及颜色
            textField.layer.cornerRadius = 10.0f;
//            textField.layer.borderColor = [UIColor P2Color].CGColor;
            textField.layer.borderWidth = 1;
            
            //设置输入字体颜色
            textField.textColor = UMS_TEXT_BLACK;
            
            //设置默认文字颜色
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" 搜索" attributes:@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR}];
        }
        
        if ([view isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *cancel = (UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:UMS_THEME_COLOR forState:UIControlStateNormal];
        }
    }
}

// 画指定高度和颜色的图片
- (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height {
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
