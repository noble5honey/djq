//
//  MposSegmentedControl.h
//  UMSMposI
//
//  Created by limin on 17/2/28.
//  Copyright © 2017年 chinaums. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHLoginSegmentedControl : UIView

@property (nonatomic, assign)NSInteger selectedSegmentedIndex;

@property (nonatomic,strong) UISegmentedControl *customSegmentedControl;

- (instancetype)initWithItems:(NSArray *)items target:(id)target selector:(SEL)selector width:(float)width;

@end
