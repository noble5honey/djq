//
//  YCHEachVillageModel.m
//  YCHManage
//
//  Created by sunny on 2020/11/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHEachVillageModel.h"

@implementation YCHEachVillageModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"fishNum"          :  @"fishNum",
             @"fishArea"         :  @"fishArea",
             @"notRectifiedNum"  :  @"notRectifiedNum",
             @"isAvailable"      :  @"isAvailable"
             };
}

//+ (NSValueTransformer *)fishNumJSONTransformer{
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        return [NSString stringWithFormat:@"%@",value];
//    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        return [NSString stringWithFormat:@"%@",value];
//    }];
//}
//
//+ (NSValueTransformer *)notRectifiedNumJSONTransformer{
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        return [NSString stringWithFormat:@"%@",value];
//    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        return [NSString stringWithFormat:@"%@",value];
//    }];
//}
//+ (NSValueTransformer *)isAvailableJSONTransformer{
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        if ([value isEqual:@"0"]) {
//            return NO;
//        } else {
//            return YES;
//        }
//    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        if ([value isEqual:@"0"]) {
//            return NO;
//        } else {
//            return YES;
//        }
//    }];
//}


+ (instancetype)eachVillageModelWithDict:(NSDictionary *)dict {
    return [MTLJSONAdapter modelOfClass:YCHEachVillageModel.class fromJSONDictionary:dict error:nil];
}

@end
