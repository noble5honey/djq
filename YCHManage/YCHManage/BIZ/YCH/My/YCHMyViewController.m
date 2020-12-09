//
//  YCHMyViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/11.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHMyViewController.h"
#import "YCHMyTableView.h"

@interface YCHMyViewController () <YCHMyTableViewDelegate>

@property (nonatomic, strong) YCHMyTableView *myTableView;

@end

@implementation YCHMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateNavigationBar];
    [self setUpConstrains];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_THEME_COLOR titleColor:nil backgroundColor:UMS_THEME_COLOR needBottomLine:NO needTranslucent:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_THEME_COLOR titleColor:nil backgroundColor:UMS_THEME_COLOR needBottomLine:NO needTranslucent:YES];
}

- (void)setUpConstrains {
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)updateNavigationBar {
    self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma -mark YCHMyTableViewDelegate
- (void)logOut {
    [UserCenter setIsLogin:NO];
}

- (YCHMyTableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[YCHMyTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.myTableViewDelegate = self;
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}

@end
