//
//  YCHOverviewPageModel.h
//  YCHManage
//
//  Created by sunny on 2020/11/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "MTLModel.h"
#import "YCHRecentNotificationModel.h"
#import "YCHEachVillageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCHOverviewPageModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *sevenNotRectifiedNum;  //近七天未整改渔家乐数量

@property (nonatomic, strong) NSString *thirtyNotRectifiedNum; //近30天未整改渔家乐数量

@property (nonatomic, strong) NSString *totalFishNum;   //渔家乐总数

@property (nonatomic, strong) NSString *notRectifiedNum; //全部渔家乐 未整改数量

@property (nonatomic, strong) NSArray *recentThirtyDayCheck; // 近30天检查渔家乐

@property (nonatomic, strong) NSArray *recentSevenDayCheck; //近7天检查渔家乐

@property (nonatomic, strong) NSString *recentSevenDayCheckNum; //近7天检查总数

@property (nonatomic, strong) NSString *recentThirtyDayCheckNum; //近30天检查总数

@property (nonatomic, strong) NSArray <YCHRecentNotificationModel *>*recentNotification; //最近检查通知

@property (nonatomic, strong) NSArray <YCHEachVillageModel *>*villageFishNumList; //各村渔家乐列表

+ (instancetype)overviewPageModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
