//
//  UMSMyHomeUserInfoCell.h
//  ChinaUMS
//
//  Created by ums on 16/1/23.
//  Copyright © 2016年 ChinaUMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMSMyHomeUserInfoCell : UITableViewCell

@property (nonatomic, strong) UIImageView * myIconIV;

@property (nonatomic, strong) UILabel *myNameLabel;

//@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UIImageView *genderIV;

@property (nonatomic, strong) UIImageView *cellArrowIV;

@property (nonatomic, strong) UILabel *myNickName;

- (void)updateInfoCellContent;

+ (CGFloat)heightForCell;

@end
