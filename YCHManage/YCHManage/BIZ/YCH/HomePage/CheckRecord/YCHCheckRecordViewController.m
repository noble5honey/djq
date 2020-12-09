//
//  YCHCheckRecordViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/15.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHCheckRecordViewController.h"
#import "YCHCheckRecordTableView.h"
#import "YCHBasicInfoScalePictureView.h"
#import "YCHExamineViewController.h"
#import "YCHScoreQueryTopView.h"
#import "FilTrateTableView.h"
#import "FiltrateFooterView.h"
#import "BJDatePickerView.h"
#import "YCHCorrectAndDetailsViewController.h"
#import "YCHHomePageEmptyView.h"
#import "YCHCheckRecordDetailsViewController.h"

@interface YCHCheckRecordViewController () <YCHCheckRecordTableViewDelegate, UISearchBarDelegate, filTrateTableViewDelegate>

@property (nonatomic, strong) NSDictionary *detailDic;

@property (nonatomic, strong) YCHCheckRecordTableView *checkRecordTableView;

@property (nonatomic, strong) YCHBasicInfoScalePictureView *pictureView;

@property (nonatomic, strong) YCHScoreQueryTopView *topView;

@property (nonatomic, strong) UIView *filtrateContentView;

@property (nonatomic, strong) FilTrateTableView *filtrateTableView;

@property (nonatomic, strong) UIButton *hiddenFiltrateBtn;

@property (nonatomic, strong) FiltrateFooterView *filtrateFooterView;

@property (nonatomic, strong) BJDatePicker *datePicker;

@property (nonatomic, strong) UITextField *startTF;  //筛选起始日期

@property (nonatomic, strong) UITextField *endTF;

@property (nonatomic, assign) YCHCheckRecordTextFieldTpye textFieldTpye;

@property (nonatomic, strong) YCHExamineDeductItemTableViewCell *selectedItemCell;  //筛选扣分项目cell

@property (nonatomic, strong) CALayer *pushLayer;

@property (nonatomic, strong) YCHHomePageEmptyView *emptyView;

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, assign) int currentPage;

@property (nonatomic, assign) BOOL isNeedUpdate;

@end

@implementation YCHCheckRecordViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.detailDic = detailDic;
        [self updateNavigationBar];
        [self initSubViews];
        [self addRefreshToTableView];
        [self addLoadmoreToTableView];
        [self.checkRecordTableView.mj_header beginRefreshing];
        [self requestMatterItem];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.title = [NSString stringWithFormat:@"%@",self.detailDic[@"fishName"]];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow_grey"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    NSLog(@"输出授权码%@",UserCenter.isPublishAuth ? @"1" : @"0");
    if (UserCenter.isPublishAuth) {
        UIImage *rightBarButtonImage = [UIImage imageNamed:@"navi_add_image"];
        rightBarButtonImage = [rightBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    }
    
}

- (void)initSubViews {
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.mas_equalTo(Width_Screen);
        make.height.mas_equalTo(60.f);
    }];
        
    [self.checkRecordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.filtrateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view.mas_right);
        make.width.mas_equalTo(Width_Screen);
    }];
    
    [self.filtrateFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.filtrateTableView);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.filtrateContentView);
    }];
    
    [self.filtrateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.filtrateContentView);
        make.width.mas_equalTo(Width_Screen*3/4);
        make.right.equalTo(self.filtrateContentView);
        make.bottom.equalTo(self.filtrateFooterView.mas_top);
    }];
    
    [self.hiddenFiltrateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.filtrateContentView);
        make.right.equalTo(self.filtrateTableView.mas_left);
    }];
    
