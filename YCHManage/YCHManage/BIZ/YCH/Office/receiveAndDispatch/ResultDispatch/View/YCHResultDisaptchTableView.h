//
//  YCHResultDisaptchTableView.h
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, YCHResultDispatchTextFieldTpye) {
    YCHResultDispatchTextFieldTpyeStart = 0,
    YCHResultDispatchTextFieldTpyeEnd
};

@protocol YCHRequestAssistCheckTableViewDelegate <NSObject>

- (void)requestAssistCheckTableViewSendMessageWithTextField:(UITextField *)textField textView:(UITextView *)textView;

- (void)requestAssistCheckTableViewDidSelectDepartment;

- (void)resultDispatchTableViewStartTextFieldEdit:(UITextField *)textField textfieldType:(YCHResultDispatchTextFieldTpye)textfieldType;

- (void)resultDispatchTableViewEndTextFieldEdit:(UITextField *)textField textfieldType:(YCHResultDispatchTextFieldTpye)textfieldType;

- (void)resultDispatchTableViewDidSelectDeductItem;

@end

@interface YCHResultDisaptchTableView : UITableView

@property (nonatomic, weak) id<YCHRequestAssistCheckTableViewDelegate> requsetAssistCheckTVDelegate;

- (void)updateTableViewWithDisplaySelectDepartment:(NSString *)dispalyStr;

- (void)updateTableViewWithDeductItemTitleText:(NSString *)str;

@end

