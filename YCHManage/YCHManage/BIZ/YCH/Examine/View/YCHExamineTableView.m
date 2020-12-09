//
//  YCHExamineTableView.m
//  YCHManage
//
//  Created by sunny on 2020/6/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHExamineTableView.h"
#import "YCHTableViewFooterView.h"
#import "YCHReceiveAndDispatchTextFieldCell.h"

#define BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT 112.0f;

static NSString * examineBaseCellID = @"examine_base_cell_id";
static NSString * examineUploadCellID = @"examine_upload_cell_id";
static NSString * examineFootViewID = @"examine_footView_id";
static NSString * textFileCellID = @"textField_cell_id";

@interface YCHExamineTableView () <UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) YCHExamineTableViewCell *cell;

@property (nonatomic, strong) YCHBaseTableViewCell *firstCell;

@property (nonatomic, strong) YCHBaseTableViewCell *secondCell;

@property (nonatomic, strong) YCHReceiveAndDispatchTextFieldCell *textFieldCell;

@property (nonatomic, strong) NSString *limitText;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation YCHExamineTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHBaseTableViewCell class] forCellReuseIdentifier:examineBaseCellID];
        [self registerClass:[YCHExamineTableViewCell class] forCellReuseIdentifier:examineUploadCellID];
        [self registerClass:[YCHTableViewFooterView class] forHeaderFooterViewReuseIdentifier:examineFootViewID];
        [self registerClass:[YCHReceiveAndDispatchTextFieldCell class] forCellReuseIdentifier:textFileCellID];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

