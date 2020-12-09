//
//  UMSTimer.h
//  ChinaUMS
//
//  Created by macj on 2017/2/17.
//  Copyright © 2017年 ChinaUMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UMSTimer;
@protocol UMSTimerDelegate <NSObject>

- (void)timer:(NSTimer *)timer timerID:(NSString *)timerID time:(NSUInteger)time;

@end

@interface UMSTimer : NSObject

@property (strong) NSTimer *timer;

@property (nonatomic, copy) NSString *timerID;

@property (nonatomic, assign) NSUInteger time;

@property (nonatomic, assign) NSUInteger duration;

@property (nonatomic, weak) id<UMSTimerDelegate> timerDelegate;

- (instancetype)initWithTimeID:(NSString *)timerID duration:(NSUInteger)duration;

- (void)start;

- (void)stop;

//- (void)pause;

@end
