//
//  YCHAddAssistExamineTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAddAssistExamineTableView.h"
#import "YCHBaseTableViewCell.h"
#import "YCHAddResultNotiTextFieldTableViewCell.h"
#import "YCHAddResultNotiTextViewTableViewCell.h"
#import "YCHReceiveAndDispatchTextFieldCell.h"

static NSString * examineBaseCellID = @"examine_base_cell_id";
static NSString * addResultNotiTFCellId = @"add_result_noti_textField_cell_id";
static NSString * addResultNotiTVCellId = @"add_result_noti_textView_cell_id";
static NSString * textFileCellID = @"textField_cell_id";

@interface YCHAddAssistExamineTableView ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) NSString *displayStr;

@property (nonatomic, strong) YCHAddResultNotiTextFieldTableViewCell *themeCell;

@property (nonatomic, strong) YCHAddResultNotiTextViewTableViewCell *contentCell;

@property (nonatomic, strong) YCHReceiveAndDispatchTextFieldCell *dateCell;

@end

@implementation YCHAddAssistExamineTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHBaseTableViewCell class] forCellReuseIdentifier:examineBaseCellID];
        [self registerClass:[YCHAddResultNotiTextFieldTableViewCell class] forCellReuseIdentifier:addResultNotiTFCellId];
        [self registerClass:[YCHAddResultNotiTextViewTableViewCell class] forCellReuseIdentifier:addResultNotiTVCellId];
        [self registerClass:[YCHReceiveAndDispatchTextFieldCell class] forCellReuseIdentifier:textFileCellID];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.themeCell.contentTF resignFirstResponder];
    [self.contentCell.contentTextView resignFirstResponder];
    [self.dateCell.inputTextField resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YCHBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:examineBaseCellID forIndexPath:indexPath];
        cell.titleLabel.text = @"收件人";
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
        self.themeCell = [tableView dequeueReusableCellWithIdentifier:addResultNotiTFCellId forIndexPath:indexPath];
        [self.themeCell.contentTF addTarget:self action:@selector(clickThemeTextField:) forControlEvents:UIControlEventEditingChanged];
        return self.themeCell;
    } else if (indexPath.section == 2) {
        self.dateCell = [tableView dequeueReusableCellWithIdentifier:textFileCellID forIndexPath:indexPath];
        self.dateCell.titleLabel.text = @"协检日期";
        self.dateCell.titleLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1];
        self.dateCell.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        [self.dateCell.inputTextField addTarget:self action:@selector(inputTextFieldBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
//        cell.inputTextField.placeholder = @"请选择一个协同检查日期";
        self.dateCell.inputTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请选择一个协同检查日期" attributes:@{NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f],NSForegroundColorAttributeName:UMS_GRAY_150}];
        return self.dateCell;
    } else if (indexPath.section == 3) {
        self.contentCell = [tableView dequeueReusableCellWithIdentifier:addResultNotiTVCellId forIndexPath:indexPath];
        self.contentCell.contentTextView.delegate = self;
        return self.contentCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.addAssistExamineTVDelegate && [self.addAssistExamineTVDelegate respondsToSelector:@selector(addAssistExamineTableViewDidSelectDepartment)]) {
            [self.addAssistExamineTVDelegate addAssistExamineTableViewDidSelectDepartment];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return [YCHManageDevice screenAdaptiveSizeWithIp6Size:150.f];
    }
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 20.f)];
    view.backgroundColor = UMS_TABLE_BG_COLOR;
    return view;
}

- (void)clickThemeTextField:(UITextField *)textField {
    if (self.addAssistExamineTVDelegate && [self.addAssistExamineTVDelegate respondsToSelector:@selector(clickThemeTextFieldAndChange:)]) {
        [self.addAssistExamineTVDelegate clickThemeTextFieldAndChange:textField];
    }
}

- (void)inputTextFieldBeginEditing:(UITextField *)textField {
    if (self.addAssistExamineTVDelegate && [self.addAssistExamineTVDelegate respondsToSelector:@selector(addAssistExamineTableViewTextFieldBeginEditing:)]) {
        [self.addAssistExamineTVDelegate addAssistExamineTableViewTextFieldBeginEditing:textField];
    }
}

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (self.addAssistExamineTVDelegate && [self.addAssistExamineTVDelegate respondsToSelector:@selector(addAssistExamineTableViewTextViewDidChange:)]) {
        [self.addAssistExamineTVDelegate addAssistExamineTableViewTextViewDidChange:textView];
    }
}


@end
