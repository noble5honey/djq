//
//  YCHAddResultNotiTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAddResultNotiTableView.h"
#import "YCHBaseTableViewCell.h"
#import "YCHAddResultNotiDateTableViewCell.h"
#import "BJDatePickerView.h"
#import "YCHAddResultNotiTextFieldTableViewCell.h"
#import "YCHAddResultNotiTextViewTableViewCell.h"
#import "YCHTableViewFooterView.h"

static NSString * examineBaseCellID = @"examine_base_cell_id";
static NSString * addResultNotiDateCellId = @"add_result_noti_date_cell_id";
static NSString * addResultNotiTFCellId = @"add_result_noti_textField_cell_id";
static NSString * addResultNotiTVCellId = @"add_result_noti_textView_cell_id";
static NSString * examineFootViewID = @"examine_footView_id";

@interface YCHAddResultNotiTableView ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) NSString *displayStr;

@property (nonatomic, strong) BJDatePicker *datePicker;

@property (nonatomic, assign) YCHAddResultNotiTextFieldTpye textFieldType;

@property (nonatomic, strong) YCHAddResultNotiDateTableViewCell *dateCell;

@property (nonatomic, strong) YCHBaseTableViewCell *checkItemsCell;

@property (nonatomic, strong) YCHAddResultNotiTextViewTableViewCell *contentCell;

@property (nonatomic, strong) YCHAddResultNotiTextFieldTableViewCell *themeCell;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YCHAddResultNotiTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHBaseTableViewCell class] forCellReuseIdentifier:examineBaseCellID];
        [self registerClass:[YCHAddResultNotiDateTableViewCell class] forCellReuseIdentifier:addResultNotiDateCellId];
        [self registerClass:[YCHAddResultNotiTextFieldTableViewCell class] forCellReuseIdentifier:addResultNotiTFCellId];
        [self registerClass:[YCHAddResultNotiTextViewTableViewCell class] forCellReuseIdentifier:addResultNotiTVCellId];
        [self registerClass:[YCHTableViewFooterView class] forHeaderFooterViewReuseIdentifier:examineFootViewID];
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

- (void)updateTableViewCellWithDictionary:(NSDictionary *)dic indexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    self.checkItemsCell.displayContentLB.text = dic[@"matterName"];
    self.checkItemsCell.titleContentLabel.text = @"";
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.addResultNotiTVDelegate && [self.addResultNotiTVDelegate respondsToSelector:@selector(addResultNotiTableViewDidScroll)]) {
        [self.addResultNotiTVDelegate addResultNotiTableViewDidScroll];
    }
    
    [self.contentCell.contentTextView resignFirstResponder];
    [self.dateCell.dateRangeStartTF resignFirstResponder];
    [self.dateCell.dateRangeEndTF resignFirstResponder];
    [self.themeCell.contentTF resignFirstResponder];
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
        self.dateCell = [tableView dequeueReusableCellWithIdentifier:addResultNotiDateCellId forIndexPath:indexPath];
        [self.dateCell.dateRangeStartTF addTarget:self action:@selector(clickTextField:) forControlEvents:UIControlEventEditingDidBegin];
        [self.dateCell.dateRangeEndTF addTarget:self action:@selector(clickTextField:) forControlEvents:UIControlEventEditingDidBegin];
        return self.dateCell;
    } else if (indexPath.section == 2) {
        self.checkItemsCell = [tableView dequeueReusableCellWithIdentifier:examineBaseCellID forIndexPath:indexPath];
        self.checkItemsCell.titleLabel.text = @"扣分项目";
        self.checkItemsCell.titleContentLabel.text = @"请选择";
        self.checkItemsCell.titleContentLabel.textColor = UMS_TEXT_FIELD_PLACEHOLDER_COLOR;
        return self.checkItemsCell;
    } else if (indexPath.section == 3) {
        self.themeCell = [tableView dequeueReusableCellWithIdentifier:addResultNotiTFCellId forIndexPath:indexPath];
        [self.themeCell.contentTF addTarget:self action:@selector(clickThemeTextField:) forControlEvents:UIControlEventEditingChanged];
        return self.themeCell;
    } else if (indexPath.section == 4) {
        self.contentCell = [tableView dequeueReusableCellWithIdentifier:addResultNotiTVCellId forIndexPath:indexPath];
        self.contentCell.contentTextView.delegate = self;
        return self.contentCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.addResultNotiTVDelegate && [self.addResultNotiTVDelegate respondsToSelector:@selector(addResultNotiTableViewDidSelectDepartment)]) {
            [self.addResultNotiTVDelegate addResultNotiTableViewDidSelectDepartment];
        }
    } else if (indexPath.section == 2) {
        if (self.addResultNotiTVDelegate && [self.addResultNotiTVDelegate respondsToSelector:@selector(clickDeductItemCell)]) {
            [self.addResultNotiTVDelegate clickDeductItemCell];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 20.f)];
