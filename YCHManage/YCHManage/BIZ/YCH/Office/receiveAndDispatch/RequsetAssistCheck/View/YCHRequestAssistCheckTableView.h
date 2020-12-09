//
//  YCHRequestAssistCheckTableView.h
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCHRequestAssistCheckTableViewDelegate <NSObject>

- (void)requestAssistCheckTableViewSendMessageWithTextField:(UITextField *)textField textView:(UITextView *)textView;

- (void)requestAssistCheckTableViewDidSelectDepartment;

@end

@interface YCHRequestAssistCheckTableView : UITableView

@property (nonatomic, weak) id<YCHRequestAssistCheckTableViewDelegate> requsetAssistCheckTVDelegate;

- (void)updateTableViewWithDisplaySelectDepartment:(NSString *)dispalyStr;

@end
