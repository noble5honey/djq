//
//  YCHHomePageViewController.m
//  YCHManage
//
//  Created by sunny on 2020/6/18.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomePageViewController.h"
#import "YCHScoreQueryTopView.h"
#import "YCHHomePageTopFilterView.h"
#import "BJDatePickerView.h"
#import "YCHHomeTableView.h"
#import "YCHHomePageDetailViewController.h"
#import "YCHBasicInformationViewController.h"
#import "YCHCheckRecordViewController.h"
#import "YCHHomePageEmptyView.h"
#import "YCHHomePageNaviItemTableView.h"

#define NAVIGATIONHEIGHT                                            (ISIphoneX ? 88 : ISIPhone6 ? 64 : 132)
//#define NAVIGATIONHEIGHT                                            (ISIphoneX ? 132 : 88)

#define NotiPage_Button_Color                    \
[UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];

@interface YCHHomePageViewController ()<UISearchBarDelegate,UITextFieldDelegate,LMJDropdownMenuDataSource,LMJDropdownMenuDelegate,YCHHomePageTableViewDelegate,UIScrollViewDelegate, YCHHomePageNaviItemTableViewDelegate>

@property (nonatomic, strong) YCHScoreQueryTopView *topView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) YCHHomePageTopFilterView *filterView;

@property (nonatomic, strong) NSString *startDateStr;

@property (nonatomic, strong) NSString *endDateStr;
/**
 *  有遮盖
 */
@property (nonatomic, strong) BJDatePickerView *datePickerView;
/**
 *  无遮盖 替代键盘
 */
@property (nonatomic, strong) BJDatePicker *datePicker;

@property (nonatomic, assign) YCHHomePageTextFieldTpye textFieldTpye;

//下拉菜单
@property (nonatomic, strong) LMJDropdownMenu *dropdownMenu;

@property (nonatomic, strong) LMJDropdownMenu *selectRectificationItem;

@property (nonatomic, strong) NSMutableArray *areaArray;

@property (nonatomic, strong) NSString *selectAreaCode;

@property (nonatomic, strong) YCHHomeTableView *homeTableView;

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, assign) int currentPage;

@property (nonatomic, strong) YCHHomePageEmptyView *emptyView;

@property (nonatomic, strong) NSArray *rectificationItemArray;

@property (nonatomic, strong) NSString *selectedRetificationItemCode;

@property (nonatomic, strong) YCHHomePageNaviItemTableView *naviItemTableView;

@property (nonatomic, strong) NSString *oderByType; //排序类型

@property (nonatomic, strong) NSArray *naviItemArray;

@end

@implementation YCHHomePageViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil village:(NSString *)village isNoRectification:(BOOL)isNoRectification recentSevenDay:(NSString *)recentSevenDay recentMonth:(NSString *)recentMonth {
    if (self = [super initWithNibName:nil bundle:nil]) {
        [self initSubViews];
        [self requestAreaList];
        [self updateNavigationBar];
        [self updateDataWithVillage:village isNoRectification:isNoRectification recentSevenDay:recentSevenDay recentMonth:recentMonth];
        [self addRefreshToTableView];
        [self addLoadmoreToTableView];
        [self.homeTableView.mj_header beginRefreshing];
    }
    return self;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_THEME_COLOR titleColor:[UIColor whiteColor] backgroundColor:UMS_THEME_COLOR needBottomLine:NO needTranslucent:YES];
////    [self resetUI];
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_THEME_COLOR titleColor:[UIColor whiteColor] backgroundColor:UMS_THEME_COLOR needBottomLine:NO needTranslucent:YES];
//}

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
//    self.title = @"基本信息";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow_grey"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithTitle:@"排序" style:UIBarButtonItemStylePlain target:self action:@selector(showSortView)];
    [settingButton setTintColor:[UIColor blackColor]];
    [settingButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont ChinaDefaultFontNameOfSize:14.0],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = settingButton;
}

