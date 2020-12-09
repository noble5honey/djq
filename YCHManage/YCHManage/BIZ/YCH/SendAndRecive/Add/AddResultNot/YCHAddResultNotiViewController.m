//
//  YCHAddResultNotiViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAddResultNotiViewController.h"
#import "YCHAddResultNotiTableView.h"
#import "YCHDepartmentSelectViewController.h"
#import "YCHExamineDeductItemViewController.h"

@interface YCHAddResultNotiViewController ()<YCHAddResultNotiTableViewDelegate>

@property (nonatomic, strong) NSMutableArray *itemArry;

@property (nonatomic, strong) NSArray *departmentResultArray;

@property (nonatomic, strong) NSString *startDateStr;

@property (nonatomic, strong) NSString *endDateStr;

@property (nonatomic, strong) YCHAddResultNotiTableView *addResultNotiTV;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSDictionary *deductItemDic;

@property (nonatomic, strong) NSString *themeStr;

@property (nonatomic, strong) UITextView *contentTV;

@end

@implementation YCHAddResultNotiViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nil bundle:nil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateNavigationBar];
    [self initSubViews];
    [self queryDepartmentList];
//    self.itemArry = @[@{@"departmentName" : @"审计局", @"departmentKey" : @"001"},
//                      @{@"departmentName" : @"审批局", @"departmentKey" : @"002"},
//                      @{@"departmentName" : @"人社局", @"departmentKey" : @"003"},
//                      @{@"departmentName" : @"外设局", @"departmentKey" : @"004"},
//                      @{@"departmentName" : @"接待办", @"departmentKey" : @"005"},
//                      @{@"departmentName" : @"审批局", @"departmentKey" : @"006"},
//                      @{@"departmentName" : @"百度", @"departmentKey" : @"007"},
//                      @{@"departmentName" : @"阿里巴巴阿里巴巴阿里巴巴阿里巴巴", @"departmentKey" : @"008"},
//                      @{@"departmentName" : @"京东", @"departmentKey" : @"009"},
//                      @{@"departmentName" : @"腾讯", @"departmentKey" : @"010"},
//                      @{@"departmentName" : @"饿了么", @"departmentKey" : @"011"},
//                      @{@"departmentName" : @"美团", @"departmentKey" : @"012"},
//                      @{@"departmentName" : @"滴滴", @"departmentKey" : @"013"}];
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

- (void)queryDepartmentList {
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"parentCode"] = @"gov";
    [[ZBNetworking shaerdInstance] getWithUrl:YCH_role_query_Server cache:nil params:nil progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        self.itemArry = response[@"data"];
    } failBlock:^(NSError *error) {
    }];
}