- (void)updateTableViewCellWithDictionary:(NSDictionary *)dic {
    //[1]    (null)    @"matterCode" : @"noMatterScore"
    NSString *matterCode = [NSString stringWithFormat:@"%@",dic[@"matterCode"]];
    NSString *scoreStr = [NSString stringWithFormat:@"%@",dic[@"matterScore"]];
    self.secondCell.titleContentLabel.text = scoreStr;
    self.firstCell.displayContentLB.text = dic[@"matterName"];
    self.firstCell.titleContentLabel.text = @"";
    if ([matterCode isEqual:@"noMatterScore"]) {
        self.textFieldCell.inputTextField.enabled = NO;
        self.textFieldCell.inputTextField.text = @"";
    } else {
        self.textFieldCell.inputTextField.enabled = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.firstCell = [tableView dequeueReusableCellWithIdentifier:examineBaseCellID forIndexPath:indexPath];
        self.firstCell.titleLabel.text = @"扣分项目";
        self.firstCell.titleContentLabel.text = @"请选择";
        self.firstCell.titleContentLabel.textColor = UMS_TEXT_FIELD_PLACEHOLDER_COLOR;
        return self.firstCell;
    } else if (indexPath.section == 1) {
        self.secondCell = [tableView dequeueReusableCellWithIdentifier:examineBaseCellID forIndexPath:indexPath];
        self.secondCell.titleLabel.text = @"扣除分数";
//        cell.titleContentLabel.text = @"请选择";
        self.secondCell.titleContentLabel.textColor = UMS_TEXT_FIELD_PLACEHOLDER_COLOR;
        self.secondCell.arrowImageView.hidden = YES;
        return self.secondCell;
    } else if (indexPath.section == 2) {
        self.textFieldCell = [tableView dequeueReusableCellWithIdentifier:textFileCellID forIndexPath:indexPath];
        self.textFieldCell.titleLabel.text = @"整改期限";
        self.textFieldCell.titleLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1];
        self.textFieldCell.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        self.textFieldCell.inputTextField.placeholder = @"请输入整改期限 单位:天";
        self.textFieldCell.inputTextField.keyboardType = UIKeyboardTypePhonePad;
        [self.textFieldCell.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.textFieldCell.inputTextField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
        return self.textFieldCell;
    } else if (indexPath.section == 3) {
        self.cell = [tableView dequeueReusableCellWithIdentifier:examineUploadCellID forIndexPath:indexPath];
        [self.cell.addButton addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
        self.cell.addButton.tag = 1001;
        [self.cell.secondButton addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
        self.cell.secondButton.tag = 1002;
        [self.cell.thirdButton addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
        self.cell.thirdButton.tag = 1003;
        self.cell.recordTextView.delegate = self;
        return  self.cell;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.cell.recordTextView) {
        return;
    }
    [self.cell.recordTextView resignFirstResponder];
    [self.textFieldCell.inputTextField resignFirstResponder];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.cell.recordTextView resignFirstResponder];
//}

- (void)uploadImage:(UIButton *)btn {
    if (btn.tag == 1001) {
        if (self.examineDelegate && [self.examineDelegate respondsToSelector:@selector(addImageActionWithCell:)]) {
            [self.examineDelegate addImageActionWithCell:self.cell];
        }
    } else if (btn.tag == 1002) {
        if (self.examineDelegate && [self.examineDelegate respondsToSelector:@selector(exmineTableViewClickSecondButtonWithCell:)]) {
            [self.examineDelegate exmineTableViewClickSecondButtonWithCell:self.cell];
        }
    } else {
        if (self.examineDelegate && [self.examineDelegate respondsToSelector:@selector(exmineTableViewClickThirdButtonWithCell:)]) {
            [self.examineDelegate exmineTableViewClickThirdButtonWithCell:self.cell];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
      return CELL_HEIGHT;
    } else {
      return 240.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            YCHBaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//            if (self.examineDelegate && [self.examineDelegate respondsToSelector:@selector(tableViewDidSelectRow:)]) {
//                [self.examineDelegate tableViewDidSelectRow:cell];
//            }
            if (self.examineDelegate && [self.examineDelegate respondsToSelector:@selector(exmineTableViewClickDeductItemCell)]) {
                [self.examineDelegate exmineTableViewClickDeductItemCell];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
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
    if (section == 3) {
        YCHTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:examineFootViewID];
        footerView.backgroundColor = UMS_TABLE_BG_COLOR;
        [footerView.nextBtn addTarget:self action:@selector(clickCommitButton) forControlEvents:UIControlEventTouchUpInside];
        [footerView.nextBtn setTitle:@"提交" forState:UIControlStateNormal];
        return footerView;
    }
    return nil;
}

- (void)clickCommitButton {
    if (self.examineDelegate && [self.examineDelegate respondsToSelector:@selector(examineTableViewClickCommitButton)]) {
        [self.examineDelegate examineTableViewClickCommitButton];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    self.textField = textField;
    if (self.examineDelegate && [self.examineDelegate respondsToSelector:@selector(examineTableViewTextFieldDidChange:)]) {
        [self.examineDelegate examineTableViewTextFieldDidChange:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    long inputNum = [textField.text longLongValue];
    if (inputNum < 1) {
        textField.text = @"";
        [YCHManagerToast showToastToView:self text:@"整改期限不能为0"];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    UITextRange *markRange = textView.markedTextRange;
    NSInteger pos = [textView offsetFromPosition:markRange.start
                                 toPosition:markRange.end];
    NSInteger nLength = textView.text.length - pos;
    if (nLength > 150 && pos == 0) {
        self.cell.recordTextView.text = self.limitText;
    } else {
        self.cell.tagLabel.text = [NSString stringWithFormat:@"%ld/150",(long)nLength];
//        self.cell.tagLabel.text = [NSString stringWithFormat:@"%ld/150",textView.text.length];
        self.limitText = textView.text;
    }
//    if (textView.markedTextRange == nil) {
//        if (textView.text.length > 155) {
//            textView.text = [textView.text substringToIndex:150];
//        }
//    }
    
    if (self.examineDelegate && [self.examineDelegate respondsToSelector:@selector(examineTableViewTextViewDidChange:)]) {
        [self.examineDelegate examineTableViewTextViewDidChange:textView];
    }
}

@end
