//
//  YCHHomePageNaviItemTableView.h
//  YCHManage
//
//  Created by sunny on 2020/11/25.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YCHHomePageNaviItemTableViewDelegate <NSObject>

- (void)homePageDidSelectedNaviItemWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface YCHHomePageNaviItemTableView : UITableView

@property (nonatomic, weak) id<YCHHomePageNaviItemTableViewDelegate>naviItemTVDelegate;

- (void)updateTableViewWithItemArray:(NSArray *)itemArray;

@end

NS_ASSUME_NONNULL_END
