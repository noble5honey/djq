//
//  YCHLoginView.m
//  YCHManage
//
//  Created by sunny on 2020/6/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHLoginView.h"

#define SEGMENTEDCONTROL_TOP_MARGIN 24.f
#define CONTENT_LEFT_RIGHT_MARGIN   31.f
#define SEGMENTEDCONTROL_HEIGHT     40.f
#define CONTENT_LEFT_RIGHT_MARGIN   31.f

#define ForgetPassWordButtonFont                    [UIFont systemFontOfSize:12]
#define FORGET_PASSWORD_BUTTON_COLOR                UMS_GRAY_150
#define SAVE_PASSWORD_BUTTON_PADDING                                        \
[YCHManageDevice screenAdaptiveSizeWithIp6Size:36.f]

#define PASSWORD_VIEW_PADDING_TOP                         \
[YCHManageDevice screenAdaptiveSizeWithIp6Size:40.f]
#define PASSWORD_VIEW_PADDING_LEFT_RIGHT                  \
[YCHManageDevice screenAdaptiveSizeWithIp6Size:24.f]
#define PASSWORD_VIEW_HEIGHT                              \
[YCHManageDevice screenAdaptiveSizeWithIp6Size:148.f]


@interface YCHLoginView()

@property (nonatomic,strong)UIImageView *logoImageView;

@property (nonatomic,assign)float segControlWidth;

@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation YCHLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpConstraints];
    }
    return self;
}

- (void)setUpConstraints{
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20.f);
//        make.right.equalTo(self).with.offset(-31.f);
        make.centerX.equalTo(self);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:250.f]);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:250.f]);
    }];
    
    [self.loginPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.segmentedControl.mas_bottom);
         make.top.equalTo(self.logoImageView.mas_bottom).offset(-30.f);
        make.left.equalTo(self).with.offset(PASSWORD_VIEW_PADDING_LEFT_RIGHT);
        make.right.equalTo(self).with.offset(-PASSWORD_VIEW_PADDING_LEFT_RIGHT);
        make.height.mas_equalTo(PASSWORD_VIEW_HEIGHT);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginPasswordView.mas_bottom).offset(10.f);
        make.right.equalTo(self).offset(-PASSWORD_VIEW_PADDING_LEFT_RIGHT);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.mas_offset(20);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
}

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_login"]];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (YCHLoginSegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        self.segControlWidth = [UIScreen mainScreen].bounds.size.width - 2 * CONTENT_LEFT_RIGHT_MARGIN;
        _segmentedControl = [[YCHLoginSegmentedControl alloc] initWithItems:@[[NSString stringWithFormat:@"管理员登录"],[NSString stringWithFormat:@"访客登录"]] target:self selector:@selector(segmentedControlSelected:) width:self.segControlWidth];
        [self addSubview:_segmentedControl];
    }
    return _segmentedControl;
}

- (YCHLoginPasswordView *)loginPasswordView {
    if (! _loginPasswordView) {
        _loginPasswordView = [[YCHLoginPasswordView alloc] initWithFrame:CGRectZero];
//        _loginPasswordView.hidden = YES;
        [self addSubview:_loginPasswordView];
    }
    return _loginPasswordView;
}

- (UIButton *)forgetPassWordButton {
    if (!_forgetPassWordButton) {
        _forgetPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPassWordButton setTitle:@"找回密码" forState:UIControlStateNormal];
        _forgetPassWordButton.titleLabel.font = ForgetPassWordButtonFont;
        [_forgetPassWordButton setTitleColor:FORGET_PASSWORD_BUTTON_COLOR forState:UIControlStateNormal];
        [self addSubview:_forgetPassWordButton];
    }
    return _forgetPassWordButton;
}

- (UIButton *)queryButton {
    if (!_queryButton) {
        _queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_queryButton setTitle:@"渔家乐扣分查询" forState:(UIControlState)UIControlStateNormal];
        _queryButton.titleLabel.font = ForgetPassWordButtonFont;
        [_queryButton setTitleColor:UMS_THEME_COLOR forState:UIControlStateNormal];
        [self addSubview:_queryButton];
    }
    return _queryButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:(UIControlState)UIControlStateNormal];
        _registerButton.titleLabel.font = ForgetPassWordButtonFont;
        [_registerButton setTitleColor:UMS_THEME_COLOR forState:UIControlStateNormal];
        [self addSubview:_registerButton];
    }
    return _registerButton;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bottomLabel.text = @"Copyright©2020 苏州阳澄湖生态休闲旅游度假区";
        _bottomLabel.font = [UIFont UMSChinaLightFontNameOfSize:11.f];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bottomLabel];
    }
    return _bottomLabel;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

#pragma mark - "处理segmentedControl点击事件"
- (void)segmentedControlSelected:(UISegmentedControl *)segControl{
    if (segControl.selectedSegmentIndex == SegmentedIndexTypeManager) {
        self.currentType = SegmentedIndexTypeManager;
        self.loginPasswordView.accountTF.text = @"";
        self.loginPasswordView.passwordTF.text = @"";
        [self.loginPasswordView.accountTF becomeFirstResponder];
        self.forgetPassWordButton.hidden = NO;
        self.registerButton.hidden = NO;
//        [self managerTXFIsHidden:NO];
    }else{
        self.currentType = SegmentedIndexTypeVisitor;
        self.loginPasswordView.accountTF.text = @"";
        self.loginPasswordView.passwordTF.text = @"";
        [self.loginPasswordView.accountTF becomeFirstResponder];
        self.forgetPassWordButton.hidden = YES;
        self.registerButton.hidden = YES;

//        [self managerTXFIsHidden:YES];
    }
//    [self checkLoginButton:segControl.selectedSegmentIndex];
}



@end
