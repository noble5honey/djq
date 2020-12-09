//
//  YCHHomePageDetailTableView.h
//  YCHManage
//
//  Created by sunny on 2020/6/24.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YCHHomePagDetaileTableViewDelegate <NSObject>

- (void)homePageDetailTableViewDidSelectRowWithDetailDic:(NSDictionary *)detailDic;

@end

@interface YCHHomePageDetailTableView : UITableView

@property (nonatomic, weak) id <YCHHomePagDetaileTableViewDelegate> homepageDetailTVDelegate;

- (void)updateTableViewWithDetailsDic:(NSDictionary *)detailsDic;

- (void)reloadDataWithShowElementList:(NSArray *)showElementList;

@end
