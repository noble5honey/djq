//
//  YCHScrollBannerTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/11/20.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECAutoScrollBanner.h"
#import "YCHRecentNotificationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCHScrollBannerTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *contentBackgroundView;

@property (nonatomic, strong) UILabel *headerLabel;

@property (nonatomic, strong) UIView *cardView;

- (void)updateCellWithRecentNotificationModelArray:(NSArray<YCHRecentNotificationModel*>*)bannerArry;

@end

NS_ASSUME_NONNULL_END
