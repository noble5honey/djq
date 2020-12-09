//
//  YCHAddResultNotiTableView.h
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YCHAddResultNotiTextFieldTpye) {
    YCHAddResultNotiTextFieldTpyeStart = 0,
    YCHAddResultNotiTextFieldTpyeEnd
};

@protocol YCHAddResultNotiTableViewDelegate <NSObject>

- (void)addResultNotiTableViewDidSelectDepartment;

- (void)selectedStartDate:(NSString *)startDate endDate:(NSString *)endDate;

- (void)clickDeductItemCell;

- (void)clickThemeTextFieldAndChange:(UITextField *)textField;

- (void)addResultNotiTableViewTextViewDidChange:(UITextView *)textView;

- (void)addResultNotiTableViewAutoGenerateTextView:(UITextView *)textView;

- (void)addResultNotiTableViewDidScroll;

@end

@interface YCHAddResultNotiTableView : UITableView

@property (nonatomic, weak) id<YCHAddResultNotiTableViewDelegate>addResultNotiTVDelegate;

- (void)updateTableViewWithDisplaySelectDepartment:(NSString *)dispalyStr;

- (void)updateTableViewCellWithDictionary:(NSDictionary *)dic indexPath:(NSIndexPath *)indexPath;

@end
