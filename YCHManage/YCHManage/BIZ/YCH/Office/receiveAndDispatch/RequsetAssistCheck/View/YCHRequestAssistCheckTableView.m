//
//  YCHRequestAssistCheckTableView.m
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRequestAssistCheckTableView.h"
#import "YCHBaseTableViewCell.h"
#import "YCHTableViewFooterView.h"
#import "YCHReceiveAndDispatchTextFieldCell.h"
#import "YCHReceiveDetailsTextViewTableViewCell.h"

#define BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT 112.0f;

static NSString * examineBaseCellID = @"examine_base_cell_id";
static NSString * examineFootViewID = @"examine_footView_id";
static NSString * examineTextFieldID = @"examine_textField_id";
static NSString * receiveAndDispathDetailsTextViewCellID = @"receive_and_dispatch_details_textview_cell_id";

@interface YCHRequestAssistCheckTableView () <UITableViewDelegate, UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *selectDepartmentArray;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSString *displayStr;

@end

@implementation YCHRequestAssistCheckTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHBaseTableViewCell class] forCellReuseIdentifier:examineBaseCellID];
        [self registerClass:[YCHTableViewFooterView class] forHeaderFooterViewReuseIdentifier:examineFootViewID];
        [self registerClass:[YCHReceiveAndDispatchTextFieldCell class] forCellReuseIdentifier:examineTextFieldID];
        [self registerClass:[YCHReceiveDetailsTextViewTableViewCell class] forCellReuseIdentifier:receiveAndDispathDetailsTextViewCellID];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

- (void)updateTableViewWithDisplaySelectDepartment:(NSString *)dispalyStr {
    self.displayStr = dispalyStr;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YCHBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:examineBaseCellID forIndexPath:indexPath];
        cell.titleLabel.text = @"接收部门";
        cell.titleContentLabel.text = @"请选择";
        cell.titleContentLabel.textColor = UMS_TEXT_FIELD_PLACEHOLDER_COLOR;
        if ([self.displayStr isEqualToString:@""] || self.displayStr.length == 0 || self.displayStr == nil) {
            cell.titleContentLabel.text = @"请选择";
            cell.displayContentLB.text = @"";
        } else {
            cell.titleContentLabel.text = @"";
            cell.displayContentLB.text = self.displayStr;
        }
        return cell;
    } else if (indexPath.section == 1) {
        YCHReceiveAndDispatchTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:examineTextFieldID forIndexPath:indexPath];
        cell.titleLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1];
        cell.titleLabel.text = @"标题";
        cell.inputTextField.placeholder = @"请输入标题";
        [cell.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    } else {
        YCHReceiveDetailsTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiveAndDispathDetailsTextViewCellID forIndexPath:indexPath];
        cell.titleLabel.text = @"内容";
        cell.titleLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1];
        cell.recordTextView.delegate = self;
        cell.recordTextView.editable = YES;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        return CELL_HEIGHT;
    } else {
        return 200.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.requsetAssistCheckTVDelegate && [self.requsetAssistCheckTVDelegate respondsToSelector:@selector(requestAssistCheckTableViewDidSelectDepartment)]) {
                [self.requsetAssistCheckTVDelegate requestAssistCheckTableViewDidSelectDepartment];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT;
    } else {
        return 0.000001f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 20.f)];
    view.backgroundColor = UMS_TABLE_BG_COLOR;
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        YCHTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:examineFootViewID];
        footerView.backgroundColor = UMS_TABLE_BG_COLOR;
        [footerView.nextBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        [footerView.nextBtn setTitle:@"发送" forState:UIControlStateNormal];
        return footerView;
    }
    return nil;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.textView = textView;
}

- (void)textFieldDidChange:(UITextField *)textField {
    self.textField = textField;
}

- (void)sendMessage {
    if (self.requsetAssistCheckTVDelegate && [self.requsetAssistCheckTVDelegate respondsToSelector:@selector(requestAssistCheckTableViewSendMessageWithTextField:textView:)]) {
        [self.requsetAssistCheckTVDelegate requestAssistCheckTableViewSendMessageWithTextField:self.textField textView:self.textView];
    }
}

@end