- (void)updateNavigationBarToBlackColor {
    [self.navigationController.navigationBar updateNaviBarTintColor:[UIColor blackColor] titleColor:[UIColor blackColor] backgroundColor:[UIColor blackColor] needBottomLine:NO needTranslucent:NO];
    
    UIImage *leftBarButtonImage = [UIImage imageNamed:@""];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem.title = @"";
}

- (void)showSortView {
    self.naviItemTableView.hidden = !self.naviItemTableView.hidden;
}

#pragma mark -YCHHomePageNaviItemTableViewDelegate
- (void)homePageDidSelectedNaviItemWithIndexPath:(NSIndexPath *)indexPath {
    self.oderByType = self.naviItemArray[indexPath.row][@"oderByType"];
    self.naviItemTableView.hidden = YES;
    [self.homeTableView.mj_header beginRefreshing];
}

- (void)updateDataWithVillage:(NSString *)village isNoRectification:(BOOL)isNoRectification recentSevenDay:(NSString *)recentSevenDay recentMonth:(NSString *)recentMonth {
    if (village.length > 0) {
        self.dropdownMenu.title = village;
    }
    if (isNoRectification) {
        self.selectedRetificationItemCode = @"0";
        self.selectRectificationItem.title = @"未整改";
    } else {
        self.selectedRetificationItemCode = nil;
    }
    NSInteger sevenDay = 604800000;
    NSInteger month = 2592000000;
    if (recentSevenDay.length > 0) {
        self.filterView.endTF.text = [NSString ConvertStrToTime:recentSevenDay];
        NSInteger endDay = recentSevenDay.integerValue;
        NSInteger result = endDay - sevenDay;
        NSString *convertStr = [NSString ConvertStrToTime:[NSString stringWithFormat:@"%ld",result]];
        self.filterView.startTF.text = convertStr;
    }
    if (recentMonth.length > 0) {
        self.filterView.endTF.text = [NSString ConvertStrToTime:recentMonth];
        NSInteger endDay = recentMonth.integerValue;
        NSInteger result = endDay - month;
        NSString *convertStr = [NSString ConvertStrToTime:[NSString stringWithFormat:@"%ld",result]];
        self.filterView.startTF.text = convertStr;
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resetUI {
    self.topView.searchBar.text = @"";
    self.filterView.startTF.text = @"";
    self.filterView.endTF.text = @"";
    self.filterView.minTF.text = @"";
    self.filterView.maxTF.text = @"";
    self.dropdownMenu.title = @"全部片区";
    self.dropdownMenu.hidden = YES;
    self.selectRectificationItem.title = @"状态";
    self.selectRectificationItem.hidden = YES;
    self.filterView.hidden = YES;
    [self.homeTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    self.topView.filtrateBtn.selected = NO;
    self.topView.filtrateLB.textColor = UMS_TEXT_BLACK;
    self.topView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
    [self.topView.searchBar setShowsCancelButton:NO animated:YES];
    self.selectAreaCode = nil;
    self.naviItemTableView.hidden = YES;
    [self.homeTableView.mj_header beginRefreshing];
}

- (void)initSubViews {
    
//    self.menArr = @[@"全部片区", @"清水村", @"新泾村", @"洋沟溇村", @"莲花村", @"渔业村", @"沺泾社区", @"五村一社区"];
    self.title = @"渔家乐管理";
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset([self navigationbarHeight]);
        make.top.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.height.mas_equalTo(60.f);
    }];
    
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(26 + [YCHManageDevice screenAdaptiveSizeWithIp6Size:90.f]);
    }];
    
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.naviItemTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(88);
        make.width.mas_equalTo(120);
    }];
    
    self.naviItemArray = @[@{@"title":@"分数升序",@"oderByType":@"asc"},
                                @{@"title":@"分数降序",@"oderByType":@"desc"}];
    [self.naviItemTableView updateTableViewWithItemArray:self.naviItemArray];
    
    self.dropdownMenu = [[LMJDropdownMenu alloc] init];
    [self.dropdownMenu setFrame:CGRectMake(16, (21+60+ ([YCHManageDevice screenAdaptiveSizeWithIp6Size:60])), 110, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
    
    self.dropdownMenu.dataSource = self;
    self.dropdownMenu.delegate   = self;
    
    self.dropdownMenu.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.dropdownMenu.layer.borderWidth  = 1;
    self.dropdownMenu.layer.cornerRadius = 3;
    
    self.dropdownMenu.title           = @"全部片区";
    self.dropdownMenu.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    self.dropdownMenu.titleFont       = [UIFont ChinaDefaultFontNameOfSize:14.f];
    self.dropdownMenu.titleColor      = [UIColor whiteColor];
    self.dropdownMenu.titleAlignment  = NSTextAlignmentLeft;
    self.dropdownMenu.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.dropdownMenu.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    self.dropdownMenu.rotateIconSize  = CGSizeMake(15, 15);
    
    self.dropdownMenu.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    self.dropdownMenu.optionFont          = [UIFont ChinaDefaultFontNameOfSize:13.f];
    self.dropdownMenu.optionTextColor     = UMS_TEXT_BLACK;
    self.dropdownMenu.optionTextAlignment = NSTextAlignmentLeft;
    self.dropdownMenu.optionNumberOfLines = 0;
    self.dropdownMenu.optionLineColor     = [UIColor whiteColor];
    self.dropdownMenu.optionIconSize      = CGSizeMake(15, 15);
    self.dropdownMenu.hidden = YES;
    [self.contentView addSubview:self.dropdownMenu];
    
    self.rectificationItemArray = @[@{@"rectificationItem" : @"所有",@"rectificationCode" : @""},
                                  @{@"rectificationItem" : @"已整改",@"rectificationCode" : @"1"},
                                  @{@"rectificationItem" : @"未整改",@"rectificationCode" : @"0"},
                                  @{@"rectificationItem" : @"正常",@"rectificationCode" : @"2"},
                                  @{@"rectificationItem" : @"逾期",@"rectificationCode" : @"3"},
                                  @{@"rectificationItem" : @"作废",@"rectificationCode" : @"4"}];
    
    self.selectRectificationItem = [[LMJDropdownMenu alloc] init];
    [self.selectRectificationItem setFrame:CGRectMake(128, (21+60+ ([YCHManageDevice screenAdaptiveSizeWithIp6Size:60])), 110, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
    self.selectRectificationItem.dataSource = self;
    self.selectRectificationItem.delegate   = self;
    self.selectRectificationItem.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.selectRectificationItem.layer.borderWidth  = 1;
    self.selectRectificationItem.layer.cornerRadius = 3;
    self.selectRectificationItem.title           = @"状态";
    self.selectRectificationItem.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    self.selectRectificationItem.titleFont       = [UIFont ChinaDefaultFontNameOfSize:14.f];
    self.selectRectificationItem.titleColor      = [UIColor whiteColor];
    self.selectRectificationItem.titleAlignment  = NSTextAlignmentLeft;
    self.selectRectificationItem.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    self.selectRectificationItem.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    self.selectRectificationItem.rotateIconSize  = CGSizeMake(15, 15);
    self.selectRectificationItem.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    self.selectRectificationItem.optionFont          = [UIFont ChinaDefaultFontNameOfSize:13.f];
    self.selectRectificationItem.optionTextColor     = UMS_TEXT_BLACK;
    self.selectRectificationItem.optionTextAlignment = NSTextAlignmentLeft;
    self.selectRectificationItem.optionNumberOfLines = 0;
    self.selectRectificationItem.optionLineColor     = [UIColor whiteColor];
    self.selectRectificationItem.optionIconSize      = CGSizeMake(15, 15);
    self.selectRectificationItem.hidden = YES;
    [self.contentView addSubview:self.selectRectificationItem];
    
}

- (void)requestAreaList {
    [[ZBNetworking shaerdInstance] getWithUrl:YCH_area_query_Server cache:nil params:nil progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        self.areaArray = [NSMutableArray array];
        self.areaArray = response[@"data"];
//        [self.areaArray addObject:@{@"dictName" : @"全部片区", @"dictCode" : @""}];
//        [self.areaArray insertObject:@{@"dictName" : @"全部片区", @"dictCode" : @""} atIndex:0];
        [self.dropdownMenu reloadOptionsData];
    } failBlock:^(NSError *error) {
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0];
    }];
}

- (void)delayMethod {
    [self requestAreaList];
}

- (void)addRefreshToTableView {
    __weak typeof(self) weakSelf = self;
    weakSelf.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof (self) strongSelf = self;
        [strongSelf requestData:NO];
    }];
}

