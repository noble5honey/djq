//
//  YCHScoreQueryTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/6/17.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHScoreQueryTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *itemLabel;

@property (nonatomic, strong) UILabel *reasonLabel;

@property (nonatomic, strong) UILabel *valueLabel;

- (void)updateCellWithDate:(NSString *)date item:(NSString *)item reason:(NSString *)reason value:(NSString *)value;

@end
