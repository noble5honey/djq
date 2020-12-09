//
//  YCHSignUpViewController.m
//  YCHManage
//
//  Created by sunny on 2020/6/11.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHSignUpViewController.h"
#import "YCHSignUpTableView.h"

@interface YCHSignUpViewController ()<YCHSignUpTableViewDelegate>

@property (nonatomic, strong)YCHSignUpTableView * signUpTableView;

@end

@implementation YCHSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationBar];
    [self initSubViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.navigationController.navigationBar updateNaviBarTintColor:[UIColor clearColor] titleColor:nil backgroundColor:[UIColor clearColor] needBottomLine:NO needTranslucent:YES];
}

- (void)updateNavigationBar {
    self.title = @"注册";
    
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)initSubViews {
   
    [self.signUpTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (YCHSignUpTableView *)signUpTableView {
    if (!_signUpTableView) {
        _signUpTableView = [[YCHSignUpTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _signUpTableView.signUpTableViewDelegate = self;
//        [_signUpTableView.gainVerifyView.verifyButton addTarget:self action:@selector(startTimer:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_signUpTableView];
    }
    return _signUpTableView;
}

//- (void)startTimer:(UIButton *)button {
//    [self.signUpTableView.gainVerifyView startTimer];
//
//    // 发送网络请求 - 验证码
//    [self sendVerificationCode];
//}
//
//
//- (void)sendVerificationCode {
//
//}

#pragma mark tableViewDelegate
- (void) registerWithName:(NSString *)name phoneNum:(NSString *)phoneNum password:(NSString *)password passwordTwo:(NSString *)passwordTwo verifyCode:(NSString *)verifyCode authCode:(NSString *)authCode {
    if (name == nil || name.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请输入姓名"];
        return;
    } else if (phoneNum == nil || phoneNum.length < 11) {
        [YCHManagerToast showToastToView:self.view text:@"请输入正确的手机号"];
        return;
    } else if (password == nil || password.length < 8) {
        [YCHManagerToast showToastToView:self.view text:@"请输入合法的密码"];
        return;
    } else if (password != passwordTwo) {
        [YCHManagerToast showToastToView:self.view text:@"密码确认有误"];
        return;
    }
//    else if (verifyCode == nil || verifyCode.length == 0) {
//        [YCHManagerToast showToastToView:self.view text:@"请输入验证码"];
//        return;
//    } else if (authCode == nil || authCode.length == 0) {
//        [YCHManagerToast showToastToView:self.view text:@"请输入授权码"];
//        return;
//    }
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"loginName"] = phoneNum;
    temParamDict[@"password"] = [NSString md5:password];
    temParamDict[@"userName"] = name;
    [YCHManageLodingActivity showLoadingActivityInView:self.view];
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_Login_Register_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
            
        } successBlock:^(id response) {
            [YCHManageLodingActivity hideLoadingActivityInView:self.view];
            [YCHManagerToast showToastToView:self.view text:@"注册成功" time:2 completion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } failBlock:^(NSError *error) {
            
        }];
    
}

- (void) sendVerifyCodeWithPhoneNum:(NSString *)phoneNun {
    if (phoneNun == nil || phoneNun.length < 11) {
        [YCHManagerToast showToastToView:self.view text:@"请输入正确的手机号"];
        return;
    }
    [self.signUpTableView.gainVerifyView startTimer];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
