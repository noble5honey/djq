//
//  YCHExamineTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/6/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHExamineTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextView *recordTextView;

@property (nonatomic, strong) UILabel *tagLabel;

@property (nonatomic, strong) UIImageView *addImageView;

@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UIImageView *showImageView;

@property (nonatomic, strong) UIImageView *secondImageView;

@property (nonatomic, strong) UIButton *secondButton;

@property (nonatomic, strong) UIImageView *thirdImageView;

@property (nonatomic, strong) UIButton *thirdButton;

- (void)updateCellShowPictureWithPictureArray:(NSArray *)picArray;

- (void)nativeUpdateCellPictureWithPictureArray:(NSArray<UIImage *>*)picArray;

- (void)updateCellWithCorrectItemDic:(NSDictionary *)correctItemDic;

- (CGFloat)cellHeight;

@end
