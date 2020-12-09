//
//  UMSTimerManager.m
//  ChinaUMS
//
//  Created by macj on 2017/2/17.
//  Copyright © 2017年 ChinaUMS. All rights reserved.
//

#import "UMSTimerManager.h"

@interface UMSTimerManager () <UMSTimerDelegate>

@end

@implementation UMSTimerManager

static UMSTimerManager *_sharedInstance = nil;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UMSTimerManager alloc] init];
    });
    return _sharedInstance;
    
}

- (instancetype)init {
    if (self = [super init]) {
        self.timers = [NSMutableArray array];
    }
    return self;
}

- (void)startTimerWithID:(NSString *)timerID duration:(NSUInteger)duration {
    
    UMSTimer *timer = [[UMSTimer alloc] initWithTimeID:timerID duration:duration];
    timer.timerDelegate = self;
    [self.timers addObject:timer];
    [timer start];
}

- (void)closeTimerWithID:(NSString *)timerID {
    for (int i = 0; i < self.timers.count; i++) {
        if ([timerID isEqualToString:self.timers[i].timerID]) {
            [self.timers[i] stop];
            [self.timers removeObject:self.timers[i]];
        }
    }
}

- (NSUInteger)getTimeFromTimerWithID:(NSString *)timerID {
    for (int i = 0; i < self.timers.count; i++) {
        if ([timerID isEqualToString:self.timers[i].timerID]) {
            return self.timers[i].time;
        }
    }
    return 0;
}

- (BOOL)isTimerRunningWithTimerID:(NSString *)timerID {
    for (int i = 0; i < self.timers.count; i++) {
        if ([timerID isEqualToString:self.timers[i].timerID]) {
            return YES;
        }
    }
    return NO;
}

- (void)timer:(NSTimer *)timer timerID:(NSString *)timerID time:(NSUInteger)time {
    
    UMSTimer *willBeRemovedTimer;
    
    if (self.timers.count > 0) {
        for (int i = 0; i < self.timers.count; i++) {
            if ([timerID isEqualToString:self.timers[i].timerID] && time > self.timers[i].duration) {
                [self.timers[i] stop];
                willBeRemovedTimer = self.timers[i];
                break;
            }
        }
        if (willBeRemovedTimer) {
            [self.timers removeObject:willBeRemovedTimer];
        }
    }
    
    if (self.timerManagerDelegate && [self.timerManagerDelegate respondsToSelector:@selector(timerManager:timerID:time:)]) {
        
        [self.timerManagerDelegate timerManager:self timerID:timerID time:time];
        
//        NSLog(@"timerID: %@ , time: %ld", timerID, time);
        
    }
}

@end
