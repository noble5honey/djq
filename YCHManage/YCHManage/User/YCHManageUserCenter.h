//
//  YCHManageUserCenter.h
//  YCHManage
//
//  Created by sunny on 2020/6/9.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YCHIDIsLogin                                @"ych_id_islogin"

#define UserCenter                                  [YCHManageUserCenter sharedInstance]

@interface YCHManageUserCenter : NSObject

+ (instancetype)sharedInstance;

- (void)registerToApp;

@property (nonatomic, assign, readonly) BOOL isLogin;

@property (nonatomic, assign, readonly) BOOL isFirstLaunch;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *loginName;

@property (nonatomic, assign) BOOL isPublishAuth;

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *userType;

- (void)setIsLogin:(BOOL)isLogin;

@end
