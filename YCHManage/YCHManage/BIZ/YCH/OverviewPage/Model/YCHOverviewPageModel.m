//
//  YCHOverviewPageModel.m
//  YCHManage
//
//  Created by sunny on 2020/11/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHOverviewPageModel.h"

@implementation YCHOverviewPageModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sevenNotRectifiedNum"  :  @"sevenNotRectifiedNum",
             @"thirtyNotRectifiedNum" :  @"thirtyNotRectifiedNum",
             @"totalFishNum"          :  @"totalFishNum",
             @"notRectifiedNum"       :  @"notRectifiedNum",
             @"recentThirtyDayCheck"  :  @"recentThirtyDayCheck",
             @"recentSevenDayCheck"   :  @"recentSevenDayCheck",
             @"recentNotification"    :  @"recentNotification",
             @"villageFishNumList"    :  @"villageFishNumList",
             @"recentSevenDayCheckNum" : @"recentSevenDayCheckNum",
             @"recentThirtyDayCheckNum" : @"recentThirtyDayCheckNum"
             };
}

+ (NSValueTransformer *)villageFishNumListJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[YCHEachVillageModel class]];
}

+ (NSValueTransformer *)recentNotificationJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[YCHRecentNotificationModel class]];
}

+ (NSValueTransformer *)recentSevenDayCheckNumJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    }];
}

+ (NSValueTransformer *)recentThirtyDayCheckNumJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    }];
}

+ (NSValueTransformer *)sevenNotRectifiedNumJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    }];
}


+ (NSValueTransformer *)thirtyNotRectifiedNumJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    }];
}

+ (NSValueTransformer *)totalFishNumJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    }];
}

+ (NSValueTransformer *)notRectifiedNumJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    }];
}

+ (instancetype)overviewPageModelWithDict:(NSDictionary *)dict {
    return [MTLJSONAdapter modelOfClass:YCHOverviewPageModel.class fromJSONDictionary:dict error:nil];
}

@end
