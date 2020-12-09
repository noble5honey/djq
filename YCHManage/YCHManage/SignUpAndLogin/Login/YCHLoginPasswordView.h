//
//  YCHLoginPasswordView.h
//  YCHManage
//
//  Created by sunny on 2020/6/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHBaseLoginView.h"

#define LOGIN_ACCOUTTF_TAG      000001
#define LOGIN_PASSWORDTF_TAG    000002

@interface YCHLoginPasswordView : YCHBaseLoginView

- (void)enableLogInButton;

- (void)disEnableLogInButton;

@end