- (void)updateNavigationBar {
    self.title = @"新增通告";
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    [sendButton setTintColor:UMS_THEME_COLOR];
    [sendButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont ChinaDefaultFontNameOfSize:14.0],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = sendButton;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow_grey"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)initSubViews {
    [self.addResultNotiTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma -mark YCHAddResultNotiTableViewDelegate
- (void)addResultNotiTableViewDidSelectDepartment {
    YCHDepartmentSelectViewController *vc = [[YCHDepartmentSelectViewController alloc] initWithNibName:nil bundle:nil itemArray:self.itemArry selectArray:self.departmentResultArray];
    vc.departmentResultblock = ^(NSArray *departmentReusltArray) {
        self.departmentResultArray = departmentReusltArray;
        [self updateCellWithDisplaySelectDepartment:departmentReusltArray];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectedStartDate:(NSString *)startDate endDate:(NSString *)endDate {
    self.startDateStr = startDate;
    self.endDateStr = endDate;
    NSLog(@"起始日期：%@-----截止日期：%@",self.startDateStr,self.endDateStr);
}

- (void)clickDeductItemCell {
    YCHExamineDeductItemViewController *vc = [[YCHExamineDeductItemViewController alloc] initWithNibName:nil bundle:nil indexPath:self.indexPath];
    vc.isCheckNoti = YES;
    vc.blockparameter = ^(NSDictionary *selectedDic,NSIndexPath *indexPath) {
        self.indexPath = indexPath;
        self.deductItemDic = selectedDic;
        // @{@"itemName" : @"有无干手设备或擦手纸巾", @"itemKey" : @"012", @"grades" : @"1"}
        [self.addResultNotiTV updateTableViewCellWithDictionary:selectedDic indexPath:indexPath];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addResultNotiTableViewDidScroll {
}

- (void)clickThemeTextFieldAndChange:(UITextField *)textField {
    self.themeStr = textField.text;
    NSLog(@"%@",textField.text);
}

- (void)addResultNotiTableViewTextViewDidChange:(UITextView *)textView {
    self.contentTV = textView;
    NSLog(@"%@",textView.text);
}

- (void)addResultNotiTableViewAutoGenerateTextView:(UITextView *)textView {
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    if (self.deductItemDic == nil) {
        [YCHManagerToast showToastToView:self.view text:@"请选择扣分项目"];
        return;
    }
    if ([self.startDateStr isEqual: @""]) {
        [YCHManagerToast showToastToView:self.view text:@"请选择起始日期"];
        return;
    }
    if ([self.endDateStr isEqualToString:@""]) {
        [YCHManagerToast showToastToView:self.view text:@"请选择截止日期"];
    }
    [YCHManageLodingActivity showLoadingActivityInView:self.view];
    
    temParamDict[@"matterCode"] = self.deductItemDic[@"matterCode"];
//    temParamDict[@"startDay"] = [NSString timeSwitchTimestamp:self.startDateStr andFormatter:@"YYYY-MM-dd"];
    temParamDict[@"startDay"] = self.startDateStr;

//    temParamDict[@"endDay"] = [NSString timeSwitchTimestamp:self.endDateStr andFormatter:@"YYYY-MM-dd"];
    temParamDict[@"endDay"] = self.endDateStr;
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_Auto_generate_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
        
    } successBlock:^(id response) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        NSString *contentStr = [NSString stringWithFormat:@"%@",response[@"data"][@"body"]];
        if ([contentStr isEqualToString:@""]) {
            [YCHManagerToast showToastToView:self.view text:@"没有相关记录"];
        } else {
            textView.text = contentStr;
            self.contentTV = textView;
        }
    } failBlock:^(NSError *error) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
    }];
}

- (void)updateCellWithDisplaySelectDepartment:(NSArray *)itemArray {
    NSString *resultStr = @"";
    for (int i = 0; i < itemArray.count; i++) {
        resultStr = [resultStr stringByAppendingString:itemArray[i][@"roleName"]];
        resultStr = [resultStr stringByAppendingString:@"、"];
    }
    [self.addResultNotiTV updateTableViewWithDisplaySelectDepartment:resultStr];
}

- (void)send {
    if (self.themeStr.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请填写标题"];
        return;
    }
    if (self.departmentResultArray == nil) {
        [YCHManagerToast showToastToView:self.view text:@"请选择收件人"];
        return;
    }
    if (self.contentTV.text.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请填写内容"];
        return;
    }
    [YCHManageLodingActivity showLoadingActivityInView:self.view];
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *outcome = [NSMutableDictionary dictionary];
    NSMutableArray *receive = [NSMutableArray array];
    for (int i = 0; i < self.departmentResultArray.count; i++) {
        [receive addObject:self.departmentResultArray[i][@"roleKey"]];
    }
    outcome[@"topic"] = self.themeStr;
    outcome[@"body"] = self.contentTV.text;
    outcome[@"receiveCodes"] = receive;
    temParamDict[@"outcome"] = outcome;
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_ResultNoti_add_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        [YCHManagerToast showToastToView:self.view text:@"发送成功" time:1.5 completion:^{
            if (self.addResultNotiViewControllerBlock) {
                self.addResultNotiViewControllerBlock(YES);
                [self back];
            }
        }];
    } failBlock:^(NSError *error) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        NSString *errorStr = [NSString stringWithFormat:@"%@",error];
        [YCHManagerToast showToastToView:self.view text:errorStr time:1.5 completion:^{
            if (self.addResultNotiViewControllerBlock) {
                self.addResultNotiViewControllerBlock(NO);
                [self back];
            }
        }];
    }];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (YCHAddResultNotiTableView *)addResultNotiTV {
    if (!_addResultNotiTV) {
        _addResultNotiTV = [[YCHAddResultNotiTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _addResultNotiTV.addResultNotiTVDelegate = self;
        [self.view addSubview:_addResultNotiTV];
    }
    return _addResultNotiTV;
}

@end
