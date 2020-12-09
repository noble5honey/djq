//
//  YCHDeductItemTableView.h
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YCHDeductItemTableViewCellDelegate <NSObject>

- (void)deductItemTableViewSelectdeductItemtResultItemStr:(NSString *)resultItemStr;

@end

@interface YCHDeductItemTableView : UITableView

@property (nonatomic, weak) <YCHDeductItemTableViewCellDelegate> deductItemTVDelegate;

- (void)updateTableViewWithItemArray:(NSArray *)itemArray;

@end

NS_ASSUME_NONNULL_END
