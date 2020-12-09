//
//  YCHLoginPasswordView.m
//  YCHManage
//
//  Created by sunny on 2020/6/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHLoginPasswordView.h"

#define PhoneNumberTFPlaceHolderColor               UMS_GRAY_150
#define PhoneNumberTFTextColor                                                      \
[UIColor colorWithRed:59 / 255.0 green:59 / 255.0 blue:59 / 255.0 alpha:1.0]
#define LOGIN_BUTTON_ENABLE_COLOR                                                   \
[UIColor colorWithRed:232 / 255.0 green:91 / 255.0 blue:39 / 255.0 alpha:1.0]

#define LINE_IV_COLOR                                                             \
[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0]

#define TF_CONTENT_VIEW_CORNER                              4.f
#define TF_CONTENT_VIEW_COLOR                               UMS_TEXT_FIELD_COLOR
#define TF_CONTENT_VIEW_PADDING_TOP                         \
[YCHManageDevice screenAdaptiveSizeWithIp6Size:40.f]
#define TF_CONTENT_VIEW_PADDING_LEFT_RIGHT                  \
[YCHManageDevice screenAdaptiveSizeWithIp6Size:24.f]
#define TF_CONTENT_VIEW_HEIGHT 88.f

#define ACCOUNTTF_CORNER                    4.f
#define ACCOUNTTF_PADDING                   12.f
#define ACCOUNTTF_HEIGHT                    44.f

#define PASSWORDTF_CORNER                   4.f

#define LINE_IV_HEIGHT                      .5f
#define LINE_IV_PADDING                     8.f

#define LOGIN_IN_BUTTON_PADDING_TOP 20.f
#define LOGIN_IN_BUTTON_HEIGHT                                              \
[YCHManageDevice screenAdaptiveSizeWithIp6Size:40.f]
#define LOGIN_BUTTON_CORNER                                                 \
[YCHManageDevice screenAdaptiveSizeWithIp6Size:20.f]

@interface YCHLoginPasswordView ()

@property (nonatomic, strong) UIView *tFContentView;
@property (nonatomic, strong) UIImageView *lineIV;

@end

@implementation YCHLoginPasswordView

@synthesize accountTF = _accountTF;
@synthesize passwordTF = _passwordTF;
@synthesize logInButton = _logInButton;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUpConstrain];
    }
    return self;
}

- (void)setUpConstrain {
    
    [self.tFContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(TF_CONTENT_VIEW_HEIGHT);
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tFContentView);
        make.left.equalTo(self.tFContentView).with.offset(ACCOUNTTF_PADDING);
        make.right.equalTo(self.tFContentView);
        make.height.mas_equalTo(ACCOUNTTF_HEIGHT);
    }];
    
    [self.lineIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountTF.mas_bottom);
        make.left.equalTo(self.tFContentView).with.offset(LINE_IV_PADDING);
        make.right.equalTo(self.tFContentView).with.offset(-LINE_IV_PADDING);
        make.height.mas_equalTo(LINE_IV_HEIGHT);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineIV.mas_bottom);
        make.left.equalTo(self.accountTF);
        make.right.equalTo(self.tFContentView);
        make.height.equalTo(self.accountTF);
    }];
    
    [self.logInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTF.mas_bottom).with.offset(LOGIN_IN_BUTTON_PADDING_TOP);
        make.left.equalTo(self.tFContentView);
        make.right.equalTo(self.tFContentView);
        make.height.mas_equalTo(LOGIN_IN_BUTTON_HEIGHT);
    }];
}

- (UIView *)tFContentView {
    if (! _tFContentView) {
        _tFContentView = [[UIView alloc] initWithFrame:CGRectZero];
        _tFContentView.backgroundColor = TF_CONTENT_VIEW_COLOR;
        _tFContentView.layer.cornerRadius = TF_CONTENT_VIEW_CORNER;
        [self addSubview:_tFContentView];
    }
    return _tFContentView;
}

- (UITextField *)accountTF {
    
    if (! _accountTF) {
        _accountTF = [[UITextField alloc] init];
        _accountTF.tag = LOGIN_ACCOUTTF_TAG;
        _accountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"账号" attributes:@{NSFontAttributeName:PHONE_NUMBER_TF_FONT,NSForegroundColorAttributeName:PhoneNumberTFPlaceHolderColor}];
        _accountTF.font = PHONE_NUMBER_TF_FONT;
        _accountTF.translatesAutoresizingMaskIntoConstraints = NO;
        _accountTF.textColor = PhoneNumberTFTextColor;
        _accountTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        _accountTF.returnKeyType = UIReturnKeyNext;
        _accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _accountTF.autocorrectionType = UITextAutocorrectionTypeNo;
        //[self.phoneNumberTF setKeyboardAppearanceType];
        _accountTF.keyboardType = UIKeyboardTypeDefault;
        _accountTF.layer.cornerRadius = ACCOUNTTF_CORNER;
        _accountTF.tintColor = UMS_THEME_COLOR;
        [self.tFContentView addSubview:_accountTF];
    }
    
    return _accountTF;
}

- (UIImageView *)lineIV {
    
    if (! _lineIV) {
        _lineIV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineIV.backgroundColor = LINE_IV_COLOR;
        [self.tFContentView addSubview:_lineIV];
    }
    
    return _lineIV;
}

- (UITextField *)passwordTF {
    
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.tag = LOGIN_PASSWORDTF_TAG;
        _passwordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSFontAttributeName:PHONE_NUMBER_TF_FONT,NSForegroundColorAttributeName:PhoneNumberTFPlaceHolderColor}];
        _passwordTF.font = PHONE_NUMBER_TF_FONT;
        _passwordTF.translatesAutoresizingMaskIntoConstraints = NO;
        _passwordTF.textColor = PhoneNumberTFTextColor;
        _passwordTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        _passwordTF.returnKeyType = UIReturnKeyNext;
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordTF.autocorrectionType = UITextAutocorrectionTypeNo;
        //[self.phoneNumberTF setKeyboardAppearanceType];
        _passwordTF.layer.cornerRadius = PASSWORDTF_CORNER;
        _passwordTF.tintColor = UMS_THEME_COLOR;
        _passwordTF.secureTextEntry = YES;
        [self.tFContentView addSubview:_passwordTF];
    }
    
    return _passwordTF;
}

- (UIButton *)logInButton {
    
    if (!_logInButton) {
        
        _logInButton = [UMSDeformationButton buttonWithType:UIButtonTypeCustom withColor:UMS_THEME_COLOR];
        _logInButton.backgroundColor = UMS_GRAY_220;
        [_logInButton setTitle:[NSString stringWithFormat:@"登录"] forState:UIControlStateNormal];
        _logInButton.titleLabel.font = LOGIN_BUTTON_FONT;
        [_logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logInButton.layer setCornerRadius:LOGIN_BUTTON_CORNER];
        
        [self addSubview:_logInButton];
        
        _logInButton.enabled = NO;
    }
    
    return _logInButton;
}

- (void)enableLogInButton {
    self.logInButton.enabled = YES;
    self.logInButton.backgroundColor = UMS_THEME_COLOR;
}

- (void)disEnableLogInButton {
    self.logInButton.enabled = NO;
    self.logInButton.backgroundColor = UMS_GRAY_220;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.accountTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}
@end
