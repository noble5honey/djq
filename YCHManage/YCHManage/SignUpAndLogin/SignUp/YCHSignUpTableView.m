//
//  YCHSignUpTableView.m
//  YCHManage
//
//  Created by sunny on 2020/6/11.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHSignUpTableView.h"
#import "YCHTableViewFooterView.h"

#define BIND_PARK_CARD_CELL_HEIGHT 44.0f
#define BIND_PARK_CARD_FOOTER_HEIGHT 90.0f
#define BIND_PARK_CARD_HEADER_HEIGHT 10.0f
#define BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT 112.0f;

static NSString * SignUpCellID = @"singup_cell_id";
static NSString * SignUpFooterViewID = @"signup_footerView_cell_id";

@interface YCHSignUpTableView() <UITableViewDelegate,UITableViewDataSource>

@end

@implementation YCHSignUpTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if(self = [super initWithFrame:frame style:style])
    {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sectionFooterHeight = 0;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YHCKeyValueTableViewCell class] forCellReuseIdentifier:SignUpCellID];
        [self registerClass:[YCHTableViewFooterView class] forHeaderFooterViewReuseIdentifier:SignUpFooterViewID];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 100.f)];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BIND_PARK_CARD_CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHCKeyValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SignUpCellID];
    
    if (indexPath.row == 0) {
        [cell updateCellContentWithCardLTitle:@"姓名" andCardTFPlaceHolder:@"请输入姓名" andCardTFTitle:nil];
    } else if (indexPath.row == 1) {
        [cell updateCellContentWithCardLTitle:@"手机号码" andCardTFPlaceHolder:@"请输入手机号码" andCardTFTitle:nil];
    } else if (indexPath.row == 2) {
        [cell updateCellContentWithCardLTitle:@"密码" andCardTFPlaceHolder:@"字母或者数字，8位以上" andCardTFTitle:nil];
    } else if (indexPath.row == 3) {
        [cell updateCellContentWithCardLTitle:@"确认密码" andCardTFPlaceHolder:@"请再次输入密码" andCardTFTitle:nil];
    }
//    else if (indexPath.row == 4) {
//        [cell updateCellContentWithCardLTitle:@"手机验证码" andCardTFPlaceHolder:@"请输入验证码" andCardTFTitle:nil];
//        cell.cardNoTF.rightView = [self.gainVerifyView verifyViewWithPhase:GainVerifyPhaseNotSend timerID:@"UMSSignUp"];
//        cell.cardNoTF.rightViewMode = UITextFieldViewModeAlways;
//    } else if (indexPath.row == 5) {
//        [cell updateCellContentWithCardLTitle:@"授权码" andCardTFPlaceHolder:@"请输入授权码" andCardTFTitle:nil];
//    }
    
    return cell;
}

- (UMSGainVerifyView *)gainVerifyView {
    if (!_gainVerifyView) {
        _gainVerifyView = [[UMSGainVerifyView alloc] initWithFrame:CGRectZero];
        [_gainVerifyView.verifyButton addTarget:self action:@selector(starTimer) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    }
    return _gainVerifyView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    YCHTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SignUpFooterViewID];
    footerView.backgroundColor = UMS_TABLE_BG_COLOR;
    [footerView.nextBtn addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    [footerView.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    return footerView;
}

- (void)gotoRegister {
     YHCKeyValueTableViewCell * nameCell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    YHCKeyValueTableViewCell * phoneCell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    YHCKeyValueTableViewCell * passwordCell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
     YHCKeyValueTableViewCell * passwordTwoCell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    YHCKeyValueTableViewCell * verifyCodeCell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    YHCKeyValueTableViewCell * authCodeCell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    if (self.signUpTableViewDelegate && [self.signUpTableViewDelegate respondsToSelector:@selector(registerWithName:phoneNum:password:passwordTwo:verifyCode:authCode:)]) {
        [self.signUpTableViewDelegate registerWithName:nameCell.cardNoTF.text phoneNum:phoneCell.cardNoTF.text password:passwordCell.cardNoTF.text passwordTwo:passwordTwoCell.cardNoTF.text verifyCode:verifyCodeCell.cardNoTF.text authCode:authCodeCell.cardNoTF.text];
    }
    
}

- (void)starTimer {
    YHCKeyValueTableViewCell * phoneCell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (self.signUpTableViewDelegate && [self.signUpTableViewDelegate respondsToSelector:@selector(sendVerifyCodeWithPhoneNum:)]) {
        [self.signUpTableViewDelegate sendVerifyCodeWithPhoneNum:phoneCell.cardNoTF.text];
    }
}

@end
