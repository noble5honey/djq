//
//  YCHHomePageExamineTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/6/28.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHHomePageExamineTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *bottomLine;

- (void)updateCellTitle:(NSString *)title;

@end
