//
//  YCHHomePageManagerTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/6/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHHomePageManagerTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *hotelTitleLabel;

@property (nonatomic, strong) UILabel *hotelvalueLabel;

@property (nonatomic, strong) UILabel *codeTitleLabel;

@property (nonatomic, strong) UILabel *codeValueLabel;

@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) UIButton *basicInformationBtn;

@property (nonatomic, strong) UIButton *recordBtn;

@property (nonatomic, strong) UIView *middleLine;


- (void)updateCellWithName:(NSString *)name code:(NSString *)code score:(NSString *)score levelStr:(NSString *)levelStr;

- (void)showBottomButton;

- (void)hiddenBottomButton;

- (void)settingPermission:(NSString *)isPermission;

@end