//    NSArray *itemArry = @[@{@"itemName" : @"健康证有效期(健康证与实际从业人员是否一致)", @"itemKey" : @"001", @"grades" : @"5"},
//                          @{@"itemName" : @"食品经营许可证有效期", @"itemKey" : @"002", @"grades" : @"5"},
//                          @{@"itemName" : @"经营场所面积(自有/租赁)", @"itemKey" : @"003", @"grades" : @"0"},
//                          @{@"itemName" : @"功能间是否正常使用", @"itemKey" : @"004", @"grades" : @"10"},
//                          @{@"itemName" : @"店招店牌与营业执照名称是否一致", @"itemKey" : @"005", @"grades" : @"2"},
//                          @{@"itemName" : @"执照经营者与实际经营者是否一致(自有/转让)", @"itemKey" : @"006", @"grades" : @"0"},
//                          @{@"itemName" : @"农村生活污水接管", @"itemKey" : @"007", @"grades" : @"2"},
//                          @{@"itemName" : @"隔油池设置", @"itemKey" : @"008", @"grades" : @"11"},
//                          @{@"itemName" : @"污水直排", @"itemKey" : @"009", @"grades" : @"11"},
//                          @{@"itemName" : @"河边违章建筑", @"itemKey" : @"010", @"grades" : @"2"},
//                          @{@"itemName" : @"在河道内增设网簖 ", @"itemKey" : @"011", @"grades" : @"2"},
//                          @{@"itemName" : @"违章建筑", @"itemKey" : @"012", @"grades" : @"2"},
//                          @{@"itemName" : @"垃圾处置", @"itemKey" : @"013", @"grades" : @"2"},
//                          @{@"itemName" : @"畜禽（养殖）放养", @"itemKey" : @"012", @"grades" : @"2"},
//                          @{@"itemName" : @"家前屋后乱堆乱放", @"itemKey" : @"013", @"grades" : @"2"},
//                          @{@"itemName" : @"燃气安全", @"itemKey" : @"012", @"grades" : @"11"},
//                          @{@"itemName" : @"灭火器材", @"itemKey" : @"013", @"grades" : @"2"},
//                          @{@"itemName" : @"应急指示灯疏散标志", @"itemKey" : @"012", @"grades" : @"2"},
//                          @{@"itemName" : @"监控设施", @"itemKey" : @"013", @"grades" : @"2"},
//                          @{@"itemName" : @"防火门安装", @"itemKey" : @"012", @"grades" : @"11"},
//                          @{@"itemName" : @"油烟净化装置", @"itemKey" : @"013", @"grades" : @"11"},
//                          @{@"itemName" : @"有无菜单，并且明码标价", @"itemKey" : @"012", @"grades" : @"1"},
//                          @{@"itemName" : @"有无人员岗位制度，并且制度上墙", @"itemKey" : @"013", @"grades" : @"1"},
//                          @{@"itemName" : @"有无干手设备或擦手纸巾", @"itemKey" : @"012", @"grades" : @"1"}];
//    [self.filtrateTableView updateSectionTitleArray:@[@"日期选择", @"扣分项目"] itemArray:itemArry];
}

- (void)updateNavigationBarToBlackColor {
    [self.navigationController.navigationBar updateNaviBarTintColor:[UIColor blackColor] titleColor:[UIColor blackColor] backgroundColor:[UIColor blackColor] needBottomLine:NO needTranslucent:NO];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@""];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil  style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem.title = @"";
}

- (void)addRefreshToTableView {
    __weak typeof(self) weakSelf = self;
    weakSelf.checkRecordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof (self) strongSelf = self;
        [strongSelf requestData:NO];
    }];
}

- (void)addLoadmoreToTableView {
    __weak typeof(self) weakSelf = self;
    weakSelf.checkRecordTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof (self) strongSelf = self;
        [strongSelf requestData:YES];
    }];
}

- (void)requestData:(BOOL)isLoadMore {
    self.emptyView.hidden = YES ;
    if (!isLoadMore) {
        self.currentPage = 0;
        [self.checkRecordTableView.mj_footer resetNoMoreData];
    }
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"size"] = @"10";
    temParamDict[@"current"] = [NSString stringWithFormat:@"%d",self.currentPage + 1];
    temParamDict[@"fishId"] = self.detailDic[@"id"];
