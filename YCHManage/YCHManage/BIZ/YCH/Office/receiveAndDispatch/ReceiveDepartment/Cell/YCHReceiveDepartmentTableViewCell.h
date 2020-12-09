//
//  YCHReceiveDepartmentTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHReceiveDepartmentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *selectImageView;

@property (nonatomic, strong) UILabel *departmentLabel;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) UIView *bottomLine;

- (void)departmentIsSelect:(BOOL)isSelect;

- (void)updateCellWithContent:(NSString *)itemStr;

@end
