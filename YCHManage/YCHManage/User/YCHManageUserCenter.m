//
//  YCHManageUserCenter.m
//  YCHManage
//
//  Created by sunny on 2020/6/9.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHManageUserCenter.h"

#define UserType       @"UserType"

@implementation YCHManageUserCenter

static YCHManageUserCenter *sharedInstance = nil;


+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[YCHManageUserCenter alloc] init];
        
    });
    return sharedInstance;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    _isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:YCHIDIsLogin];
    
    if (self.isLogin) {
        // 这里自动登录 直接使用内存中保存的用户名 头像 性别  等等
    }
}

- (void)setLoginName:(NSString *)loginName {
    [[NSUserDefaults standardUserDefaults] setObject:loginName forKey:LoginName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)loginName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:LoginName];
}

- (NSString *)userName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:UserName];
}

- (void)setUserName:(NSString *)userName {
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:UserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsPublishAuth:(BOOL)isPublishAuth {
    [[NSUserDefaults standardUserDefaults] setBool:isPublishAuth forKey:Permission];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"写入授权码%@",isPublishAuth ? @"1" : @"0");
}

- (void)setUserType:(NSString *)userType {
    [[NSUserDefaults standardUserDefaults] setObject:userType forKey:UserType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userType {
    return [[NSUserDefaults standardUserDefaults] objectForKey:UserType];
}

- (BOOL)isPublishAuth {
    return [[NSUserDefaults standardUserDefaults] boolForKey:Permission];
}

- (NSString *)userId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
}

- (void)setUserId:(NSString *)userId {
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:UserId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)registerToApp {
    
    if (!self.isLogin)
    {
        //登录操作
        [ViewControllerManager showLoginView];
        
    } else {
        
//        [ViewControllerManager showLaunchView];
//        [ViewControllerManager showHomePage];
        [ViewControllerManager showTabController];
    }
}

- (BOOL)isFirstLaunch
{
    NSString *version = [[NSUserDefaults standardUserDefaults] stringForKey:@"firstLaunch"];
    
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if ((((version) == nil) || ([(version) isEqual:[NSNull null]]) ||([(version)isEqualToString:@""]) || ![version isEqualToString:currentVersion])) {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        return YES;
    }
    
    return NO;
}


#pragma mark -

-(void)setIsLogin:(BOOL)isLogin {
    
    _isLogin = isLogin;
    
    if (!isLogin) {
        [self clearUserInfo];
        [[ZBNetworking shaerdInstance] clearTotalCache];
        [[ZBNetworking shaerdInstance] clearDownloadData];
        [ViewControllerManager showLoginView];
    }
    else {
//        [self activateUserAutoLogin];
        [self saveUserInfo];
//        [[RemoteNotiClass shared] registerForUsrsysid];
        [ViewControllerManager showTabController];
    }
    
}

- (void)saveUserInfo {
    
    if (self.isLogin) {
        [[NSUserDefaults standardUserDefaults] setBool:self.isLogin forKey:YCHIDIsLogin];
    }
}

- (void)clearUserInfo {
    //清除内存中保存的用户数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:YCHIDIsLogin];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Authorization];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LoginName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Permission];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserId];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:Authorization];
    NSLog(@"Authorization：%@",str);
}


@end
