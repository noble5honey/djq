//
//  YCHOverviewTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/11/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCHOverviewTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *contentBackgroundView;

@property (nonatomic, strong) UILabel *headerLabel;

@property (nonatomic, strong) UIImageView *firstImageView;

@property (nonatomic, strong) UIImageView *secondImageView;

@property (nonatomic, strong) UILabel *fisrTitleLabel;

@property (nonatomic, strong) UILabel *secondTitleLabel;

@property (nonatomic, strong) UILabel *firstTotalLaebl;

@property (nonatomic, strong) UILabel *secondTotalLabel;

@property (nonatomic, strong) UIButton *firstLogoButton;

@property (nonatomic, strong) UIButton *secondLogoButton;

- (void)updateCellHeaderString:(NSString *)headerStr firstTitle:(NSString *)firstTitle firstTotal:(NSString *)firstTotal secondTitle:(NSString *)secondTitle secondTotal:(NSString *)secondTotal;

@end

NS_ASSUME_NONNULL_END
