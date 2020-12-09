//
//  UMSDeformationButton.h
//  ChinaUMS
//
//  Created by ums on 16/2/13.
//  Copyright © 2016年 ChinaUMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMSDeformationButton : UIButton

@property(nonatomic, assign) BOOL isLoading;

+ (instancetype)buttonWithType:(UIButtonType)buttonType withColor:(UIColor*)color;

@end
