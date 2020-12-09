//
//  YCHReceiveAndDispatchTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/7/20.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHReceiveAndDispatchTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *departmentLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

- (void)updateCellWith:(NSString *)name departmentStr:(NSString *)departmentStr dateStr:(NSString *)dateStr;

@end
