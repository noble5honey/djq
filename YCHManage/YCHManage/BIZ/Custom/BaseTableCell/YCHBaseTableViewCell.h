//
//  YCHBaseTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/6/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *titleContentLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *displayContentLB;

@property (nonatomic, strong) UIView *bottomLine;

@end
