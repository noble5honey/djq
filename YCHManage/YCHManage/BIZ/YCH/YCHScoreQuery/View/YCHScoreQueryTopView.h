//
//  YCHScoreQueryTopView.h
//  YCHManage
//
//  Created by sunny on 2020/6/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSSearchBar.h"

@interface YCHScoreQueryTopView : UIView

@property (nonatomic, strong) UMSSearchBar *searchBar;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIImageView *filtrateIV;

@property (nonatomic, strong) UILabel *filtrateLB;

@property (nonatomic, strong) UIButton *filtrateBtn;

@end