- (void)addLoadmoreToTableView {
    __weak typeof(self) weakSelf = self;
    weakSelf.homeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof (self) strongSelf = self;
        [strongSelf requestData:YES];
    }];
}

- (void)closeKeyBoard {
    [self.topView.searchBar resignFirstResponder];
    [self.filterView.startTF resignFirstResponder];
    [self.filterView.endTF resignFirstResponder];
    [self.filterView.minTF resignFirstResponder];
    [self.filterView.maxTF resignFirstResponder];
}

- (void)requestData:(BOOL)isLoadMore {
    self.emptyView.hidden = YES ;
    if (!isLoadMore) {
        self.currentPage = 0;
        [self.homeTableView.mj_footer resetNoMoreData];
    }
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"size"] = @"10";
    temParamDict[@"current"] = [NSString stringWithFormat:@"%d",self.currentPage + 1];
    
//    if (self.selectAreaCode != [NSNull class] || self.selectAreaCode != nil) {
//        temParamDict[@"fishArea"] = self.selectAreaCode;
//        temParamDict[@"fishArea"] = self.dropdownMenu.title;
//    }
    if (![self.dropdownMenu.title isEqual:@"全部片区"]) {
        temParamDict[@"fishArea"] = self.dropdownMenu.title;
    } 
    if (self.filterView.startTF.text.length > 0) {
        NSString *startDateStr = self.filterView.startTF.text;
//        NSString *startDateTamp = [NSString timeSwitchTimestamp:startDateStr andFormatter:@"YYYY-MM-dd"];
        temParamDict[@"startDay"] = startDateStr;
    }
    if (self.filterView.endTF.text.length > 0) {
        NSString *endDateStr = self.filterView.endTF.text;
//        NSString *endDateTamp = [NSString timeSwitchTimestamp:endDateStr andFormatter:@"YYYY-MM-dd"];
        temParamDict[@"endDay"] = endDateStr;
    }
    if (self.filterView.minTF.text.length > 0) {
        temParamDict[@"fishScoreStart"] = self.filterView.minTF.text;
    }
    if (self.filterView.maxTF.text.length > 0) {
        temParamDict[@"fishScoreEnd"] = self.filterView.maxTF.text;
    }

    if (self.topView.searchBar.text.length > 0) {
        temParamDict[@"fishName"] = self.topView.searchBar.text;
    }
    if (self.selectedRetificationItemCode.length > 0) {
        temParamDict[@"isRec"] = self.selectedRetificationItemCode;
    }
    if (self.oderByType.length > 0) {
        temParamDict[@"orderBy"] = @"fishScore";
        temParamDict[@"oderByType"] = self.oderByType;
    }
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_HomePage_Query_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
        
    } successBlock:^(id response) {
//        self.itemArray = response[@"data"][@"data"];
//        [self.homeTableView updateTableViewWithItemArray:self.itemArray];
//        [self.homeTableView.mj_header endRefreshing];
        
//        return ;
        if (isLoadMore) {
            [self.homeTableView.mj_footer endRefreshing];
            
            if (self.currentPage == [response[@"data"][@"amtPage"] intValue]) {
                [self.homeTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            [self.homeTableView.mj_header endRefreshing];
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
            self.homeTableView.hidden = NO;
        } else {
            self.emptyView.hidden = NO;
            self.homeTableView.hidden = YES;
        }
        if (self.currentPage == [response[@"data"][@"amtPage"] intValue]) {
            [self.homeTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.homeTableView.mj_footer endRefreshing];
        }
        [self.homeTableView updateTableViewWithItemArray:self.itemArray];
    } failBlock:^(NSError *error) {
        if (isLoadMore) {
            [self.homeTableView.mj_footer endRefreshing];
        }else {
            [self.homeTableView.mj_header endRefreshing];
        }
        self.emptyView.hidden = YES;
        self.homeTableView.hidden = NO;
        [YCHManagerToast showToastToView:self.view text:[NSString stringWithFormat:@"%@",error]];
    }];
}