//    if (self.topView.searchBar.text.length > 0) {
//        temParamDict[@"fishName"] = self.topView.searchBar.text;
//    }
    if (self.startTF.text.length > 0) {
        NSString *startDateStr = self.startTF.text;
//        NSString *startTamp = [NSString timeSwitchTimestamp:startDateStr andFormatter:@"YYYY-MM-dd"];
        temParamDict[@"startDay"] = startDateStr;
    }
    if (self.endTF.text.length > 0) {
        NSString *endDateStr = self.endTF.text;
//        NSString *endTamp = [NSString timeSwitchTimestamp:endDateStr andFormatter:@"YYYY-MM-dd"];
        temParamDict[@"endDay"] = endDateStr;
    }
    NSString *matterCode = self.selectedItemCell.itemDic[@"matterCode"];
    if (matterCode.length > 0) {
        if (self.selectedItemCell.selected == NO) {
            temParamDict[@"matterCode"] = @"";
        } else {
            temParamDict[@"matterCode"] = matterCode;
        }
    }
    if (self.topView.searchBar.text.length > 0) {
        temParamDict[@"matterName"] = self.topView.searchBar.text;
    }
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_checkRecord_Query_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
        
    } successBlock:^(id response) {
//        self.itemArray = response[@"data"][@"data"];
//
//        [self.checkRecordTableView.mj_header endRefreshing];
        
        if (isLoadMore) {
            [self.checkRecordTableView.mj_footer endRefreshing];
            if (self.currentPage == [response[@"data"][@"amtPage"] intValue]) {
                [self.checkRecordTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            [self.checkRecordTableView.mj_header endRefreshing];
        }
        if ([response[@"data"][@"currentPage"] longValue] == 1) {
            self.itemArray = response[@"data"][@"data"];
        } else {
            NSMutableArray *temShopList = [NSMutableArray arrayWithArray:self.itemArray];
            self.itemArray = [temShopList arrayByAddingObjectsFromArray:response[@"data"][@"data"]];
        }
        self.currentPage = [response[@"data"][@"currentPage"] intValue];
        if (self.itemArray.count > 0) {
            self.emptyView.hidden = YES;
            self.checkRecordTableView.hidden = NO;
        } else {
            self.emptyView.hidden = NO;
            self.checkRecordTableView.hidden = YES;
        }
        if (self.currentPage == [response[@"data"][@"amtPage"] intValue]) {
            [self.checkRecordTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.checkRecordTableView.mj_footer endRefreshing];
        }
        [self.checkRecordTableView updateTableViewWithItemArray:self.itemArray];
    } failBlock:^(NSError *error) {
        if (isLoadMore) {
            [self.checkRecordTableView.mj_footer endRefreshing];
        }else {
            [self.checkRecordTableView.mj_header endRefreshing];
        }
        self.emptyView.hidden = YES;
        self.checkRecordTableView.hidden = NO;
        [YCHManagerToast showToastToView:self.view text:[NSString stringWithFormat:@"%@",error]];
    }];
}

- (void)requestMatterItem {
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"size"] = @"999";
    temParamDict[@"current"] = @"1";
    temParamDict[@"matterName"] = @"";
//    temParamDict[@"userId"] = UserCenter.userId;
    temParamDict[@"userId"] = @"";
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_matter_item_Query_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
        
    } successBlock:^(id response) {
        NSArray *matterItemArray = response[@"data"][@"records"];
        [self.filtrateTableView updateSectionTitleArray:@[@"日期选择", @"扣分项目"] itemArray:matterItemArray];
    } failBlock:^(NSError *error) {
        
    }];
}

- (void)addPushAnimation {
    
    self.pushLayer = [CALayer layer];
    self.pushLayer.position = CGPointMake(Width_Screen, 0);
    self.pushLayer.bounds = CGRectMake(Width_Screen, 0, Width_Screen, self.view.frame.size.height);
    self.pushLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.filtrateContentView.layer addSublayer:self.pushLayer];
    
    CABasicAnimation *basicAni = [CABasicAnimation animation];
    //设置动画属性
    basicAni.keyPath = @"position";
    //设置动画的起始位置。也就是动画从哪里到哪里
    basicAni.fromValue = [NSValue valueWithCGPoint:CGPointMake(Width_Screen, 0)];
    //动画结束后，layer所在的位置
    basicAni.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    //动画持续时间
    basicAni.duration = 2;
    //动画填充模式
    basicAni.fillMode = kCAFillModeForwards;
    //动画完成不删除
    basicAni.removedOnCompletion = NO;
    
    //xcode8.0之后需要遵守代理协议
