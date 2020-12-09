//
//  YCHOverviewTableView.h
//  YCHManage
//
//  Created by sunny on 2020/11/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHEachVaillageTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YCHOverviewTableViewDelegate <NSObject>

- (void)requestAllYJL;

- (void)requestAllNoRectificationYJL;

- (void)reusetVillageYJLWithVillageType:(villagesButtonType)villagesBtnType;

- (void)requsetRecentCheckYJLWithCheckType:(recentCheckType)recentCheckType;

@end

@interface YCHOverviewTableView : UITableView

@property (nonatomic, weak) id <YCHOverviewTableViewDelegate>overviewDelegate;

- (void)updateTableViewWithOverviewModel:(YCHOverviewPageModel *)overviewModel;

@end

NS_ASSUME_NONNULL_END
