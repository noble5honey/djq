//
//  YCHDepartmentSelectViewController.m
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHDepartmentSelectViewController.h"
#import "YCHReceiveDepartmentTableView.h"

@interface YCHDepartmentSelectViewController () <YCHReceiveDepartmentTableViewDelegate>

@property (nonatomic, strong) YCHReceiveDepartmentTableView *selectDepartmentTV;

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) NSArray *resultDepartmentArray;

@end

@implementation YCHDepartmentSelectViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil itemArray:(NSArray *)itemArray selectArray:(NSArray *)selectArray {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.itemArray = itemArray;
        if (selectArray.count > 0) {
            self.resultDepartmentArray = selectArray;
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationBar];
    [self initSubViews];
    [self.selectDepartmentTV updateTableViewWithItemArray:self.itemArray selectArray:self.resultDepartmentArray];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_NAV_BACKGROUND_COLOR titleColor:UMS_TEXT_BLACK backgroundColor:UMS_NAV_BACKGROUND_COLOR needBottomLine:NO needTranslucent:NO];
}

- (void)updateNavigationBar {
    self.title = @"选择部门";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
    rightBarButtonItem.tintColor = UMS_THEME_COLOR;
    [rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont UMSDefaultFontOfSize:15]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)initSubViews {
    [self.selectDepartmentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma -mark YCHReceiveDepartmentTableViewDelegate
- (void)receiveDepartmentTableViewSelectDepartmentResultItemArray:(NSArray *)resultItemArray {
    self.resultDepartmentArray = resultItemArray;
}

- (YCHReceiveDepartmentTableView *)selectDepartmentTV {
    if (!_selectDepartmentTV) {
        _selectDepartmentTV = [[YCHReceiveDepartmentTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _selectDepartmentTV.receiveDepartmentTVDelegate = self;
        [self.view addSubview:_selectDepartmentTV];
    }
    return _selectDepartmentTV;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)confirm {
    if (self.departmentResultblock) {
        self.departmentResultblock(self.resultDepartmentArray);
        [self back];
    }
}

@end
