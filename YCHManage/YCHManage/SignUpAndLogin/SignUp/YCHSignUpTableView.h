//
//  YCHSignUpTableView.h
//  YCHManage
//
//  Created by sunny on 2020/6/11.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSGainVerifyView.h"
#import "YHCKeyValueTableViewCell.h"

@protocol YCHSignUpTableViewDelegate <NSObject>

//- (void) bindParkCardWithCell:(YHCKeyValueTableViewCell *)cell;
//
//- (void) bindParkCardWithSMSTF:(UITextField *)smsTF;

- (void) registerWithName:(NSString *)name phoneNum:(NSString *)phoneNum password:(NSString *)password passwordTwo:(NSString *)passwordTwo verifyCode:(NSString *)verifyCode authCode:(NSString *)authCode;

- (void) sendVerifyCodeWithPhoneNum:(NSString *)phoneNun;

@end

@interface YCHSignUpTableView : UITableView

@property (nonatomic, strong) UMSGainVerifyView *gainVerifyView;

@property (nonatomic,weak)id<YCHSignUpTableViewDelegate> signUpTableViewDelegate;

@end
