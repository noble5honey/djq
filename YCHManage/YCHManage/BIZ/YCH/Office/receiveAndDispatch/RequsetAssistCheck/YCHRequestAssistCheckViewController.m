//
//  YCHRequestAssistCheckViewController.m
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHRequestAssistCheckViewController.h"
#import "YCHRequestAssistCheckTableView.h"
#import "YCHDepartmentSelectViewController.h"

@interface YCHRequestAssistCheckViewController () <YCHRequestAssistCheckTableViewDelegate>

@property (nonatomic, strong) YCHRequestAssistCheckTableView *requestAssistCheckTableView;

@property (nonatomic, assign) BOOL isSendSuccess;

@property (nonatomic, strong) NSArray *itemArry;

@property (nonatomic, strong) NSArray *departmentResultArray;

@end

@implementation YCHRequestAssistCheckViewController
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

- (void)updateNavigationBar {
    self.title = @"要求协检";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)initSubViews {
    [self.requestAssistCheckTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)back {
    if (self.blockparameter) {
        self.blockparameter(self.isSendSuccess);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (YCHRequestAssistCheckTableView *)requestAssistCheckTableView {
    if (!_requestAssistCheckTableView) {
        _requestAssistCheckTableView = [[YCHRequestAssistCheckTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _requestAssistCheckTableView.requsetAssistCheckTVDelegate = self;
        [self.view addSubview:_requestAssistCheckTableView];
    }
    return _requestAssistCheckTableView;
}

#pragma -mark YCHRequestAssistCheckTableViewDelegate
- (void)requestAssistCheckTableViewSendMessageWithTextField:(UITextField *)textField textView:(UITextView *)textView {
    //请求成功
    if (self.departmentResultArray.count == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请选择接收部门"];
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

- (void)updateCellWithDisplaySelectDepartment:(NSArray *)itemArray {
    NSString *resultStr = @"";
    for (int i = 0; i < itemArray.count; i++) {
        resultStr = [resultStr stringByAppendingString:itemArray[i][@"departmentName"]];
        resultStr = [resultStr stringByAppendingString:@"、"];
    }
    [self.requestAssistCheckTableView updateTableViewWithDisplaySelectDepartment:resultStr];
}

@end
