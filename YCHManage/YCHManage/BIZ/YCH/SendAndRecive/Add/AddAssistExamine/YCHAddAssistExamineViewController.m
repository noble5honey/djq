//
//  YCHAddAssistExamineViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAddAssistExamineViewController.h"
#import "YCHAddAssistExamineTableView.h"
#import "YCHDepartmentSelectViewController.h"
#import "BJDatePickerView.h"

@interface YCHAddAssistExamineViewController ()<YCHAddAssistExamineTableViewDelegate>

@property (nonatomic, strong) YCHAddAssistExamineTableView *addAssistExamineTV;

@property (nonatomic, strong) NSMutableArray *itemArry;

@property (nonatomic, strong) NSArray *departmentResultArray;

@property (nonatomic, strong) NSString *themeStr;

@property (nonatomic, strong) NSString *contentStr;

@property (nonatomic, strong) BJDatePicker *datePicker;

@property (nonatomic, strong) UITextField *dateTextField;

@end

@implementation YCHAddAssistExamineViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nil bundle:nil]) {
        [self updateNavigationBar];
        [self initSubViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self queryDepartmentList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_NAV_BACKGROUND_COLOR titleColor:UMS_TEXT_BLACK backgroundColor:UMS_NAV_BACKGROUND_COLOR needBottomLine:NO needTranslucent:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)updateNavigationBar {
    self.title = @"新增协检";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow_grey"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    [sendButton setTintColor:UMS_THEME_COLOR];
    [sendButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont ChinaDefaultFontNameOfSize:14.0],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = sendButton;
}

- (void)initSubViews {
    [self.addAssistExamineTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)queryDepartmentList {
    
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"parentCode"] = @"gov";
    [[ZBNetworking shaerdInstance] getWithUrl:YCH_role_query_Server cache:nil params:nil progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        self.itemArry = response[@"data"];
    } failBlock:^(NSError *error) {
    }];
}

#pragma -mark YCHAddAssistExamineTableViewDelegate
- (void)addAssistExamineTableViewDidSelectDepartment {
    YCHDepartmentSelectViewController *vc = [[YCHDepartmentSelectViewController alloc] initWithNibName:nil bundle:nil itemArray:self.itemArry selectArray:self.departmentResultArray];
    vc.departmentResultblock = ^(NSArray *departmentReusltArray) {
        self.departmentResultArray = departmentReusltArray;
        [self updateCellWithDisplaySelectDepartment:departmentReusltArray];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addAssistExamineTableViewTextFieldBeginEditing:(UITextField *)textField {
    self.dateTextField = textField;
    textField.inputView = self.datePicker;
}

- (void)updateCellWithDisplaySelectDepartment:(NSArray *)itemArray {
    NSString *resultStr = @"";
    for (int i = 0; i < itemArray.count; i++) {
        resultStr = [resultStr stringByAppendingString:itemArray[i][@"roleName"]];
        resultStr = [resultStr stringByAppendingString:@"、"];
    }
    [self.addAssistExamineTV updateTableViewWithDisplaySelectDepartment:resultStr];
}

- (void)clickThemeTextFieldAndChange:(UITextField *)textField {
    self.themeStr = textField.text;
    NSLog(@"%@",textField.text);
}

- (void)addAssistExamineTableViewTextViewDidChange:(UITextView *)textView {
    self.contentStr = textView.text;
    NSLog(@"%@",textView.text);
}

- (void)send {
    if (self.departmentResultArray == nil) {
        [YCHManagerToast showToastToView:self.view text:@"请选择收件人"];
        return;
    }
    if (self.themeStr.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请填写标题"];
        return;
    }
    if (self.dateTextField.text.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请选择协检日期"];
        return;
    }
    if (self.contentStr.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请填写内容"];
        return;
    }
//    "help": {
//            "topic": "明天一起去检查",
//            "body": "好不好",
//            "checkDate": "1606147200000"
//        },
//        "receiveCodes": "[\"sjj\",\"lgb\"]"
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *helpDict = [NSMutableDictionary dictionary];
    helpDict[@"topic"] = self.themeStr;
    helpDict[@"body"] = self.contentStr;
    helpDict[@"checkDate"] = [NSString timeSwitchTimestamp:self.dateTextField.text andFormatter:@"YYYY-MM-dd"];
    NSMutableArray *receive = [NSMutableArray array];
    for (int i = 0; i < self.departmentResultArray.count; i++) {
        [receive addObject:self.departmentResultArray[i][@"roleKey"]];
    }
    helpDict[@"receiveCodes"] = receive;
    temParamDict[@"help"] = helpDict;
    [YCHManageLodingActivity showLoadingActivityInView:self.view];
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_assistCheck_add_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        [YCHManagerToast showToastToView:self.view text:@"发送成功" time:1.5 completion:^{
            if (self.assistEximeViewControllerBlock) {
                self.assistEximeViewControllerBlock(YES);
                [self back];
            }
        }];
    } failBlock:^(NSError *error) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        NSString *errorStr = [NSString stringWithFormat:@"%@",error];
        [YCHManagerToast showToastToView:self.view text:errorStr time:1.5 completion:^{
            if (self.assistEximeViewControllerBlock) {
                self.assistEximeViewControllerBlock(NO);
                [self back];
            }
        }];
    }];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelDatePicker {
    [self.dateTextField resignFirstResponder];
}

- (YCHAddAssistExamineTableView *)addAssistExamineTV {
    if (!_addAssistExamineTV) {
        _addAssistExamineTV = [[YCHAddAssistExamineTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _addAssistExamineTV.addAssistExamineTVDelegate = self;
        [self.view addSubview:_addAssistExamineTV];
    }
    return _addAssistExamineTV;
}

- (BJDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker=[BJDatePicker datePicker];
        [_datePicker.cancelBtn addTarget:self action:@selector(cancelDatePicker) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        _datePicker.minimumDate = [NSDate date];
        [_datePicker datePickerDidSelected:^(NSString *date) {
            weakSelf.dateTextField.text = date;
            [weakSelf.dateTextField resignFirstResponder];
        }];
    }
    return _datePicker;
}

@end
