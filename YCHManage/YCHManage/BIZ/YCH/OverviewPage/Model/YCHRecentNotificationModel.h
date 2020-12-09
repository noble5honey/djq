//
//  YCHRecentNotification.h
//  YCHManage
//
//  Created by sunny on 2020/11/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "MTLModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCHRecentNotificationModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *roleName;  //部门

@property (nonatomic, assign) long createTime;   //创建时间

@property (nonatomic, strong) NSString *matterName; //扣分事项

@property (nonatomic, assign) long matterScore; //扣除分数

@property (nonatomic, strong) NSString *fishName;  //渔家乐名称

+ (instancetype)overviewPageRecentNotiModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
