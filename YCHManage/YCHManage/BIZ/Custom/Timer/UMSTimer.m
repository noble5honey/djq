//
//  UMSTimer.m
//  ChinaUMS
//
//  Created by macj on 2017/2/17.
//  Copyright © 2017年 ChinaUMS. All rights reserved.
//

#import "UMSTimer.h"

@interface UMSTimer ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskId;

@end

@implementation UMSTimer

- (instancetype)initWithTimeID:(NSString *)timerID duration:(NSUInteger)duration {
    if (self = [super init]) {
        self.timerID = timerID;
        self.duration = duration;
    }
    return self;
}

- (void)start {
    
    if (!self.backgroundTaskId || self.backgroundTaskId == UIBackgroundTaskInvalid) {
        
//        @weakify(self)
        __weak typeof(self) weakSelf = self;
        __strong typeof(self) strongSelf = self;
        weakSelf.backgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//            @strongify(self)
            [[UIApplication sharedApplication] endBackgroundTask:strongSelf.backgroundTaskId];
            strongSelf.backgroundTaskId = UIBackgroundTaskInvalid;
        }];
        
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeUpdated) userInfo:nil repeats:YES];
}

- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
    
    if (self.backgroundTaskId != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskId];
        self.backgroundTaskId = UIBackgroundTaskInvalid;
    }
}

- (void)timeUpdated {
    self.time++;
    
    if (self.timerDelegate && [self.timerDelegate respondsToSelector:@selector(timer:timerID:time:)]) {
        [self.timerDelegate timer:self.timer timerID:self.timerID time:self.time];
    }
}

- (void)dealloc {

}

@end