- (void)search {
    [self closeKeyBoard];
    [self.homeTableView.mj_header beginRefreshing];
}

- (void)cancelDatePicker {
    if (self.textFieldTpye == YCHHomePageTextFieldTpyeFirstPageStart) {
        [self.filterView.startTF resignFirstResponder];
    } else if (self.textFieldTpye == YCHHomePageTextFieldTpyeFirstPageEnd) {
        [self.filterView.endTF resignFirstResponder];
    }
}

//首页第一个页面筛选完毕
- (void)filterCommit {
//    self.selectAreaStr
//    self.startDateStr
//    self.endDateStr
//    self.filterView.minTF.text
//    self.filterView.maxTF.text
    [self.homeTableView.mj_header beginRefreshing];
    self.dropdownMenu.hidden = YES;
    self.selectRectificationItem.hidden = YES;
    self.filterView.hidden = YES;
    [self.homeTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    self.topView.filtrateBtn.selected = NO;
    self.topView.filtrateLB.textColor = UMS_TEXT_BLACK;
    self.topView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
    [self closeKeyBoard];
    self.naviItemTableView.hidden = YES;
}

- (void)resetSearch {
    
    self.filterView.maxTF.text = @"";
    self.filterView.minTF.text = @"";
    self.filterView.startTF.text = @"";
    self.filterView.endTF.text = @"";
    self.topView.searchBar.text = @"";
    self.dropdownMenu.title = @"全部片区";
    self.selectRectificationItem.title = @"状态";
    self.selectAreaCode = @"";
    self.selectedRetificationItemCode = @"";
    [self filterCommit];
    self.naviItemTableView.hidden = YES;
}

#pragma -mark YCHHomePageTableViewDelegate
- (void)homePageTableViewDidSelectRowWithDetailDic:(NSDictionary *)detailDic {
    YCHHomePageDetailViewController *vc = [[YCHHomePageDetailViewController alloc] initWithNibName:nil bundle:nil detailDic:detailDic];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)homePageTableViewDidSelectRow {
    [self homePageTableViewDidScroll];
}

- (void)homePageTableViewDidScroll {
    self.dropdownMenu.hidden = YES;
    self.selectRectificationItem.hidden = YES;
    self.filterView.hidden = YES;
    [self.homeTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    [self.emptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    self.topView.filtrateBtn.selected = NO;
    self.topView.filtrateLB.textColor = UMS_TEXT_BLACK;
    self.topView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
    [self.topView.searchBar resignFirstResponder];
    [self.topView.searchBar setShowsCancelButton:NO animated:YES];
    [self.filterView.startTF resignFirstResponder];
    [self.filterView.endTF resignFirstResponder];
    [self closeKeyBoard];
    self.naviItemTableView.hidden = YES;
}

- (void)homePageTableViewClickBasicInformationButtonWithDetailDic:(NSDictionary *)detailDic {
    YCHBasicInformationViewController *vc = [[YCHBasicInformationViewController alloc] initWithNibName:nil bundle:nil detailDic:detailDic];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)homePageTableViewClickRecordButtonWithDetailDic:(NSDictionary *)detailDic {
    YCHCheckRecordViewController *vc = [[YCHCheckRecordViewController alloc] initWithNibName:nil bundle:nil detailDic:detailDic];
    vc.hidesBottomBarWhenPushed = YES;
    vc.checkRecordBlock = ^(BOOL isUpdateData) {
        if (isUpdateData) {
            [self.homeTableView.mj_header beginRefreshing];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma -mark LMJDropdownMenuDataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu {
    if (menu == self.dropdownMenu) {
        return self.areaArray.count;
    } else {
        return self.rectificationItemArray.count;
    }
     
}

- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index {
    if (menu == self.dropdownMenu) {
        return self.areaArray[index][@"dictName"];
    } else {
        return self.rectificationItemArray[index][@"rectificationItem"];
    }
     
}

- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index {
    return 25.f;
}

#pragma -mark LMJDropdownMenuDelegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title {
    NSLog(@"你选择了(you selected)：menu1，index: %ld - title: %@", index, title);
    menu.title = title;
    if (menu == self.dropdownMenu) {
        self.selectAreaCode = self.areaArray[index][@"dictCode"];
        NSLog(@"你选择了(you selected)：menu1，AreaCode: %@ - title: %@", self.selectAreaCode, self.areaArray[index][@"dictName"]);
    } else {
        self.selectedRetificationItemCode = self.rectificationItemArray[index][@"rectificationCode"];
        NSLog(@"你选择了(you selected)：menu2，AreaCode: %@ - title: %@", self.rectificationItemArray[index][@"rectificationItem"], self.rectificationItemArray[index][@"rectificationCode"]);
    }
}

#pragma mark----UITextFieldDelegate----
//无遮盖 输入框进入编辑状态 BJDatePicker替换键盘
-(void)textFieldDidBeginEditing:(UITextField *)textField {
//    [self.serchView.searchBar resignFirstResponder];
    [self.topView.searchBar resignFirstResponder];
    self.naviItemTableView.hidden = YES;
    if (textField == self.filterView.startTF) {
        self.textFieldTpye = YCHHomePageTextFieldTpyeFirstPageStart;
        self.filterView.startTF.inputView = self.datePicker;
    } else if (textField == self.filterView.endTF) {
        self.textFieldTpye = YCHHomePageTextFieldTpyeFirstPageEnd;
        self.filterView.endTF.inputView = self.datePicker;
    }
    
}

#pragma -mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"开始输入搜索内容");
    [searchBar setShowsCancelButton:YES animated:YES]; // 动画显示取消按钮
    self.naviItemTableView.hidden = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    //    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        [self search];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar == self.topView.searchBar) {
        [self search];
        [searchBar resignFirstResponder];
    }
}

#pragma  -mark 第一个页面筛选按钮
- (void)firstPageFiltrate:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.filterView.hidden = NO;
        self.dropdownMenu.hidden = NO;
        self.selectRectificationItem.hidden = NO;
        [self.homeTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.filterView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        [self.emptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.filterView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        self.topView.filtrateLB.textColor = UMS_THEME_COLOR;
        self.topView.filtrateIV.image = [UIImage imageNamed:@"filtrate_selected_image"];
    } else {
        self.filterView.hidden = YES;
        self.dropdownMenu.hidden = YES;
        self.selectRectificationItem.hidden = YES;
        [self.homeTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        [self.emptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        self.topView.filtrateLB.textColor = UMS_TEXT_BLACK;
        self.topView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
    }
}

- (YCHScoreQueryTopView *)topView {
    if (!_topView) {
        _topView = [[YCHScoreQueryTopView alloc] initWithFrame:CGRectZero];
        [_topView.confirmBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        [_topView.filtrateBtn addTarget:self action:@selector(firstPageFiltrate:) forControlEvents:UIControlEventTouchUpInside];
        _topView.searchBar.delegate = self;
        [self.contentView addSubview:_topView];
    }
    return _topView;
}

- (UIView *)contentView {
    if (! _contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (YCHHomePageTopFilterView *)filterView {
    if (!_filterView) {
        _filterView = [[YCHHomePageTopFilterView alloc] initWithFrame:CGRectZero];
        _filterView.startTF.delegate = self;
        _filterView.endTF.delegate = self;
        _filterView.hidden = YES;
        [_filterView.commitBtn addTarget:self action:@selector(filterCommit) forControlEvents:UIControlEventTouchUpInside];
        [_filterView.resetBtn addTarget:self action:@selector(resetSearch) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_filterView];
    }
    return _filterView;
}

-(BJDatePickerView *)datePickerView{
    if (!_datePickerView) {
        _datePickerView=[BJDatePickerView shareDatePickerView];
        __weak typeof(self) weakSelf = self;
        [_datePickerView datePickerViewDidSelected:^(NSString *date) {
            weakSelf.filterView.startTF.text=date;
        }];
    }
    return _datePickerView;
}

-(BJDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker=[BJDatePicker shareDatePicker];
        [_datePicker.cancelBtn addTarget:self action:@selector(cancelDatePicker) forControlEvents:UIControlEventTouchUpInside];
       __weak typeof(self) weakSelf = self;
        [_datePicker datePickerDidSelected:^(NSString *date) {
            if (weakSelf.textFieldTpye == YCHHomePageTextFieldTpyeFirstPageStart) {
                weakSelf.filterView.startTF.text=date;
                [weakSelf.filterView.startTF resignFirstResponder];
                self.startDateStr = date;
                NSLog(@"起始时间：%@",self.startDateStr);
            } else if (weakSelf.textFieldTpye == YCHHomePageTextFieldTpyeFirstPageEnd) {
                weakSelf.filterView.endTF.text=date;
                [weakSelf.filterView.endTF resignFirstResponder];
                self.endDateStr = date;
                NSLog(@"截止时间：%@",self.endDateStr);
            } else if (weakSelf.textFieldTpye == YCHHomePageTextFieldTpyeSecondPageStart) {
//                weakSelf.dateRangeStartTF.text=date;
//                [weakSelf.dateRangeStartTF resignFirstResponder];
                NSLog(@"第二页面开始时间：%@",date);
            } else if (weakSelf.textFieldTpye == YCHHomePageTextFieldTpyeSecondPageEnd) {
//                weakSelf.dateRangeEndTF.text=date;
//                [weakSelf.dateRangeEndTF resignFirstResponder];
                NSLog(@"第二页面结束时间：%@",date);
            }
        }];
    }
    return _datePicker;
}

- (YCHHomeTableView *)homeTableView {
    if (!_homeTableView) {
        _homeTableView = [[YCHHomeTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _homeTableView.homepageTVDelegate = self;
        [self.contentView addSubview:_homeTableView];
    }
    return _homeTableView;
}

- (YCHHomePageEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[YCHHomePageEmptyView alloc] initWithFrame:CGRectZero];
        _emptyView.hidden = YES;
        [self.contentView insertSubview:_emptyView belowSubview:self.filterView];
    }
    return _emptyView;
}

- (YCHHomePageNaviItemTableView *)naviItemTableView {
    if (!_naviItemTableView) {
        _naviItemTableView = [[YCHHomePageNaviItemTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _naviItemTableView.layer.borderWidth = 0.5;
        _naviItemTableView.layer.borderColor = UMS_LINE_COLOR.CGColor;
        _naviItemTableView.hidden = YES;
        _naviItemTableView.naviItemTVDelegate = self;
        [self.view addSubview:_naviItemTableView];
    }
    return _naviItemTableView;
}

@end
