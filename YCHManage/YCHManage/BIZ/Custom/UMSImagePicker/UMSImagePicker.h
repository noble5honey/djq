//
//  UMSImagePicker.h
//  获取图片
//
//  Created by macj on 16/3/24.
//  Copyright © 2016年 macj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CompletedBlock)(UIImage *image);

typedef NS_ENUM(NSUInteger, UMSPhotoPickerJPGQuailityType) {
    UMSPhotoPickerJPGQuailityTypeDefault = 0,
    UMSPhotoPickerJPGQuailityTypeHigh,
    UMSPhotoPickerJPGQuailityTypeMedium,
    UMSPhotoPickerJPGQuailityTypeLow
};

@interface UMSImagePicker : NSObject

@property (nonatomic, assign) UMSPhotoPickerJPGQuailityType quailityType;

@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, copy) CompletedBlock completedBlock;

- (void)addPhotoPickerToViewController:(UIViewController *)viewController completedBlock:(CompletedBlock)completedBlock;

- (void)addPhotoPickerToViewController:(UIViewController *)viewController quailityType:(UMSPhotoPickerJPGQuailityType)quailityType imageSize:(CGSize)imageSize completedBlock:(CompletedBlock)completedBlock;

@end
