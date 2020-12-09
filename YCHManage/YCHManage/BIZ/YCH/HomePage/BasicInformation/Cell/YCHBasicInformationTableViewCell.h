//
//  YCHBasicInformationTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/9/14.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHBasicInformationTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *valueLabel;

- (void)cellUpadteWithTitle:(NSString *)title value:(NSString *)value;

- (CGFloat)cellHeight;

@end
