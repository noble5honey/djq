//
//  YCHDeductScoreCollectionViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/6/30.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHDeductScoreCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *title;

- (void)updateCellTitle:(NSString *)title;

@end
