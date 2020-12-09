//
//  YCHCheckRecordDetailsTableView.h
//  YCHManage
//
//  Created by sunny on 2020/9/28.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHExamineTableViewCell.h"

@protocol YCHCheckRecordDetailsTableViewDelegate <NSObject>

- (void)clickHotelPictureShowSacleImage:(UIImage *)image;

- (void)checkRecordDetailClickHotelPictureShowSacleImage:(UIImage *)image;

@end

@interface YCHCheckRecordDetailsTableView : UITableView

@property (nonatomic, weak) id<YCHCheckRecordDetailsTableViewDelegate> checkRecordDetailsTVDelegate;

- (void)updateTableViewWithItemDic:(NSDictionary *)itemDic;

@end

