//
//  UMSSignUpGainVerifyView.m
//  ChinaUMS
//
//  Created by macj on 16/1/21.
//  Copyright © 2016年 ChinaUMS. All rights reserved.
//

#import "UMSGainVerifyView.h"

#define VERIFYBUTTON_WIDTH 80
#define VERIFYBUTTON_HEIGHT 35
#define VERIFYBUTTON_EDGE     UIEdgeInsetsMake(0, -5, 0, 5)

#define VERIFYBUTTON_FONT_SIZE 13

#define DEADLINE_TIME 60

@interface UMSGainVerifyView () <UMSTimerManagerDelegate>

@property (nonatomic, copy) NSString *timerID;

@end

@implementation UMSGainVerifyView

- (instancetype)verifyViewWithPhase:(GainVerifyPhase)gainVerifyPhase timerID:(NSString *)timerID {
    
    TimerManager.timerManagerDelegate = self;
    self.timerID = timerID;
    [self setupConstraint];
    self.bounds = CGRectMake(0, 0, VERIFYBUTTON_WIDTH, VERIFYBUTTON_HEIGHT);
    
    if ([TimerManager getTimeFromTimerWithID:timerID] > 0) {
        [self updateTimeTitle];
        return self;
    }
    
    switch (gainVerifyPhase) {
            
        case GainVerifyPhaseCanNotSend:
            
            self.verifyButton.enabled = NO;
            [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateDisabled];
            
            break;
            
        case GainVerifyPhaseNotSend:

            self.verifyButton.enabled = YES;
            [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateDisabled];
            break;
        case GainVerifyPhaseSending:
            
            
            break;
        case GainVerifyPhaseSendAgain:
            self.verifyButton.enabled = YES;
            [self.verifyButton setTitle:@"重新发送" forState:UIControlStateNormal];
            
            break;
            
        default:
            break;
    }
    return self;
}

- (void)resetTimer {
    [TimerManager closeTimerWithID:self.timerID];
}

- (void)switchToEnabled {
    NSString *str = self.verifyButton.currentTitle;
    if ([str isEqualToString:@"获取验证码"]) {
        self.verifyButton.enabled = YES;
        self.verifyButton.titleLabel.font = [UIFont UMSBoldDefaultFontOfSize:13];
    }
}

- (void)switchToDisabled {
    NSString *str = self.verifyButton.currentTitle;
    if ([str isEqualToString:@"获取验证码"]) {
        self.verifyButton.enabled = NO;
        self.verifyButton.titleLabel.font = [UIFont UMSDefaultFontOfSize:13];
    }
}

- (void)updateTimeTitle {

    if ([TimerManager getTimeFromTimerWithID:self.timerID] == DEADLINE_TIME) {
        // 定时结束
        [self resetTimer];
        
        self.verifyButton.enabled = YES;
        [self.verifyButton setTitle:@"重新发送" forState:UIControlStateNormal];
        self.verifyButton.titleLabel.font = [UIFont UMSBoldDefaultFontOfSize:13];
        
    } else {
        
        NSString *title = [NSString stringWithFormat:@"重新发送(%ld)", DEADLINE_TIME - [TimerManager getTimeFromTimerWithID:self.timerID]];
        [self.verifyButton setTitle:title forState:UIControlStateDisabled];
        self.verifyButton.titleLabel.font = [UIFont UMSDefaultFontOfSize:13];
        self.verifyButton.enabled = NO;
    }
}

- (void)startTimer {
    [self updateTimeTitle];
    [TimerManager startTimerWithID:self.timerID duration:DEADLINE_TIME];
}

- (UIButton *)verifyButton {
    
    if (!_verifyButton) {
        _verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifyButton setTitleColor:UMS_THEME_COLOR forState:UIControlStateNormal];
        [_verifyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _verifyButton.titleLabel.font = [UIFont UMSDefaultFontOfSize:13];
        [self addSubview:_verifyButton];
    }
    return _verifyButton;
}

- (void)setupConstraint {
    [self.verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(VERIFYBUTTON_EDGE);
    }];
}

- (void)timerManager:(UMSTimerManager *)timerManager timerID:(NSString *)timerID time:(NSUInteger)time {
    if ([timerID isEqualToString:self.timerID]) {
        [self updateTimeTitle];
    }
}

@end
