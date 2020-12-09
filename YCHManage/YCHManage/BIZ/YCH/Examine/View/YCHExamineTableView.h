//
//  YCHExamineTableView.h
//  YCHManage
//
//  Created by sunny on 2020/6/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHBaseTableViewCell.h"
#import "YCHExamineTableViewCell.h"

@protocol YCHExamineTableViewDelegate <NSObject>

- (void)tableViewDidSelectRow:(YCHBaseTableViewCell *)cell;

- (void)addImageActionWithCell:(YCHExamineTableViewCell *)cell;

- (void)examineTableViewTextViewDidChange:(UITextView *)textView;

- (void)examineTableViewTextFieldDidChange:(UITextField *)textField;

- (void)examineTableViewClickCommitButton;

- (void)exmineTableViewClickDeductItemCell;

- (void)exmineTableViewClickSecondButtonWithCell:(YCHExamineTableViewCell *)cell;

- (void)exmineTableViewClickThirdButtonWithCell:(YCHExamineTableViewCell *)cell;

@end

@interface YCHExamineTableView : UITableView

@property (nonatomic, weak) id<YCHExamineTableViewDelegate> examineDelegate;

- (void)updateTableViewCellWithDictionary:(NSDictionary *)dic;

@end
