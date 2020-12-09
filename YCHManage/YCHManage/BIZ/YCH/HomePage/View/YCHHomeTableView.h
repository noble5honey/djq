//
//  YCHHomeTableView.h
//  YCHManage
//
//  Created by sunny on 2020/6/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCHHomePageTableViewDelegate <NSObject>

- (void)homePageTableViewDidSelectRowWithDetailDic:(NSDictionary *)detailDic;

- (void)homePageTableViewDidSelectRow;

- (void)homePageTableViewDidScroll;

- (void)homePageTableViewClickBasicInformationButtonWithDetailDic:(NSDictionary *)detailDic;

- (void)homePageTableViewClickRecordButtonWithDetailDic:(NSDictionary *)detailDic;

@end

@interface YCHHomeTableView : UITableView

@property (nonatomic, weak) id <YCHHomePageTableViewDelegate> homepageTVDelegate;

- (void)updateTableViewWithItemArray:(NSArray *)itemArray;

@end
