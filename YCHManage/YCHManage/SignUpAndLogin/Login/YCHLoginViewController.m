//
//  YCHLoginViewController.m
//  YCHManage
//
//  Created by sunny on 2020/6/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHLoginViewController.h"
#import "YCHLoginView.h"
#import "YCHSignUpViewController.h"
#import "YCHScoreQueryViewController.h"

#define LOGIN_VIEW_KEYBOARD_SHOW_OFFSET                              \
[YCHManageDevice screenAdaptiveSizeWithIp6Size:-40.f]
@interface YCHLoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) YCHLoginView *logInView;

@end

@implementation YCHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
//    [self updateNavigationBar];
    
    [self registerNotification];
}

- (void)updateNavigationBar {
//    self.title = @"登录";
    [self.navigationController.navigationBar updateNaviBarTintColor:[UIColor clearColor] titleColor:nil backgroundColor:[UIColor clearColor] needBottomLine:NO needTranslucent:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    if (UserCenter.userName) {
//        self.logInView.loginPasswordView.accountTF.text = UserCenter.userName;
//    } else if ([[NSUserDefaults standardUserDefaults] objectForKey:UMSIDUserName]) {
//        self.logInView.loginPasswordView.accountTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:UMSIDUserName];
//    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    self.logInView.logInButton.isLoading = NO;
}

- (void)initSubViews {
    self.logInView = [[YCHLoginView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:self.logInView];
    
    [self.logInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.logInView.loginPasswordView.accountTF.delegate = self;
    [self.logInView.loginPasswordView.accountTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.logInView.loginPasswordView.passwordTF.delegate = self;
    [self.logInView.loginPasswordView.passwordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.logInView.loginPasswordView.logInButton addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.logInView.forgetPassWordButton addTarget:self action:@selector(forgetPassWordAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.logInView.registerButton addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    
    [self.logInView.queryButton addTarget:self action:@selector(queryDetails) forControlEvents:UIControlEventTouchUpInside];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logIn) name:TRY_TO_LOGIN object:nil];
}

#pragma mark - Keyboard handle
- (void)keyboardDidShow:(NSNotification *)sender {
    NSDictionary *userInfo = sender.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [self.logInView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(LOGIN_VIEW_KEYBOARD_SHOW_OFFSET);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
    [self.logInView setNeedsLayout];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        [self.logInView layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [self.logInView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.logInView setNeedsLayout];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        [self.logInView layoutIfNeeded];
    } completion:nil];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField.tag == LOGIN_ACCOUTTF_TAG) {
        
        if (textField.text.length > 0 && self.logInView.loginPasswordView.passwordTF.text.length > 0 && ![NSString isHaveEmptyString:textField.text]) {
            [self.logInView.loginPasswordView enableLogInButton];
        } else {
            [self.logInView.loginPasswordView disEnableLogInButton];
        }
        
    } else if (textField.tag == LOGIN_PASSWORDTF_TAG) {
        if (textField.text.length > 0 && self.logInView.loginPasswordView.accountTF.text.length > 0 && ![NSString isHaveEmptyString:textField.text]) {
            [self.logInView.loginPasswordView enableLogInButton];
        } else {
            [self.logInView.loginPasswordView disEnableLogInButton];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == LOGIN_ACCOUTTF_TAG) {
        [self.logInView.loginPasswordView.passwordTF becomeFirstResponder];
    } else {
        [self.logInView.loginPasswordView.passwordTF resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - 点击事件

- (void)logIn {
    [self.logInView.loginPasswordView.accountTF resignFirstResponder];
    [self.logInView.loginPasswordView.passwordTF resignFirstResponder];
    
    self.logInView.userInteractionEnabled = NO;
    self.logInView.loginPasswordView.logInButton.isLoading = YES;
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"loginName"] = self.logInView.loginPasswordView.accountTF.text;
    NSString *password = self.logInView.loginPasswordView.passwordTF.text;
    temParamDict[@"loginPassword"] = [NSString md5:password];
//    temParamDict[@"id"] = @"1";
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_login_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
        
    } successBlock:^(id response) {
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0];
        [[NSUserDefaults standardUserDefaults] setObject:response[@"data"][@"token"] forKey:Authorization];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [YCHManageUserCenter sharedInstance].loginName = response[@"data"][@"info"][@"loginName"];
        [YCHManageUserCenter sharedInstance].userName = response[@"data"][@"info"][@"userName"];
        [YCHManageUserCenter sharedInstance].userType = response[@"data"][@"info"][@"userType"];
        UserCenter.userId = [NSString stringWithFormat:@"%@",response[@"data"][@"info"][@"userId"]];
        NSLog(@"用户号：%@",UserCenter.userId);
        NSArray *authArray = response[@"data"][@"roleList"];
        [self judgeAuth:authArray];
    } failBlock:^(NSError *error) {
        self.logInView.userInteractionEnabled = YES;
        self.logInView.loginPasswordView.logInButton.isLoading = NO;
        [YCHManagerToast showToastToView:self.view text:[NSString stringWithFormat:@"%@",error]];
    }];
}

- (void)judgeAuth:(NSArray *)array {
    for (int i = 0; i < array.count; i++) {
        //为2的情况是有权限发布
        NSString  *authId = [NSString stringWithFormat:@"%@",array[i][@"parentRoleId"]];
        if ([authId isEqualToString:@"2"]) {
            UserCenter.isPublishAuth = YES;
        } 
    }
}

- (void)delayMethod {
    [UserCenter setIsLogin:YES];
    self.logInView.userInteractionEnabled = YES;
    self.logInView.loginPasswordView.logInButton.isLoading = NO;
}

- (void)registerAccount {
    YCHSignUpViewController *vc = [[YCHSignUpViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)queryDetails {
    YCHScoreQueryViewController *vc = [[YCHScoreQueryViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
