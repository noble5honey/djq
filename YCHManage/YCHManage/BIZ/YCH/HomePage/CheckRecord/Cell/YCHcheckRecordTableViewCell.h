//
//  YCHcheckRecordTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/9/15.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHcheckRecordTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *itemTitleLabel;

@property (nonatomic, strong) UILabel *itemValueLabel;

@property (nonatomic, strong) UILabel *scoreTitleLabel;

@property (nonatomic, strong) UILabel *scoreValueLabel;

@property (nonatomic, strong) UILabel *dateTitleLabel;

@property (nonatomic, strong) UILabel *dateValueLabel;

@property (nonatomic, strong) UILabel *reasonTitleLabel;

@property (nonatomic, strong) UILabel *reasonValueLabel;

@property (nonatomic, strong) UILabel *deadlineTitleLabel;

@property (nonatomic, strong) UILabel *deadlineValueLabel;

@property (nonatomic, strong) UIButton *fixButton;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIImageView *firstImageView;

@property (nonatomic, strong) UIImageView *secondImageView;

@property (nonatomic, strong) UIImageView *thirdImageView;

@property (nonatomic, strong) UIButton *firstButton;

@property (nonatomic, strong) UIButton *secondButton;

@property (nonatomic, strong) UIButton *thirdButton;

- (void)updateCellContentWithDic:(NSDictionary *)contentDic;

- (void)updateCellWithPicArray:(NSArray *)picArray;

- (CGFloat)cellHeight;

@end
