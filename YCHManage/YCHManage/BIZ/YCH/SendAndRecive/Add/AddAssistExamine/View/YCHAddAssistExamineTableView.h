//
//  YCHAddAssistExamineTableView.h
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCHAddAssistExamineTableViewDelegate <NSObject>

- (void)addAssistExamineTableViewDidSelectDepartment;

- (void)clickThemeTextFieldAndChange:(UITextField *)textField;

- (void)addAssistExamineTableViewTextViewDidChange:(UITextView *)textView;

- (void)addAssistExamineTableViewTextFieldBeginEditing:(UITextField *)textField;

@end


@interface YCHAddAssistExamineTableView : UITableView

@property (nonatomic, weak) id<YCHAddAssistExamineTableViewDelegate>addAssistExamineTVDelegate;

- (void)updateTableViewWithDisplaySelectDepartment:(NSString *)dispalyStr;

@end

