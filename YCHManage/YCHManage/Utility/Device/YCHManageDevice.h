//
//  YCHManageDevice.h
//  YCHManage
//
//  Created by sunny on 2020/6/8.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ISIOS10         Device.isIOS10
#define ISIOS9          Device.isIOS9
#define ISIOS8          Device.isIOS8
#define ISIPad          Device.isIPad
#define ISIPhone6Plus   Device.isIPhone6Plus
#define ISIPhone6       Device.isIPhone6
#define ISIPhone5       Device.isIPhone5
#define ISIPhone4       Device.isIPhone4
#define ISIphoneX       Device.isIPhoneX
#define ISIphoneXMAX    Device.isIPhoneXMAX
#define ISSimulator     Device.isSimulator

#define Device          [YCHManageDevice sharedYCHManageDevice]

#define kIs_iPhoneX  Width_Screen>=375.0f && Height_Screen >=812.0f


@interface YCHManageDevice : UIDevice

@property (nonatomic, assign, readonly) BOOL isIOS10;
@property (nonatomic, assign, readonly) BOOL isIOS9;
@property (nonatomic, assign, readonly) BOOL isIOS8;
@property (nonatomic, assign, readonly) BOOL isIPad;
@property (nonatomic, assign, readonly) BOOL isIPhone6Plus;
@property (nonatomic, assign, readonly) BOOL isIPhone6;
@property (nonatomic, assign, readonly) BOOL isIPhone5;
@property (nonatomic, assign, readonly) BOOL isIPhone4;
@property (nonatomic, assign, readonly) BOOL isSimulator;
@property (nonatomic, assign, readonly) BOOL isIPhoneX;
@property (nonatomic, assign, readonly) BOOL isIPhoneXMAX;

+ (instancetype)sharedYCHManageDevice;

+ (CGFloat)screenAdaptiveSizeWithIp6Size:(CGFloat)ip6Size;

@end
