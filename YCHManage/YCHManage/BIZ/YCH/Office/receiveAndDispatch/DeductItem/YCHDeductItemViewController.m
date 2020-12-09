//
//  YCHDeductItemViewController.m
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHDeductItemViewController.h"
#import "YCHDeductItemTableView.h"

@interface YCHDeductItemViewController () <YCHDeductItemTableViewCellDelegate>

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) YCHDeductItemTableView *deductItemTV;

@end

@implementation YCHDeductItemViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil itemArray:(NSArray *)itemArray selectArray:(NSArray *)selectArray {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.itemArray = itemArray;
//        if (selectArray.count > 0) {
//            self.resultDepartmentArray = selectArray;
//        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationBar];
    [self initSubViews];
    [self.deductItemTV updateTableViewWithItemArray:self.itemArray];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_NAV_BACKGROUND_COLOR titleColor:UMS_TEXT_BLACK backgroundColor:UMS_NAV_BACKGROUND_COLOR needBottomLine:NO needTranslucent:NO];
}

- (void)updateNavigationBar {
    self.title = @"选择扣分项目";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
}

#pragma -mark YCHDeductItemTableViewCellDelegate
- (void)deductItemTableViewSelectdeductItemtResultItemStr:(NSString *)resultItemStr {
    if (self.deductItemStrblock) {
        self.deductItemStrblock(resultItemStr);
        [self back];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initSubViews {
    [self.deductItemTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (YCHDeductItemTableView *)deductItemTV {
    if (!_deductItemTV) {
        _deductItemTV = [[YCHDeductItemTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _deductItemTV.deductItemTVDelegate = self;
        [self.view addSubview:_deductItemTV];
    }
    return _deductItemTV;
}
@end