//    view.backgroundColor = UMS_TABLE_BG_COLOR;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {
        return [YCHManageDevice screenAdaptiveSizeWithIp6Size:150.f];
    }
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return 112.f;
    } else {
        return 0.000001f;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 4) {
        YCHTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:examineFootViewID];
//        footerView.backgroundColor = UMS_TABLE_BG_COLOR;
        footerView.backgroundColor = [UIColor clearColor];
        [footerView.nextBtn addTarget:self action:@selector(autoGenerate) forControlEvents:UIControlEventTouchUpInside];
        [footerView.nextBtn setTitle:@"自动生成通告内容" forState:UIControlStateNormal];
        footerView.tipsLabel.text = @"* 请在日期和扣分项目选择完毕后再点击自动生成按钮!";
        return footerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
    }
}

- (void)autoGenerate {
    if (self.addResultNotiTVDelegate && [self.addResultNotiTVDelegate respondsToSelector:@selector(addResultNotiTableViewAutoGenerateTextView:)]) {
        [self.addResultNotiTVDelegate addResultNotiTableViewAutoGenerateTextView:self.contentCell.contentTextView];
    }
}

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (self.addResultNotiTVDelegate && [self.addResultNotiTVDelegate respondsToSelector:@selector(addResultNotiTableViewTextViewDidChange:)]) {
        [self.addResultNotiTVDelegate addResultNotiTableViewTextViewDidChange:textView];
    }
}

- (void)clickTextField:(UITextField *)textField {
    if (textField == self.dateCell.dateRangeStartTF) {
        self.textFieldType = YCHAddResultNotiTextFieldTpyeStart;
        self.dateCell.dateRangeStartTF.inputView = self.datePicker;
    } else {
        self.textFieldType = YCHAddResultNotiTextFieldTpyeEnd;
        self.dateCell.dateRangeEndTF.inputView = self.datePicker;
    }
}

- (void)cancelDatePicker {
    if (self.textFieldType == YCHAddResultNotiTextFieldTpyeStart) {
        [self.dateCell.dateRangeStartTF resignFirstResponder];
    } else if (self.textFieldType == YCHAddResultNotiTextFieldTpyeEnd) {
        [self.dateCell.dateRangeEndTF resignFirstResponder];
    }
}

- (void)clickThemeTextField:(UITextField *)textField {
    if (self.addResultNotiTVDelegate && [self.addResultNotiTVDelegate respondsToSelector:@selector(clickThemeTextFieldAndChange:)]) {
        [self.addResultNotiTVDelegate clickThemeTextFieldAndChange:textField];
    }
}

- (BJDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker=[BJDatePicker shareDatePicker];
        [_datePicker.cancelBtn addTarget:self action:@selector(cancelDatePicker) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        [_datePicker datePickerDidSelected:^(NSString *date) {
            if (weakSelf.textFieldType == YCHAddResultNotiTextFieldTpyeStart) {
                weakSelf.dateCell.dateRangeStartTF.text=date;
                [weakSelf.dateCell.dateRangeStartTF resignFirstResponder];
                if (weakSelf.addResultNotiTVDelegate && [weakSelf.addResultNotiTVDelegate respondsToSelector:@selector(selectedStartDate:endDate:)]) {
                    [weakSelf.addResultNotiTVDelegate selectedStartDate:date endDate:weakSelf.dateCell.dateRangeEndTF.text];
                }
            } else if (weakSelf.textFieldType == YCHAddResultNotiTextFieldTpyeEnd) {
                weakSelf.dateCell.dateRangeEndTF.text=date;
                [weakSelf.dateCell.dateRangeEndTF resignFirstResponder];
                if (weakSelf.addResultNotiTVDelegate && [weakSelf.addResultNotiTVDelegate respondsToSelector:@selector(selectedStartDate:endDate:)]) {
                    [weakSelf.addResultNotiTVDelegate selectedStartDate:weakSelf.dateCell.dateRangeStartTF.text endDate:date];
                }
            }
        }];
    }
    return _datePicker;
}

@end
