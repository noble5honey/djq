//
//  YCHSendAndReciveTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/9/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHSendAndReciveTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *departmentLabel;

@property (nonatomic, strong) UILabel *themeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UILabel *readLabel;

- (void)updateCellContentWithDictionary:(NSDictionary *)dictionary;

- (void)updateNotiCellContentDictionary:(NSDictionary *)dictionary;

@end
