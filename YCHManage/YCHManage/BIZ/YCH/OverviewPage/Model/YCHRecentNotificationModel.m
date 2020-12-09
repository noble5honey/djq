//
//  YCHRecentNotification.m
//  YCHManage
//
//  Created by sunny on 2020/11/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRecentNotificationModel.h"

@implementation YCHRecentNotificationModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"roleName"    :  @"roleName",
             @"createTime"  :  @"createTime",
             @"matterName"  :  @"matterName",
             @"matterScore" :  @"matterScore",
             @"fishName"    :  @"fishName"
             };
}

+ (instancetype)overviewPageRecentNotiModelWithDict:(NSDictionary *)dict {
    return [MTLJSONAdapter modelOfClass:YCHRecentNotificationModel.class fromJSONDictionary:dict error:nil];
}

@end
