//
//  YCHReceiveDepartmentTableView.h
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCHReceiveDepartmentTableViewDelegate <NSObject>

- (void)receiveDepartmentTableViewSelectDepartmentResultItemArray:(NSArray *)resultItemArray;

@end

@interface YCHReceiveDepartmentTableView : UITableView

@property (nonatomic, weak) id<YCHReceiveDepartmentTableViewDelegate> receiveDepartmentTVDelegate;

- (void)updateTableViewWithItemArray:(NSArray *)itemArray selectArray:(NSArray *)selectArray;

@end

