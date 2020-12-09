//
//  YCHExamineDeductItemTableView.h
//  YCHManage
//
//  Created by sunny on 2020/9/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHExamineDeductItemTableViewCell.h"

@protocol YCHExamineDeductItemTableViewDelegate <NSObject>

//- (void)examineDeductItemTableViewDidSelectedRowWithIndexPath:(NSIndexPath *)indexPath;

- (void)examineDeductItemTableViewDidSelectedRowWithIndexPath:(NSIndexPath *)indexPath cell:(YCHExamineDeductItemTableViewCell *)cell;

@end

@interface YCHExamineDeductItemTableView : UITableView

@property (nonatomic, weak) id<YCHExamineDeductItemTableViewDelegate> examineDeductItemTVDelagate;

- (void)updateTableViewWithItemArray:(NSArray *)itemArray indexPath:(NSIndexPath *)indexPath;

@end
