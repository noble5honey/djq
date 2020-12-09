//
//  YCHCorrectAndDetailsTableVIew.h
//  YCHManage
//
//  Created by sunny on 2020/9/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHExamineTableViewCell.h"

@protocol YCHCorrectAndDetailsTableVIewDelegate <NSObject>

- (void)clickHotelPictureShowSacleImage:(UIImage *)image;

- (void)correctAndDetailsTableViewTextViewDidChange:(UITextView *)textView;

- (void)correctAndDetailsTableViewClickCommitButton;

- (void)correctAndDetailTableViewClickFirstButtonWithCell:(YCHExamineTableViewCell *)cell;

- (void)correctAndDetailTableViewClickSecondButtonWithCell:(YCHExamineTableViewCell *)cell;

- (void)correctAndDetailTableViewClickThirdButtonWithCell:(YCHExamineTableViewCell *)cell;

@end

@interface YCHCorrectAndDetailsTableVIew : UITableView

@property (nonatomic, weak) id<YCHCorrectAndDetailsTableVIewDelegate> correctAndDetailsTVDelegate;

- (void)updateTableViewWithItemDic:(NSDictionary *)itemDic;

@end
