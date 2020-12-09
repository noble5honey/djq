//
//  YCHResultDispatchViewController.m
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHResultDispatchViewController.h"
#import "YCHResultDisaptchTableView.h"
#import "YCHDepartmentSelectViewController.h"
#import "BJDatePickerView.h"
#import "YCHDeductItemViewController.h"

@interface YCHResultDispatchViewController () <YCHRequestAssistCheckTableViewDelegate>

@property (nonatomic, assign) BOOL isSendSuccess;

@property (nonatomic, strong) NSArray *itemArry;

@property (nonatomic, strong) NSArray *departmentResultArray;

@property (nonatomic, strong) YCHResultDisaptchTableView *resultDispatchTV;

@property (nonatomic, strong) BJDatePicker *datePicker;

@property (nonatomic, assign) YCHResultDispatchTextFieldTpye textFieldTpye;

@property (nonatomic, strong) UITextField *startTF;

@property (nonatomic, strong) UITextField *endTF;

@property (nonatomic, strong) NSString *deductItemStr;

@end

@implementation YCHResultDispatchViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationBar];
    [self initSubViews];
    self.itemArry = @[@{@"departmentName" : @"审计局", @"departmentKey" : @"001"},
                      @{@"departmentName" : @"审批局", @"departmentKey" : @"002"},
                      @{@"departmentName" : @"人社局", @"departmentKey" : @"003"},
                      @{@"departmentName" : @"外设局", @"departmentKey" : @"004"},
                      @{@"departmentName" : @"接待办", @"departmentKey" : @"005"},
                      @{@"departmentName" : @"审批局", @"departmentKey" : @"006"},
                      @{@"departmentName" : @"百度", @"departmentKey" : @"007"},
                      @{@"departmentName" : @"阿里巴巴阿里巴巴阿里巴巴阿里巴巴", @"departmentKey" : @"008"},
                      @{@"departmentName" : @"京东", @"departmentKey" : @"009"},
                      @{@"departmentName" : @"腾讯", @"departmentKey" : @"010"},
                      @{@"departmentName" : @"饿了么", @"departmentKey" : @"011"},
                      @{@"departmentName" : @"美团", @"departmentKey" : @"012"},
                      @{@"departmentName" : @"滴滴", @"departmentKey" : @"013"}];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_NAV_BACKGROUND_COLOR titleColor:UMS_TEXT_BLACK backgroundColor:UMS_NAV_BACKGROUND_COLOR needBottomLine:NO needTranslucent:NO];
}

- (void)back {
    if (self.blockparameter) {
        self.blockparameter(self.isSendSuccess);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)updateNavigationBar {
    self.title = @"结果通告";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)initSubViews {
    [self.resultDispatchTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (YCHResultDisaptchTableView *)resultDispatchTV {
    if (!_resultDispatchTV) {
        _resultDispatchTV = [[YCHResultDisaptchTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _resultDispatchTV.requsetAssistCheckTVDelegate = self;
        [self.view addSubview:_resultDispatchTV];
    }
    return _resultDispatchTV;
}

#pragma -mark YCHRequestAssistCheckTableViewDelegate
- (void)requestAssistCheckTableViewSendMessageWithTextField:(UITextField *)textField textView:(UITextView *)textView {
    //请求成功
    if (self.departmentResultArray.count == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请选择接收部门"];
        return;
    } else if (self.deductItemStr.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请选择扣分项目"];
        return;
    } else if ([textField.text isEqualToString:@""] || textField.text.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请输入标题"];
        return;
    } else if ([textView.text isEqualToString:@""] || textView.text.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请输入内容"];
        return;
    }
    
    
    self.isSendSuccess = YES;
    [self back];
}

- (void)requestAssistCheckTableViewDidSelectDepartment {
    YCHDepartmentSelectViewController *vc = [[YCHDepartmentSelectViewController alloc] initWithNibName:nil bundle:nil itemArray:self.itemArry selectArray:self.departmentResultArray];
    vc.departmentResultblock = ^(NSArray *departmentReusltArray) {
        self.departmentResultArray = departmentReusltArray;
        [self updateCellWithDisplaySelectDepartment:departmentReusltArray];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)resultDispatchTableViewDidSelectDeductItem {
    YCHDeductItemViewController *vc = [[YCHDeductItemViewController alloc] initWithNibName:nil bundle:nil itemArray:self.itemArry selectArray:nil];
    vc.deductItemStrblock = ^(NSString * _Nonnull deductItemStr) {
        [self.resultDispatchTV updateTableViewWithDeductItemTitleText:deductItemStr];
        self.deductItemStr = deductItemStr;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateCellWithDisplaySelectDepartment:(NSArray *)itemArray {
    NSString *resultStr = @"";
    for (int i = 0; i < itemArray.count; i++) {
        resultStr = [resultStr stringByAppendingString:itemArray[i][@"departmentName"]];
        resultStr = [resultStr stringByAppendingString:@"、"];
    }
    [self.resultDispatchTV updateTableViewWithDisplaySelectDepartment:resultStr];
}

#pragma mark----UITextFieldDelegate----
- (void)resultDispatchTableViewStartTextFieldEdit:(UITextField *)textField textfieldType:(YCHResultDispatchTextFieldTpye)textfieldType {
    textField.inputView = self.datePicker;
    self.textFieldTpye = textfieldType;
    self.startTF = textField;
}

- (void)resultDispatchTableViewEndTextFieldEdit:(UITextField *)textField textfieldType:(YCHResultDispatchTextFieldTpye)textfieldType {
    textField.inputView = self.datePicker;
    self.textFieldTpye = textfieldType;
    self.endTF = textField;
}

- (void)cancelDatePicker {
    if (self.textFieldTpye == YCHResultDispatchTextFieldTpyeStart) {
        [self.startTF resignFirstResponder];
    } else {
        [self.endTF resignFirstResponder];
    }
}

-(BJDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker=[BJDatePicker shareDatePicker];
        [_datePicker.cancelBtn addTarget:self action:@selector(cancelDatePicker) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        [_datePicker datePickerDidSelected:^(NSString *date) {
            if (weakSelf.textFieldTpye == YCHResultDispatchTextFieldTpyeStart) {
                weakSelf.startTF.text=date;
                [weakSelf.startTF resignFirstResponder];
                NSLog(@"起始时间：%@",date);
            } else if (weakSelf.textFieldTpye == YCHHomePageTextFieldTpyeFirstPageEnd) {
                weakSelf.endTF.text=date;
                [weakSelf.endTF resignFirstResponder];
                NSLog(@"截止时间：%@",date);
            }
        }];
    }
    return _datePicker;
}


@end