//    basicAni.delegate = self;
    //把动画添加到要作用的Layer上面
    [self.pushLayer addAnimation:basicAni forKey:nil];
}

- (void)filtrate {
//    [self addPushAnimation];
    [self.topView.searchBar resignFirstResponder];
    [self.view setNeedsLayout];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.filtrateContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view);
            make.width.mas_equalTo(Width_Screen);
            make.left.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
    } completion:nil];
//    [UIView animateWithDuration:2 animations:^{
//        [self.filtrateTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(self.view);
//            make.width.mas_equalTo(Width_Screen*3/4);
//            make.left.equalTo(self.view).offset(Width_Screen/4);
//        }];
//    }];
}

#pragma -mark filTrateTableViewDelegate
- (void)clickStartTextFiled:(UITextField *)textField {
    self.startTF = textField;
    self.textFieldTpye = YCHCheckRecordTextFieldTpyeStart;
    textField.inputView = self.datePicker;
}

- (void)clickEndTextFiled:(UITextField *)textField {
    self.endTF = textField;
    self.textFieldTpye = YCHCheckRecordTextFieldTpyeEnd;
    textField.inputView = self.datePicker;
}

- (void)filtrateTableViewDidSelectedRowWithIndexPath:(NSIndexPath *)indexPath cell:(YCHExamineDeductItemTableViewCell *)cell {
    self.selectedItemCell = cell;
}
//点击重置按钮
- (void)clickRestButton {
    self.startTF.text = @"";
    self.endTF.text = @"";
    self.topView.searchBar.text = @"";
    self.selectedItemCell.selected = NO;
}
//点击确定按钮
- (void)clickEnsureButton {
    [self.checkRecordTableView.mj_header beginRefreshing];
    [self hiddenFiltrateView];
}

#pragma -mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"输入的内容%@",searchBar.text);
    if (searchBar == self.topView.searchBar) {
        [self.checkRecordTableView.mj_header beginRefreshing];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        [self.checkRecordTableView.mj_header beginRefreshing];
        [searchBar resignFirstResponder];
    }
}

#pragma -mark YCHCheckRecordTableViewDelegate
- (void)clickHotelPictureShowSacleImage:(UIImage *)image {
    if (image == nil) {
        return;
    }
    self.pictureView = [[YCHBasicInfoScalePictureView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, Height_Screen - (kIs_iPhoneX ? 88 : 64))];
    [self.pictureView updateViewWihtImage:image];
    [self.pictureView.closeButton addTarget:self action:@selector(closePictureView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pictureView];
    [self updateNavigationBarToBlackColor];
}

- (void)closePictureView {
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_NAV_BACKGROUND_COLOR titleColor:UMS_TEXT_BLACK backgroundColor:UMS_NAV_BACKGROUND_COLOR needBottomLine:NO needTranslucent:NO];
    [self.pictureView removeFromSuperview];
    [self updateNavigationBar];
}

- (void)checkRecoredTableViewDidScroll {
    [self.topView.searchBar resignFirstResponder];
}

- (void)checkRecordTableViewDidSelected {
   
}

- (void)clickCorrectOrDetailsButton:(UIButton *)btn contentDic:(NSDictionary *)contentDic{
    if (btn.tag == CheckRecord_CorrectButton) {
        YCHCorrectAndDetailsViewController *vc = [[YCHCorrectAndDetailsViewController alloc] initWithNibName:nil bundle:nil detailDic:contentDic type:YCHCheckRecordTypeCorrect];
        vc.blockparameter = ^(BOOL isSendSuccess) {
            if (isSendSuccess) {
                self.isNeedUpdate = isSendSuccess;
                [self.checkRecordTableView.mj_header beginRefreshing];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        YCHCheckRecordDetailsViewController *vc = [[YCHCheckRecordDetailsViewController alloc] initWithNibName:nil bundle:nil detailDic:contentDic];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)hiddenFiltrateView {
    [self.view setNeedsLayout];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.filtrateContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view);
            make.width.mas_equalTo(Width_Screen);
            make.left.equalTo(self.view.mas_right);
        }];
        [self.view layoutIfNeeded];
    } completion:nil];
    [self.startTF resignFirstResponder];
    [self.endTF resignFirstResponder];
}

