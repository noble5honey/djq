//
//  YCHReceiveAndDispatchTableView.h
//  YCHManage
//
//  Created by sunny on 2020/7/20.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCHReceiveAndDispatchTableViewDelegate <NSObject>

- (void)receiveAndDispatchTableViewDidSelectRowWithDetailDic:(NSDictionary *)detailDic;

- (void)receiveAndDispatchTableViewDidScroll;

@end

@interface YCHReceiveAndDispatchTableView : UITableView

@property (nonatomic, weak) id <YCHReceiveAndDispatchTableViewDelegate> receiveAndDispatchTVDelegate;

- (void)updateTableViewWithItemArray:(NSArray *)itemDic;


@end
