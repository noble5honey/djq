//
//  YCHBasicInfoScalePictureView.h
//  YCHManage
//
//  Created by sunny on 2020/9/15.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHBasicInfoScalePictureView : UIView

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIImageView *scaleImageView;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIImageView *closeImageView;

- (void)updateViewWihtImage:(UIImage *)image;

@end
