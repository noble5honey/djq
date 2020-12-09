//
//  YCHHomePageDetailTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/6/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHHomePageDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIButton *detailBtn;

@property (nonatomic, strong) UIView *bottomLine;

- (void)updateCellTitle:(NSString *)title detail:(NSString *)detail;

@end
