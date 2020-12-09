//
//  YCHExamineDeductItemViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHExamineDeductItemViewController.h"
#import "YCHExamineDeductItemTableView.h"

@interface YCHExamineDeductItemViewController () <YCHExamineDeductItemTableViewDelegate>

@property (nonatomic, strong) YCHExamineDeductItemTableView *examineDeductItemTableView;

@property (nonatomic, strong) NSArray <NSDictionary *>*itemArry;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YCHExamineDeductItemViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self updateNavigationBar];
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil indexPath:(NSIndexPath *)indexPath {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self updateNavigationBar];
        self.indexPath = indexPath;
        [self initSubViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestDeductItemList];
//    self.itemArry = @[@{@"itemName" : @"健康证有效期(健康证与实际从业人员是否一致)", @"itemKey" : @"001", @"grades" : @"5"},
//                           @{@"itemName" : @"食品经营许可证有效期", @"itemKey" : @"002", @"grades" : @"5"},
//                           @{@"itemName" : @"经营场所面积(自有/租赁)", @"itemKey" : @"003", @"grades" : @"0"},
//                           @{@"itemName" : @"功能间是否正常使用", @"itemKey" : @"004", @"grades" : @"10"},
//                           @{@"itemName" : @"店招店牌与营业执照名称是否一致", @"itemKey" : @"005", @"grades" : @"2"},
//                           @{@"itemName" : @"执照经营者与实际经营者是否一致(自有/转让)", @"itemKey" : @"006", @"grades" : @"0"},
//                           @{@"itemName" : @"农村生活污水接管", @"itemKey" : @"007", @"grades" : @"2"},
//                           @{@"itemName" : @"隔油池设置", @"itemKey" : @"008", @"grades" : @"11"},
//                           @{@"itemName" : @"污水直排", @"itemKey" : @"009", @"grades" : @"11"},
//                           @{@"itemName" : @"河边违章建筑", @"itemKey" : @"010", @"grades" : @"2"},
//                           @{@"itemName" : @"在河道内增设网簖 ", @"itemKey" : @"011", @"grades" : @"2"},
//                           @{@"itemName" : @"违章建筑", @"itemKey" : @"012", @"grades" : @"2"},
//                           @{@"itemName" : @"垃圾处置", @"itemKey" : @"013", @"grades" : @"2"},
//                           @{@"itemName" : @"畜禽（养殖）放养", @"itemKey" : @"012", @"grades" : @"2"},
//                           @{@"itemName" : @"家前屋后乱堆乱放", @"itemKey" : @"013", @"grades" : @"2"},
//                           @{@"itemName" : @"燃气安全", @"itemKey" : @"012", @"grades" : @"11"},
//                           @{@"itemName" : @"灭火器材", @"itemKey" : @"013", @"grades" : @"2"},
//                           @{@"itemName" : @"应急指示灯疏散标志", @"itemKey" : @"012", @"grades" : @"2"},
//                           @{@"itemName" : @"监控设施", @"itemKey" : @"013", @"grades" : @"2"},
//                           @{@"itemName" : @"防火门安装", @"itemKey" : @"012", @"grades" : @"11"},
//                           @{@"itemName" : @"油烟净化装置", @"itemKey" : @"013", @"grades" : @"11"},
//                           @{@"itemName" : @"有无菜单，并且明码标价", @"itemKey" : @"012", @"grades" : @"1"},
//                           @{@"itemName" : @"有无人员岗位制度，并且制度上墙", @"itemKey" : @"013", @"grades" : @"1"},
//                           @{@"itemName" : @"有无干手设备或擦手纸巾", @"itemKey" : @"012", @"grades" : @"1"}];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_NAV_BACKGROUND_COLOR titleColor:UMS_TEXT_BLACK backgroundColor:UMS_NAV_BACKGROUND_COLOR needBottomLine:NO needTranslucent:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)updateNavigationBar {
    if (self.isCheckNoti) {
        self.title = @"检查事项";
    } else {
        self.title = @"扣分项目";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow_grey"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)initSubViews {
    [self.examineDeductItemTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestDeductItemList {
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"size"] = @"999";
    temParamDict[@"current"] = @"1";
    temParamDict[@"matterName"] = @"";
    temParamDict[@"userId"] = UserCenter.userId;
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_matter_item_Query_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
        
    } successBlock:^(id response) {
        NSArray *matterItemArray = response[@"data"][@"records"];
        [self.examineDeductItemTableView updateTableViewWithItemArray:matterItemArray indexPath:self.indexPath];
    } failBlock:^(NSError *error) {
        
    }];
}

#pragma -mark YCHExamineDeductItemTableViewDelegate
- (void)examineDeductItemTableViewDidSelectedRowWithIndexPath:(NSIndexPath *)indexPath {
//    if (self.blockparameter) {
//        self.blockparameter(self.itemArry[indexPath.row]);
//        [self back];
//    }
}

- (void)examineDeductItemTableViewDidSelectedRowWithIndexPath:(NSIndexPath *)indexPath cell:(YCHExamineDeductItemTableViewCell *)cell {
    if (self.blockparameter) {
        self.blockparameter(cell.itemDic,indexPath);
        [self back];
    }
}

- (YCHExamineDeductItemTableView *)examineDeductItemTableView {
    if (!_examineDeductItemTableView) {
        _examineDeductItemTableView = [[YCHExamineDeductItemTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _examineDeductItemTableView.examineDeductItemTVDelagate = self;
        [self.view addSubview:_examineDeductItemTableView];
    }
    return _examineDeductItemTableView;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
