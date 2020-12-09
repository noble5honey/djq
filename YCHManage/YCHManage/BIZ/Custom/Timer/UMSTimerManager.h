//
//  UMSTimerManager.h
//  ChinaUMS
//
//  Created by macj on 2017/2/17.
//  Copyright © 2017年 ChinaUMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSTimer.h"

#define TimerManager        [UMSTimerManager sharedInstance]

@class UMSTimerManager;
@protocol UMSTimerManagerDelegate <NSObject>

- (void)timerManager:(UMSTimerManager *)timerManager timerID:(NSString *)timerID time:(NSUInteger)time;

@end

@interface UMSTimerManager : NSObject

@property (nonatomic, strong) NSMutableArray <UMSTimer *> *timers;

@property (nonatomic, weak) id<UMSTimerManagerDelegate> timerManagerDelegate;

+ (instancetype)sharedInstance;

- (void)startTimerWithID:(NSString *)timerID duration:(NSUInteger)duration;

- (void)closeTimerWithID:(NSString *)timerID;

- (NSUInteger)getTimeFromTimerWithID:(NSString *)timerID;

- (BOOL)isTimerRunningWithTimerID:(NSString *)timerID;

@end
