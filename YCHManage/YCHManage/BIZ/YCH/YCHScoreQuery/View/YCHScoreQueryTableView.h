//
//  YCHScoreQueryTableView.h
//  YCHManage
//
//  Created by sunny on 2020/6/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHScoreQueryTableView : UITableView

- (void)updateTableViewWithItemArray:(NSArray *)itemArray;

- (void)updateTableViewWithReamianValue:(NSString *)remainValue;

@end
