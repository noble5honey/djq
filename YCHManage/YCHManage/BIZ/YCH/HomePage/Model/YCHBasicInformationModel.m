//
//  YCHBasicInformationModel.m
//  YCHManage
//
//  Created by sunny on 2020/9/14.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHBasicInformationModel.h"

@implementation YCHBasicInformationModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"uniqueCode"  :  @"uniqueCode",
             @"name"        :  @"name",
             @"registTime"  :  @"registTime",
             @"awardTime"   :  @"awardTime",
             @"licenceNum"  :  @"licenceNum",
             @"licenceValidity"  :  @"licenceValidity",
             @"peopleName"  :  @"peopleName",
             @"phoneNum"    :  @"phoneNum",
             @"adress"      :  @"adress",
             @"starLevel"   :  @"starLevel",
             @"area"        :  @"area",
             @"hotelPictureUrl"  :  @"hotelPictureUrl",
             @"licencePictureUrl"  :  @"licencePictureUrl",
             @"wsLicencePictureUrl"  :  @"wsLicencePictureUrl"
             };
}

+ (instancetype)userInfoModelWithDict:(NSDictionary *)dict {
    return [MTLJSONAdapter modelOfClass:YCHBasicInformationModel.class fromJSONDictionary:dict error:nil];
}

@end
