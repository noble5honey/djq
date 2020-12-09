//
//  YCHResultDisaptchTableView.m
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHResultDisaptchTableView.h"
#import "YCHBaseTableViewCell.h"
#import "YCHTableViewFooterView.h"
#import "YCHReceiveAndDispatchTextFieldCell.h"
#import "YCHReceiveDetailsTextViewTableViewCell.h"
#import "YCHDataRangeSelectTableViewCell.h"

#define BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT 112.0f;

static NSString * examineBaseCellID = @"examine_base_cell_id";
static NSString * examineFootViewID = @"examine_footView_id";
static NSString * examineTextFieldID = @"examine_textField_id";
static NSString * receiveAndDispathDetailsTextViewCellID = @"receive_and_dispatch_details_textview_cell_id";
static NSString * dateRangeSelectCellID = @"date_range_select_cell_id";

@interface YCHResultDisaptchTableView () <UITableViewDelegate, UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *selectDepartmentArray;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSString *displayStr;

@property (nonatomic, strong) UITextField *startTF;

@property (nonatomic, strong) UITextField *endTF;

@property (nonatomic, strong) NSString *displayDeductItemStr;

@property (nonatomic, assign) YCHResultDispatchTextFieldTpye textFieldTpye;

@end

@implementation YCHResultDisaptchTableView
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
        [self registerClass:[YCHDataRangeSelectTableViewCell class] forCellReuseIdentifier:dateRangeSelectCellID];
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

- (void)updateTableViewWithDeductItemTitleText:(NSString *)str {
    self.displayDeductItemStr = str;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
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
    } else if (indexPath.section == 2) {
        YCHDataRangeSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dateRangeSelectCellID forIndexPath:indexPath];
        cell.startTF.delegate = self;
        cell.endTF.delegate = self;
        self.startTF = cell.startTF;
        cell.endTF = cell.endTF;
        return cell;
    } else if (indexPath.section == 1) {
        YCHBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:examineBaseCellID forIndexPath:indexPath];
        cell.titleLabel.text = @"扣分项目";
        cell.titleContentLabel.text = @"请选择";
        cell.titleContentLabel.textColor = UMS_TEXT_FIELD_PLACEHOLDER_COLOR;
        if ([self.displayDeductItemStr isEqualToString:@""] || self.displayDeductItemStr.length == 0 || self.displayDeductItemStr == nil) {
            cell.titleContentLabel.text = @"请选择";
            cell.displayContentLB.text = @"";
        } else {
            cell.titleContentLabel.text = @"";
            cell.displayContentLB.text = self.displayDeductItemStr;
        }
        return cell;
    } else if (indexPath.section == 3) {
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
    if (indexPath.section == 4) {
        return 200.f;
    } else {
       return CELL_HEIGHT;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.requsetAssistCheckTVDelegate && [self.requsetAssistCheckTVDelegate respondsToSelector:@selector(requestAssistCheckTableViewDidSelectDepartment)]) {
                [self.requsetAssistCheckTVDelegate requestAssistCheckTableViewDidSelectDepartment];
            }
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (self.requsetAssistCheckTVDelegate && [self.requsetAssistCheckTVDelegate respondsToSelector:@selector(resultDispatchTableViewDidSelectDeductItem)]) {
                [self.requsetAssistCheckTVDelegate resultDispatchTableViewDidSelectDeductItem];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
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
    if (section == 4) {
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

#pragma mark----UITextFieldDelegate----
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.startTF) {
        self.textFieldTpye = YCHResultDispatchTextFieldTpyeStart;
        if (self.requsetAssistCheckTVDelegate && [self.requsetAssistCheckTVDelegate respondsToSelector:@selector(resultDispatchTableViewStartTextFieldEdit:textfieldType:)]) {
            [self.requsetAssistCheckTVDelegate resultDispatchTableViewStartTextFieldEdit:textField textfieldType:YCHResultDispatchTextFieldTpyeStart];
        }
    } else  {
        self.textFieldTpye = YCHResultDispatchTextFieldTpyeEnd;
        if (self.requsetAssistCheckTVDelegate && [self.requsetAssistCheckTVDelegate respondsToSelector:@selector(resultDispatchTableViewEndTextFieldEdit:textfieldType:)]) {
            [self.requsetAssistCheckTVDelegate resultDispatchTableViewEndTextFieldEdit:textField textfieldType:YCHResultDispatchTextFieldTpyeEnd];
        }
    }
}


@end
