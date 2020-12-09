//
//  YCHBaseLoginView.h
//  YCHManage
//
//  Created by sunny on 2020/6/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSDeformationButton.h"

#define PHONE_NUMBER_TF_PLACEHOLDER_COLOR                                             \
UMS_GRAY_180

#define PHONE_NUMBER_TF_TEXT_COLOR                                                    \
[UIColor colorWithRed:59 / 255.0 green:59 / 255.0 blue:59 / 255.0 alpha:1.0]

#define LOGIN_BUTTON_COLOR                                                            \
[UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1.0]

#define NEXT_BUTTON_ENABLED_COLOR                                                             \
[UIColor colorWithRed:234 / 255.0 green:90 / 255.0 blue:24 / 255.0 alpha:1.0]

#define NEXT_BUTTON_DISABLED_COLOR                                                             \
[UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1.0]

#define LOGIN_BUTTON_FONT                                   [UIFont systemFontOfSize:15]
#define NEXT_BUTTON_FONT                                    [UIFont systemFontOfSize:16]
#define PHONE_NUMBER_TF_FONT                                [UIFont systemFontOfSize:16]

@interface YCHBaseLoginView : UIView

@property(nonnull, nonatomic, strong) UITextField *accountTF;

@property(nonnull, nonatomic, strong) UITextField *passwordTF;

@property(nonnull, nonatomic, strong) UITextField *verifyTF;

@property (nonnull, nonatomic, strong) UIButton *forgetPassWordButton;

@property (nonnull, nonatomic, strong) UIButton *weiChatButton;

@property (nonnull, nonatomic, strong) UIButton *messageButton;

@property (nonnull, nonatomic, strong) UMSDeformationButton *logInButton;

@property (nonnull, nonatomic, strong) UIButton *nextButton;

@property (nonnull, nonatomic, strong) UIButton *signUpButton;

@end
