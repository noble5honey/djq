//
//  UMSGainVerifyView.h
//  ChinaUMS
//
//  Created by macj on 16/1/21.
//  Copyright © 2016年 ChinaUMS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, GainVerifyPhase) {
    GainVerifyPhaseCanNotSend, // 不能获取验证码
    GainVerifyPhaseNotSend, // 获取验证码
    GainVerifyPhaseSending, // 重新发送倒计时
    GainVerifyPhaseSendAgain // 重新发送
};

@interface UMSGainVerifyView : UIView

@property (nonatomic, strong) UIButton *verifyButton;

- (instancetype)verifyViewWithPhase:(GainVerifyPhase)gainVerifyPhase timerID:(NSString *)timerID;

- (void)resetTimer;

- (void)switchToEnabled;

- (void)switchToDisabled;

- (void)startTimer;

@end