- (void)cancelDatePicker {
    if (self.textFieldTpye == YCHCheckRecordTextFieldTpyeStart) {
        [self.startTF resignFirstResponder];
    } else {
        [self.endTF resignFirstResponder];
    }
}

- (YCHCheckRecordTableView *)checkRecordTableView {
    if (!_checkRecordTableView) {
        _checkRecordTableView = [[YCHCheckRecordTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _checkRecordTableView.checkRecordTVDeleagte = self;
        [self.view addSubview:_checkRecordTableView];
    }
    return _checkRecordTableView;
}

- (YCHScoreQueryTopView *)topView {
    if (!_topView) {
        _topView = [[YCHScoreQueryTopView alloc] initWithFrame:CGRectZero];
        [_topView.filtrateBtn addTarget:self action:@selector(filtrate) forControlEvents:UIControlEventTouchUpInside];
        _topView.searchBar.placeholder = @"请输入扣分项目";
        _topView.searchBar.delegate = self;
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (FilTrateTableView *)filtrateTableView {
    if (!_filtrateTableView) {
        _filtrateTableView = [[FilTrateTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _filtrateTableView.filtrateTVdelegate = self;
        [self.filtrateContentView addSubview:_filtrateTableView];
    }
    return _filtrateTableView;
}

- (UIView *)filtrateContentView {
    if (!_filtrateContentView) {
        _filtrateContentView = [[UIView alloc] initWithFrame:CGRectZero];
        _filtrateContentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self.view addSubview:_filtrateContentView];
    }
    return _filtrateContentView;
}

- (UIButton *)hiddenFiltrateBtn {
    if (!_hiddenFiltrateBtn) {
        _hiddenFiltrateBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_hiddenFiltrateBtn addTarget:self action:@selector(hiddenFiltrateView) forControlEvents:UIControlEventTouchUpInside];
        [self.filtrateContentView addSubview:_hiddenFiltrateBtn];
    }
    return _hiddenFiltrateBtn;
}

- (FiltrateFooterView *)filtrateFooterView {
    if (!_filtrateFooterView) {
        _filtrateFooterView = [[FiltrateFooterView alloc] initWithFrame:CGRectZero];
        _filtrateFooterView.backgroundColor = [UIColor whiteColor];
        [_filtrateFooterView.resetButton addTarget:self action:@selector(clickRestButton) forControlEvents:UIControlEventTouchUpInside];
        [_filtrateFooterView.ensureButton addTarget:self action:@selector(clickEnsureButton) forControlEvents:UIControlEventTouchUpInside];
        [self.filtrateContentView addSubview:_filtrateFooterView];
    }
    return _filtrateFooterView;
}

-(BJDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker=[BJDatePicker shareDatePicker];
        [_datePicker.cancelBtn addTarget:self action:@selector(cancelDatePicker) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        [_datePicker datePickerDidSelected:^(NSString *date) {
            if (weakSelf.textFieldTpye == YCHCheckRecordTextFieldTpyeStart) {
                weakSelf.startTF.text = date;
                [weakSelf.startTF resignFirstResponder];
                NSLog(@"起始时间：%@",date);
            } else {
                weakSelf.endTF.text = date;
                [weakSelf.endTF resignFirstResponder];
                NSLog(@"截止时间：%@",date);
            }
        }];
    }
    return _datePicker;
}

- (YCHHomePageEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[YCHHomePageEmptyView alloc] initWithFrame:CGRectZero];
        _emptyView.hidden = YES;
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

- (void)back {
    if (self.isNeedUpdate) {
        if (self.checkRecordBlock) {
            self.checkRecordBlock(YES);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)add {
    YCHExamineViewController *vc = [[YCHExamineViewController alloc] initWithNibName:nil bundle:nil detailDic:self.detailDic];
    vc.examineViewControllerBlock = ^{
        [self.checkRecordTableView.mj_header beginRefreshing];
        self.isNeedUpdate = YES;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
@end
