//
//  YCHEachVillageModel.h
//  YCHManage
//
//  Created by sunny on 2020/11/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "MTLModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCHEachVillageModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) long fishNum;    //各村渔家乐数量

@property (nonatomic, strong) NSString *fishArea; //村名称
   
@property (nonatomic, assign) long notRectifiedNum; //各村未整改数量

@property (nonatomic, strong) NSString *isAvailable;   //是否有权限点击

+ (instancetype)eachVillageModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
