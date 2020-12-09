//
//  YCHBasicInformationModel.h
//  YCHManage
//
//  Created by sunny on 2020/9/14.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface YCHBasicInformationModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *uniqueCode;  //统一社会信用代码

@property (nonatomic, strong) NSString *name;        //渔家乐名字

@property (nonatomic, strong) NSString *registTime;  //营业执照注册时间

@property (nonatomic, strong) NSString *awardTime;   //营业执照颁发时间

@property (nonatomic, strong) NSString *licenceNum;  //食品卫生许可证编号

@property (nonatomic, strong) NSString *licenceValidity;  //食品卫生许可证有效期

@property (nonatomic, strong) NSString *peopleName;       //联系人

@property (nonatomic, strong) NSString *phoneNum;        //联系电话

@property (nonatomic, strong) NSString *adress;          //联系地址

@property (nonatomic, strong) NSString *starLevel;       //星级

@property (nonatomic, strong) NSString *area;           //所属区域

@property (nonatomic, strong) NSString *hotelPictureUrl;   // 店面照片

@property (nonatomic, strong) NSString *licencePictureUrl;  //营业执照照片

@property (nonatomic, strong) NSString *wsLicencePictureUrl; //卫生许可证照片

+ (instancetype)userInfoModelWithDict:(NSDictionary *)dict;

@end

