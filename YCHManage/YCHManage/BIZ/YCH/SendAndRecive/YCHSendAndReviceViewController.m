//
//  YCHSendAndReviceViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/10.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHSendAndReviceViewController.h"
#import "YCHScoreQueryTopView.h"
#import "BJDatePickerView.h"
#import "YCHAssistExamineTableView.h"
#import "YCHAssistExamineFiltrateView.h"
#import "YCHResultNotiTableView.h"
#import "YCHMessageDetailsViewController.h"
#import "YCHAddResultNotiViewController.h"
#import "YCHAddAssistExamineViewController.h"
#import "YCHAssistExamineDetailsViewController.h"
#import "YCHHomePageEmptyView.h"
#import "LMJDropdownMenu.h"

#define NAVIGATIONHEIGHT                                            (ISIphoneX ? 88 : 64)

#define SEGTMENTINDEX                                 @"segmetIndex"

@interface YCHSendAndReviceViewController () <UIScrollViewDelegate,UISearchBarDelegate,UITextFieldDelegate,YCHAssistExamineFiltrateViewDelegate, YCHAssistExamineTableViewDelegate, YCHResultNotiTableViewDelegate, LMJDropdownMenuDataSource,LMJDropdownMenuDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) YCHScoreQueryTopView *serchView; //通告收发搜索框

@property (nonatomic, strong) UIView *secondFiltrateView;  //通告收发 过滤视图

@property (nonatomic, strong) UITextField *dateRangeStartTF;  //起始textfield

@property (nonatomic, strong) UILabel *dateRangeMiddleLine;

@property (nonatomic, strong) UITextField *dateRangeEndTF;

@property (nonatomic, strong) UIButton *secondPageCommitBtn;  //通告收发 筛选完成按钮

@property (nonatomic, strong) UIButton *secondPageResetBtn;   //通知收发  筛选重置按钮

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray *secondMenArray;

@property (nonatomic, strong) NSString *selectAreaStr;

@property (nonatomic, strong) BJDatePicker *datePicker;

@property (nonatomic, assign) YCHHomePageTextFieldTpye textFieldTpye;

@property (nonatomic, strong) YCHAssistExamineTableView *assitExamineTV;

@property (nonatomic, strong) YCHAssistExamineFiltrateView *firstFiltrateView;

@property (nonatomic, strong) YCHScoreQueryTopView *firstSerchView; //通告收发搜索框

@property (nonatomic, assign) NSInteger segmentIndex;

@property (nonatomic, strong) YCHResultNotiTableView *resultNotiTV;

@property (nonatomic, strong) YCHHomePageEmptyView *checkPageEmptyView;

@property (nonatomic, strong) YCHHomePageEmptyView *notiPageEmptyView;

@property (nonatomic, assign) int checkCurrentPage;

@property (nonatomic, assign) int notiCurrentPage;

@property (nonatomic, strong) NSArray *checkListArray;

@property (nonatomic, strong) NSArray *notiListArray;

@property (nonatomic, strong) NSString *firstTheme;

@property (nonatomic, strong) NSString *secondTheme;

@property (nonatomic, strong) LMJDropdownMenu *examinePageDropMenu;

@property (nonatomic, strong) LMJDropdownMenu *notiPageDropMenu;

@property (nonatomic, strong) NSArray *dropMenuItemArry;

@property (nonatomic, strong) NSString *examineDropMenuSelected;

@property (nonatomic, strong) NSString *NotiDropMenuSelected;

@end

@implementation YCHSendAndReviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
    [self createSegMentController];
    [self addRefreshToTableView];
    [self addLoadmoreToTableView];
    [self queryDepartmentList];
    [self.assitExamineTV.mj_header beginRefreshing];
    [self.resultNotiTV.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_THEME_COLOR titleColor:nil backgroundColor:UMS_THEME_COLOR needBottomLine:NO needTranslucent:YES];
        NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:SEGTMENTINDEX];
        self.segmentedControl.selectedSegmentIndex = i;
        if (i == 0) {
            UIImage *rightBarButtonImage = [UIImage imageNamed:@"navi_add_image"];
            rightBarButtonImage = [rightBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.navigationItem.rightBarButtonItem.image = rightBarButtonImage;
            self.navigationItem.rightBarButtonItem.target = self;
            self.navigationItem.rightBarButtonItem.action = @selector(add);
            
            self.scrollView.contentOffset = CGPointMake(0, 0);
            if (self.firstSerchView.filtrateBtn.selected) {
                self.examinePageDropMenu.hidden = NO;
            } else {
                self.examinePageDropMenu.hidden = YES;
            }
            self.notiPageDropMenu.hidden = YES;
        } else {
            self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
            if (self.serchView.filtrateBtn.selected) {
                self.notiPageDropMenu.hidden = NO;
            } else {
                self.notiPageDropMenu.hidden = YES;
            }
            self.examinePageDropMenu.hidden = YES;
            
            if (UserCenter.isPublishAuth) {
//                UIImage *rightBarButtonImage = [UIImage imageNamed:@"navi_add_image"];
//                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(add)];
                
                UIImage *rightBarButtonImage = [UIImage imageNamed:@"navi_add_image"];
                rightBarButtonImage = [rightBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                self.navigationItem.rightBarButtonItem.image = rightBarButtonImage;
                self.navigationItem.rightBarButtonItem.target = self;
                self.navigationItem.rightBarButtonItem.action = @selector(add);
            } else {
//                UIImage *rightBarButtonImage = [UIImage imageNamed:@""];
//                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightBarButtonImage style:UIBarButtonItemStylePlain target:nil action:nil];
                self.navigationItem.rightBarButtonItem.image = nil;
                self.navigationItem.rightBarButtonItem.target = nil;
                self.navigationItem.rightBarButtonItem.action = nil;
            }
        }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_THEME_COLOR titleColor:nil backgroundColor:UMS_THEME_COLOR needBottomLine:NO needTranslucent:YES];
}

- (void)addRefreshToTableView {
    __weak typeof(self) weakSelf = self;
    weakSelf.assitExamineTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof (self) strongSelf = self;
        [strongSelf requstAssistCheckList:NO];
    }];
    weakSelf.resultNotiTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof (self) strongSelf = self;
        [strongSelf requestResultNotiList:NO];
    }];
}

- (void)addLoadmoreToTableView {
    __weak typeof(self) weakSelf = self;
    weakSelf.resultNotiTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof (self) strongSelf = self;
        [strongSelf requestResultNotiList:YES];
    }];
    weakSelf.assitExamineTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof (self) strongSelf = self;
        [strongSelf requstAssistCheckList:YES];
    }];
}

- (void)initSubViews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset([self navigationbarHeight]);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView);
        make.height.mas_equalTo(self.view.frame.size.height - [self navigationbarHeight] - [self tabbarHeight]);
        make.width.mas_equalTo(self.view.frame.size.width * 2);
    }];
    
    [self.serchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width_Screen);
        make.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(60.f);
    }];
    
    [self.firstSerchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(60.f);
        make.width.mas_equalTo(Width_Screen);
    }];
    
    [self.notiPageEmptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width_Screen);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.top.equalTo(self.serchView.mas_bottom);
    }];
    
    [self.checkPageEmptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.firstSerchView.mas_bottom);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
    }];
    
    [self.firstFiltrateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.firstSerchView);
        make.top.equalTo(self.firstSerchView.mas_bottom);
        make.height.mas_equalTo(10+[YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f] + 35);
    }];
    
    [self.secondFiltrateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.serchView);
        make.top.equalTo(self.serchView.mas_bottom);
        make.height.mas_equalTo(10+[YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f] + 35);
    }];
    
    [self.dateRangeStartTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondFiltrateView).offset(16.f);
        make.top.equalTo(self.secondFiltrateView);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:90.f]);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
    }];
    
    [self.dateRangeMiddleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeStartTF.mas_right).offset(5.f);
        make.centerY.equalTo(self.dateRangeStartTF);
    }];
    
    [self.dateRangeEndTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeMiddleLine.mas_right).offset(5.f);
        make.top.equalTo(self.dateRangeStartTF);
        make.width.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:90.f]);
        make.height.equalTo(self.dateRangeStartTF);
    }];
    
    [self.secondPageResetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateRangeEndTF.mas_right).offset(5);
        make.top.equalTo(self.dateRangeEndTF);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
        make.width.mas_equalTo(55);
    }];
    
    [self.secondPageCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondPageResetBtn.mas_right).offset(5);
        make.top.equalTo(self.dateRangeEndTF);
        make.height.mas_equalTo([YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f]);
        make.width.mas_equalTo(55);
    }];
    
    [self.resultNotiTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width_Screen);
        make.top.equalTo(self.serchView.mas_bottom);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.assitExamineTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(self.firstSerchView.mas_bottom);
        make.width.mas_equalTo(Width_Screen);
    }];
    
    self.dropMenuItemArry = @[@{@"roleName" : @"整改选项",@"roleKey" : @""},
                              @{@"roleName" : @"已整改",@"roleKey" : @"1"},
                              @{@"roleName" : @"未整改",@"roleKey" : @"0"},
                              @{@"roleName" : @"正常",@"roleKey" : @"2"},
                              @{@"roleName" : @"逾期",@"roleKey" : @"3"}];
    
    self.examinePageDropMenu = [[LMJDropdownMenu alloc] init];
    [self.examinePageDropMenu setFrame:CGRectMake(16, (10+60+ ([YCHManageDevice screenAdaptiveSizeWithIp6Size:30] + [self navigationbarHeight])), 180, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
    
    self.examinePageDropMenu.dataSource = self;
    self.examinePageDropMenu.delegate   = self;
    
    self.examinePageDropMenu.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.examinePageDropMenu.layer.borderWidth  = 1;
    self.examinePageDropMenu.layer.cornerRadius = 3;
    
    self.examinePageDropMenu.title           = @"请选择部门";
    self.examinePageDropMenu.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    self.examinePageDropMenu.titleFont       = [UIFont ChinaDefaultFontNameOfSize:14.f];
    self.examinePageDropMenu.titleColor      = [UIColor whiteColor];
    self.examinePageDropMenu.titleAlignment  = NSTextAlignmentLeft;
    self.examinePageDropMenu.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.examinePageDropMenu.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    self.examinePageDropMenu.rotateIconSize  = CGSizeMake(15, 15);
    
    self.examinePageDropMenu.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    self.examinePageDropMenu.optionFont          = [UIFont ChinaDefaultFontNameOfSize:13.f];
    self.examinePageDropMenu.optionTextColor     = UMS_TEXT_BLACK;
    self.examinePageDropMenu.optionTextAlignment = NSTextAlignmentLeft;
    self.examinePageDropMenu.optionNumberOfLines = 0;
    self.examinePageDropMenu.optionLineColor     = [UIColor whiteColor];
    self.examinePageDropMenu.optionIconSize      = CGSizeMake(15, 15);
    self.examinePageDropMenu.hidden = YES;
    [self.view addSubview:self.examinePageDropMenu];
    
    self.notiPageDropMenu = [[LMJDropdownMenu alloc] init];
    [self.notiPageDropMenu setFrame:CGRectMake(16, (10+60+ ([YCHManageDevice screenAdaptiveSizeWithIp6Size:30] + [self navigationbarHeight])), 180, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
    
    self.notiPageDropMenu.dataSource = self;
    self.notiPageDropMenu.delegate   = self;
    
    self.notiPageDropMenu.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.notiPageDropMenu.layer.borderWidth  = 1;
    self.notiPageDropMenu.layer.cornerRadius = 3;
    
    self.notiPageDropMenu.title           = @"请选择部门";
    self.notiPageDropMenu.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    self.notiPageDropMenu.titleFont       = [UIFont ChinaDefaultFontNameOfSize:14.f];
    self.notiPageDropMenu.titleColor      = [UIColor whiteColor];
    self.notiPageDropMenu.titleAlignment  = NSTextAlignmentLeft;
    self.notiPageDropMenu.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.notiPageDropMenu.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    self.notiPageDropMenu.rotateIconSize  = CGSizeMake(15, 15);
    
    self.notiPageDropMenu.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    self.notiPageDropMenu.optionFont          = [UIFont ChinaDefaultFontNameOfSize:13.f];
    self.notiPageDropMenu.optionTextColor     = UMS_TEXT_BLACK;
    self.notiPageDropMenu.optionTextAlignment = NSTextAlignmentLeft;
    self.notiPageDropMenu.optionNumberOfLines = 0;
    self.notiPageDropMenu.optionLineColor     = [UIColor whiteColor];
    self.notiPageDropMenu.optionIconSize      = CGSizeMake(15, 15);
    self.notiPageDropMenu.hidden = YES;
    [self.view addSubview:self.notiPageDropMenu];
    
}

- (void)queryDepartmentList {
    
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"parentCode"] = @"gov";
    [[ZBNetworking shaerdInstance] getWithUrl:YCH_role_query_Server cache:nil params:nil progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        self.dropMenuItemArry = response[@"data"];
        [self.examinePageDropMenu reloadOptionsData];
        [self.notiPageDropMenu reloadOptionsData];
    } failBlock:^(NSError *error) {
    }];
}

#pragma -mark LMJDropdownMenuDataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu {
    return self.dropMenuItemArry.count;
}

- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index {
    return self.dropMenuItemArry[index][@"roleName"];
}

- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index {
    return 25.f;
}

#pragma -mark LMJDropdownMenuDelegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title {
    NSLog(@"你选择了(you selected)：menu1，index: %ld - title: %@", index, title);
    menu.title = title;
    if (menu == self.examinePageDropMenu) {
        self.examineDropMenuSelected = self.dropMenuItemArry[index][@"roleKey"];
        NSLog(@"你选择了examinePageDropMenu：menu1，AreaCode: %@ - title: %@", title, self.examineDropMenuSelected);
    } else {
        self.NotiDropMenuSelected = self.dropMenuItemArry[index][@"roleKey"];
        NSLog(@"你选择了NotiDropMenu：menu2，AreaCode: %@ - title: %@", title, self.examineDropMenuSelected);
    }
}

//请求要求协检列表
- (void)requstAssistCheckList:(BOOL)isLoadMore {
    self.checkPageEmptyView.hidden = YES ;
    if (!isLoadMore) {
        self.checkCurrentPage = 0;
        [self.assitExamineTV.mj_footer resetNoMoreData];
    }
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    if (self.firstFiltrateView.dateRangeStartTF.text.length > 0) {
        NSString *startDateStr = self.firstFiltrateView.dateRangeStartTF.text;
//        NSString *timeTamp = [NSString timeSwitchTimestamp:startDateStr andFormatter:@"YYYY-MM-dd"];
        temParamDict[@"startDay"] = startDateStr;
    } else {
        temParamDict[@"startDay"] = @"";
    }
    if (self.firstFiltrateView.dateRangeEndTF.text.length > 0) {
        NSString *endDateStr = self.firstFiltrateView.dateRangeEndTF.text;
//        NSString *timeTamp = [NSString timeSwitchTimestamp:endDateStr andFormatter:@"YYYY-MM-dd"];
         temParamDict[@"endDay"] = endDateStr;
    } else {
        temParamDict[@"endDay"] = @"";
    }
    if (self.examineDropMenuSelected.length > 0) {
        temParamDict[@"departmentCode"] = self.examineDropMenuSelected;
    }
    temParamDict[@"size"] = @"10";
    temParamDict[@"status"] = @"all";
    temParamDict[@"current"] = [NSString stringWithFormat:@"%d",self.checkCurrentPage + 1];
    temParamDict[@"receiveRoleCode"] = @"";
    temParamDict[@"sendRoleCode"] = @"";
    if (self.firstTheme.length > 0) {
         temParamDict[@"topic"] = self.firstTheme;
    } else {
         temParamDict[@"topic"] = @"";
    }
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_assistChek_query_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        if (isLoadMore) {
            [self.assitExamineTV.mj_footer endRefreshing];
            //pages 总页数
            if (self.checkCurrentPage == [response[@"data"][@"pages"] intValue]) {
                [self.assitExamineTV.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            [self.assitExamineTV.mj_header endRefreshing];
        }
        if ([response[@"data"][@"current"] longValue] == 1) {
            self.checkListArray = response[@"data"][@"records"];
        } else {
            NSMutableArray *temShopList = [NSMutableArray arrayWithArray:self.checkListArray];
            self.checkListArray = [temShopList arrayByAddingObjectsFromArray:response[@"data"][@"records"]];
        }
        self.checkCurrentPage = [response[@"data"][@"current"] intValue];
        if (self.checkListArray.count > 0) {
            self.checkPageEmptyView.hidden = YES;
            self.assitExamineTV.hidden = NO;
        } else {
            self.checkPageEmptyView.hidden = NO;
            self.assitExamineTV.hidden = YES;
        }
        if (self.checkCurrentPage == [response[@"data"][@"pages"] intValue]) {
            [self.assitExamineTV.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.assitExamineTV.mj_footer endRefreshing];
        }
        [self.assitExamineTV updateAssistExamineTableViewWithContentArray:self.checkListArray];
    } failBlock:^(NSError *error) {
        if (isLoadMore) {
            [self.assitExamineTV.mj_footer endRefreshing];
        }else {
            [self.assitExamineTV.mj_header endRefreshing];
        }
        self.checkPageEmptyView.hidden = YES;
        self.assitExamineTV.hidden = NO;
        [YCHManagerToast showToastToView:self.view text:[NSString stringWithFormat:@"%@",error]];
    }];
}

//q请求结果通告列表
- (void)requestResultNotiList:(BOOL)isLoadMore {
    self.notiPageEmptyView.hidden = YES ;
    if (!isLoadMore) {
        self.notiCurrentPage = 0;
        [self.resultNotiTV.mj_footer resetNoMoreData];
    }
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    if (self.dateRangeStartTF.text.length > 0) {
        NSString *startDateStr = self.dateRangeStartTF.text;
//        NSString *timeTamp = [NSString timeSwitchTimestamp:startDateStr andFormatter:@"YYYY-MM-dd"];
        temParamDict[@"startDay"] = startDateStr;
    } else {
        temParamDict[@"startDay"] = @"";
    }
    if (self.dateRangeEndTF.text.length > 0) {
        NSString *endDateStr = self.dateRangeEndTF.text;
//        NSString *timeTamp = [NSString timeSwitchTimestamp:endDateStr andFormatter:@"YYYY-MM-dd"];
        temParamDict[@"endDay"] = endDateStr;
    } else {
        temParamDict[@"endDay"] = @"";
    }
    if (self.NotiDropMenuSelected.length > 0) {
        temParamDict[@"departmentCode"] = self.NotiDropMenuSelected;
    }
    temParamDict[@"size"] = @"10";
    temParamDict[@"status"] = @"all";
    temParamDict[@"current"] = [NSString stringWithFormat:@"%d",self.notiCurrentPage + 1];
    temParamDict[@"receiveRoleCode"] = @"";
    temParamDict[@"sendRoleCode"] = @"";
    if (self.secondTheme.length > 0) {
        temParamDict[@"topic"] = self.secondTheme;
    } else {
        temParamDict[@"topic"] = @"";
    }
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_resultNoti_query_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        if (isLoadMore) {
            [self.resultNotiTV.mj_footer endRefreshing];
            
            if (self.notiCurrentPage == [response[@"data"][@"pages"] intValue]) {
                [self.resultNotiTV.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            [self.resultNotiTV.mj_header endRefreshing];
        }
        if ([response[@"data"][@"current"] longValue] == 1) {
            self.notiListArray = response[@"data"][@"records"];
        } else {
            NSMutableArray *temShopList = [NSMutableArray arrayWithArray:self.notiListArray];
            self.notiListArray = [temShopList arrayByAddingObjectsFromArray:response[@"data"][@"records"]];
        }
        self.notiCurrentPage = [response[@"data"][@"current"] intValue];
        if (self.notiListArray.count > 0) {
            self.notiPageEmptyView.hidden = YES;
            self.resultNotiTV.hidden = NO;
        } else {
            self.notiPageEmptyView.hidden = NO;
            self.resultNotiTV.hidden = YES;
        }
        if (self.notiCurrentPage == [response[@"data"][@"pages"] intValue]) {
            [self.resultNotiTV.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.resultNotiTV.mj_footer endRefreshing];
        }
        [self.resultNotiTV updateResultNotiTableViewWithContenArray:self.notiListArray];
    } failBlock:^(NSError *error) {
        if (isLoadMore) {
            [self.resultNotiTV.mj_footer endRefreshing];
        }else {
            [self.resultNotiTV.mj_header endRefreshing];
        }
        self.notiPageEmptyView.hidden = YES;
        self.resultNotiTV.hidden = NO;
        [YCHManagerToast showToastToView:self.view text:[NSString stringWithFormat:@"%@",error]];
    }];
}

-(void)createSegMentController{
    
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"要求协检",@"结果通告",nil];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(0, 0, 180, 30);
    self.segmentedControl.selectedSegmentIndex = 0;
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:SEGTMENTINDEX];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.segmentedControl.tintColor = [UIColor colorWithRed:252/255.0 green:245/255.0 blue:248/255.0 alpha:1];
    [self.segmentedControl addTarget:self action:@selector(selectSegment:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:self.segmentedControl];
    
//    if (UserCenter.isPublishAuth) {
        UIImage *rightBarButtonImage = [UIImage imageNamed:@"navi_add_image"];
        rightBarButtonImage = [rightBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(add)];
//    }
}

- (void)add {
    NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:SEGTMENTINDEX];
    if (i == 1) {
        YCHAddResultNotiViewController *vc = [[YCHAddResultNotiViewController alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        vc.addResultNotiViewControllerBlock = ^(BOOL isUpdateData) {
            if (isUpdateData) {
                [self.resultNotiTV.mj_header beginRefreshing];
            }
        };
        [self.notiPageDropMenu hideDropDown];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (i == 0) {
        YCHAddAssistExamineViewController *vc = [[YCHAddAssistExamineViewController alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        vc.assistEximeViewControllerBlock = ^(BOOL isUpdateData) {
            if (isUpdateData) {
                [self.assitExamineTV.mj_header beginRefreshing];
            }
        };
        [self.examinePageDropMenu hideDropDown];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.y <= 0 || offset.y > 0){
        offset.y = 0;
    }
    scrollView.contentOffset = offset;
    [self.serchView.searchBar resignFirstResponder];
    [self.serchView.searchBar setShowsCancelButton:NO animated:NO];
    [self.firstSerchView.searchBar resignFirstResponder];
}

//首页第二个页面筛选完毕
- (void)secondPageCommit:(UIButton *)btn {
    self.secondFiltrateView.hidden = YES;
    self.serchView.filtrateBtn.selected = NO;
    self.serchView.filtrateLB.textColor = UMS_TEXT_BLACK;
    self.serchView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
    [self.dateRangeStartTF resignFirstResponder];
    [self.dateRangeEndTF resignFirstResponder];
    [self.resultNotiTV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serchView.mas_bottom);
        make.left.equalTo(self.contentView).offset(Width_Screen);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    [self.notiPageEmptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serchView.mas_bottom);
        make.left.equalTo(self.contentView).offset(Width_Screen);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
//    [self requestResultNotiList:NO];
    [self.resultNotiTV.mj_header beginRefreshing];
    self.notiPageDropMenu.hidden = YES;
    [self.notiPageDropMenu showDropDown];
}

- (void)secondPageReset:(UIButton *)btn {
    self.dateRangeStartTF.text = @"";
    self.dateRangeEndTF.text = @"";
    self.notiPageDropMenu.title = @"请选择部门";
    self.NotiDropMenuSelected = @"";
    [self.notiPageDropMenu showDropDown];
}

- (void)selectSegment:(UISegmentedControl *)segControl{
    NSInteger i = segControl.selectedSegmentIndex;
    if (i == 0) {
        self.firstSerchView.filtrateBtn.selected = NO;;
        UIImage *rightBarButtonImage = [UIImage imageNamed:@"navi_add_image"];
        rightBarButtonImage = [rightBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(add)];
        
        [self.view setNeedsLayout];
        [UIView animateWithDuration:0.2 animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
            [self.view layoutIfNeeded];
        }];
        [self resignFirstResponder];
        [[NSUserDefaults standardUserDefaults] setInteger:i forKey:SEGTMENTINDEX];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (self.firstSerchView.filtrateBtn.selected) {
            self.examinePageDropMenu.hidden = NO;
            [self FirstPageFiltrate:self.firstSerchView.filtrateBtn];
        } else {
            self.examinePageDropMenu.hidden = YES;
        }
        self.notiPageDropMenu.hidden = YES;
        [self.notiPageDropMenu hideDropDown];
    } else {
        if (UserCenter.isPublishAuth) {
            UIImage *rightBarButtonImage = [UIImage imageNamed:@"navi_add_image"];
            rightBarButtonImage = [rightBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.navigationItem.rightBarButtonItem.image = rightBarButtonImage;
            self.navigationItem.rightBarButtonItem.target = self;
            self.navigationItem.rightBarButtonItem.action = @selector(add);
        } else {
            self.navigationItem.rightBarButtonItem.image = nil;
            self.navigationItem.rightBarButtonItem.target = nil;
            self.navigationItem.rightBarButtonItem.action = nil;
        }
//        self.serchView.filtrateBtn.selected = NO;
        [self.view setNeedsLayout];
        [UIView animateWithDuration:0.2 animations:^{
            self.scrollView.contentOffset = CGPointMake(Width_Screen, 0);
            [self.view layoutIfNeeded];
        }];
        [self resignFirstResponder];
        [[NSUserDefaults standardUserDefaults] setInteger:i forKey:SEGTMENTINDEX];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (self.serchView.filtrateBtn.selected) {
            self.notiPageDropMenu.hidden = NO;
            [self secondPageFiltrate:self.serchView.filtrateBtn];
        } else {
            self.notiPageDropMenu.hidden = YES;
        }
        self.examinePageDropMenu.hidden = YES;
        [self.examinePageDropMenu hideDropDown];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger num = (NSInteger)(scrollView.contentOffset.x - Width_Screen)/Width_Screen +1;
    
    self.segmentedControl.selectedSegmentIndex = num;
}


- (void)cancelDatePicker {
     if (self.textFieldTpye == YCHHomePageTextFieldTpyeSecondPageStart) {
        [self.dateRangeStartTF resignFirstResponder];
    } else if (self.textFieldTpye == YCHHomePageTextFieldTpyeSecondPageEnd) {
        [self.dateRangeEndTF resignFirstResponder];
    }
}

#pragma -mark YCHAssistExamineFiltrateViewDelegate
- (void)filtrateViewCommitStartTF:(UITextField *)statTF endTF:(UITextField *)endTF {
//    if (statTF.text.length == 0) {
//        [YCHManagerToast showToastToView:self.view text:@"请选择起始日期"];
//        return;
//    } else if (endTF.text.length == 0) {
//        [YCHManagerToast showToastToView:self.view text:@"请选择截止日期"];
//        return;
//    }

    self.firstFiltrateView.hidden = YES;
    self.firstSerchView.filtrateBtn.selected = NO;
    self.firstSerchView.filtrateLB.textColor = UMS_TEXT_BLACK;
    self.firstSerchView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
    [self.firstFiltrateView.dateRangeStartTF resignFirstResponder];
    [self.firstFiltrateView.dateRangeEndTF resignFirstResponder];
    [self.assitExamineTV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSerchView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    [self.checkPageEmptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSerchView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    
//    [self requstAssistCheckList:NO];
    [self.assitExamineTV.mj_header beginRefreshing];
    self.examinePageDropMenu.hidden = YES;
    [self.examinePageDropMenu hideDropDown];
    
}

- (void)firstPageReset {
    self.firstFiltrateView.dateRangeStartTF.text = @"";
    self.firstFiltrateView.dateRangeEndTF.text = @"";
    self.examinePageDropMenu.title = @"请选择部门";
    self.examineDropMenuSelected = @"";
    [self.examinePageDropMenu hideDropDown];
}

- (void)assistExamineTableViewDidScroll {
    self.firstFiltrateView.hidden = YES;
    self.firstSerchView.filtrateBtn.selected = NO;
    self.firstSerchView.filtrateLB.textColor = UMS_TEXT_BLACK;
    self.firstSerchView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
    [self.firstFiltrateView.dateRangeStartTF resignFirstResponder];
    [self.firstFiltrateView.dateRangeEndTF resignFirstResponder];
    [self.assitExamineTV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSerchView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    [self.checkPageEmptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSerchView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    [self.firstSerchView.searchBar resignFirstResponder];
    self.examinePageDropMenu.hidden = YES;
    [self.examinePageDropMenu hideDropDown];
}

- (void)resultNotiTableViewDidScroll {
    self.secondFiltrateView.hidden = YES;
    self.serchView.filtrateBtn.selected = NO;
    self.serchView.filtrateLB.textColor = UMS_TEXT_BLACK;
    self.serchView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
    [self.dateRangeStartTF resignFirstResponder];
    [self.dateRangeEndTF resignFirstResponder];
    [self.resultNotiTV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serchView.mas_bottom);
        make.left.equalTo(self.contentView).offset(Width_Screen);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    [self.notiPageEmptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serchView.mas_bottom);
        make.left.equalTo(self.contentView).offset(Width_Screen);
        make.width.mas_equalTo(Width_Screen);
        make.bottom.equalTo(self.contentView);
    }];
    [self.serchView.searchBar resignFirstResponder];
    self.notiPageDropMenu.hidden = YES;
    [self.notiPageDropMenu hideDropDown];
}

#pragma  -mark 第一个页面筛选按钮
- (void)FirstPageFiltrate:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.firstFiltrateView.hidden = NO;
        [self.assitExamineTV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstFiltrateView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        [self.checkPageEmptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstFiltrateView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        self.firstSerchView.filtrateLB.textColor = UMS_THEME_COLOR;
        self.firstSerchView.filtrateIV.image = [UIImage imageNamed:@"filtrate_selected_image"];
        self.examinePageDropMenu.hidden = NO;
    } else {
        self.firstFiltrateView.hidden = YES;
        [self.assitExamineTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.firstSerchView.mas_bottom);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        [self.checkPageEmptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.firstSerchView.mas_bottom);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        self.firstSerchView.filtrateLB.textColor = UMS_TEXT_BLACK;
        self.firstSerchView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
        [self.firstFiltrateView.dateRangeStartTF resignFirstResponder];
        [self.firstFiltrateView.dateRangeEndTF resignFirstResponder];
        self.examinePageDropMenu.hidden = YES;
    }
}

#pragma  -mark 第二个页面筛选按钮
- (void)secondPageFiltrate:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.secondFiltrateView.hidden = NO;
        [self.resultNotiTV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondFiltrateView.mas_bottom);
            make.left.equalTo(self.contentView).offset(Width_Screen);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        [self.notiPageEmptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondFiltrateView.mas_bottom);
            make.left.equalTo(self.contentView).offset(Width_Screen);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        self.serchView.filtrateLB.textColor = UMS_THEME_COLOR;
        self.serchView.filtrateIV.image = [UIImage imageNamed:@"filtrate_selected_image"];
        self.notiPageDropMenu.hidden = NO;
    } else {
        self.secondFiltrateView.hidden = YES;
        [self.resultNotiTV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(Width_Screen);
            make.top.equalTo(self.serchView.mas_bottom);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        [self.notiPageEmptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(Width_Screen);
            make.top.equalTo(self.serchView.mas_bottom);
            make.width.mas_equalTo(Width_Screen);
            make.bottom.equalTo(self.contentView);
        }];
        self.serchView.filtrateLB.textColor = UMS_TEXT_BLACK;
        self.serchView.filtrateIV.image = [UIImage imageNamed:@"filtrate_image"];
        [self.dateRangeStartTF resignFirstResponder];
        [self.dateRangeEndTF resignFirstResponder];
        self.notiPageDropMenu.hidden = YES;
    }
}

#pragma -mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar == self.firstSerchView.searchBar) {
        self.firstTheme = searchText;
        if (searchText.length == 0) {
            [self.assitExamineTV.mj_header beginRefreshing];
        }
    } else {
        self.secondTheme = searchText;
        if (searchText.length == 0) {
            [self.resultNotiTV.mj_header beginRefreshing];
        }
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"输入的内容%@",searchBar.text);
    if (searchBar == self.firstSerchView.searchBar) {
        [self.assitExamineTV.mj_header beginRefreshing];
    } else {
        [self.resultNotiTV.mj_header beginRefreshing];
    }
    [searchBar resignFirstResponder];
}

- (void)search {
    
}

#pragma mark----UITextFieldDelegate----
//无遮盖 输入框进入编辑状态 BJDatePicker替换键盘
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.serchView.searchBar resignFirstResponder];
    if (textField == self.dateRangeStartTF) {
        self.textFieldTpye = YCHHomePageTextFieldTpyeSecondPageStart;
        self.dateRangeStartTF.inputView = self.datePicker;
    } else if (textField == self.dateRangeEndTF) {
        self.textFieldTpye = YCHHomePageTextFieldTpyeSecondPageEnd;
        self.dateRangeEndTF.inputView = self.datePicker;
    }
}



#pragma -mark  YCHAssistExamineTableViewDelegate
- (void)assistExamineTableViewDidSelectRowWithDictionary:(NSDictionary *)dic {
    YCHAssistExamineDetailsViewController *vc = [[YCHAssistExamineDetailsViewController alloc] initWithNibName:nil bundle:nil detailDic:dic];
    vc.hidesBottomBarWhenPushed = YES;
    vc.assistExamineDetailsViewControllerBlock = ^(BOOL isUpdateData) {
        [self requstAssistCheckList:NO];
    };
    [self.examinePageDropMenu hideDropDown];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma -mark YCHResultNotiTableViewDelegate
- (void)resultNotiTableViewDidSelectRowWithDictionary:(NSDictionary *)dic {
    YCHMessageDetailsViewController *vc = [[YCHMessageDetailsViewController alloc] initWithNibName:nil bundle:nil detailDic:dic];
    vc.hidesBottomBarWhenPushed = YES;
    vc.messageDetailsViewControllerBlock = ^(BOOL isUpdateData) {
        [self requestResultNotiList:NO];
    };
    [self.notiPageDropMenu hideDropDown];
    [self.navigationController pushViewController:vc animated:YES];
}

- (YCHScoreQueryTopView *)serchView {
    if (!_serchView) {
        _serchView = [[YCHScoreQueryTopView alloc] initWithFrame:CGRectZero];
        [_serchView.filtrateBtn addTarget:self action:@selector(secondPageFiltrate:) forControlEvents:UIControlEventTouchUpInside];
        _serchView.searchBar.delegate = self;
        _serchView.searchBar.placeholder = @"请输入标题";
        _serchView.filtrateBtn.selected = NO;
        [self.contentView addSubview:_serchView];
    }
    return _serchView;
}

- (YCHScoreQueryTopView *)firstSerchView {
    if (!_firstSerchView) {
        _firstSerchView = [[YCHScoreQueryTopView alloc] initWithFrame:CGRectZero];
        [_firstSerchView.filtrateBtn addTarget:self action:@selector(FirstPageFiltrate:) forControlEvents:UIControlEventTouchUpInside];
        _firstSerchView.searchBar.placeholder = @"请输入标题";
        _firstSerchView.searchBar.delegate = self;
        _firstSerchView.filtrateBtn.selected = NO;
        [self.contentView addSubview:_firstSerchView];
    }
    return _firstSerchView;
}

- (UIView *)secondFiltrateView {
    if (!_secondFiltrateView) {
        _secondFiltrateView = [[UIView alloc] initWithFrame:CGRectZero];
        _secondFiltrateView.backgroundColor = [UIColor colorWithRed:238.0 / 255.0 green:242.0 / 255.0 blue:245.0 /255.0 alpha:1.0];
        _secondFiltrateView.hidden = YES;
        [self.contentView addSubview:_secondFiltrateView];
    }
    return _secondFiltrateView;
}

- (UITextField *)dateRangeStartTF {
    if (!_dateRangeStartTF) {
        _dateRangeStartTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _dateRangeStartTF.placeholder = @"起始日期";
        _dateRangeStartTF.tintColor = UMS_THEME_COLOR;
        _dateRangeStartTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"起始日期" attributes:attDic];
            _dateRangeStartTF.attributedPlaceholder = attPlace;
        } else {
            [_dateRangeStartTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        }
        _dateRangeStartTF.textColor = UMS_TEXT_BLACK;
        _dateRangeStartTF.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
        leftView.backgroundColor = [UIColor clearColor];
        _dateRangeStartTF.leftView = leftView;
        _dateRangeStartTF.delegate = self;
        _dateRangeStartTF.leftViewMode = UITextFieldViewModeAlways;
        [self.secondFiltrateView addSubview:_dateRangeStartTF];
    }
    return _dateRangeStartTF;
}

- (UILabel *)dateRangeMiddleLine {
    if (!_dateRangeMiddleLine) {
        _dateRangeMiddleLine = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateRangeMiddleLine.textColor = UMS_TEXT_BLACK;
        _dateRangeMiddleLine.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _dateRangeMiddleLine.text = @"-";
        [self.secondFiltrateView addSubview:_dateRangeMiddleLine];
    }
    return _dateRangeMiddleLine;
}

- (UITextField *)dateRangeEndTF {
    if (!_dateRangeEndTF) {
        _dateRangeEndTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _dateRangeEndTF.placeholder = @"截止日期";
        _dateRangeEndTF.tintColor = UMS_THEME_COLOR;
        _dateRangeEndTF.backgroundColor = UMS_TEXT_FIELD_COLOR;
        if (@available(iOS 13.0, *)) {
            NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:UMS_TEXT_FIELD_PLACEHOLDER_COLOR, NSFontAttributeName:[UIFont UMSChinaLightFontNameOfSize:14.f]} mutableCopy];
            NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"截止日期" attributes:attDic];
            _dateRangeEndTF.attributedPlaceholder = attPlace;
        } else {
            [_dateRangeEndTF setValue:UMS_TEXT_FIELD_PLACEHOLDER_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        }
        _dateRangeEndTF.textColor = UMS_TEXT_BLACK;
        _dateRangeEndTF.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, [YCHManageDevice screenAdaptiveSizeWithIp6Size:30.f])];
        leftView.backgroundColor = [UIColor clearColor];
        _dateRangeEndTF.leftView = leftView;
        _dateRangeEndTF.leftViewMode = UITextFieldViewModeAlways;
        _dateRangeEndTF.delegate = self;
        [self.secondFiltrateView addSubview:_dateRangeEndTF];
    }
    return _dateRangeEndTF;
}

- (UIButton *)secondPageResetBtn {
    if (!_secondPageResetBtn) {
        _secondPageResetBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _secondPageResetBtn.layer.borderColor  = [UIColor whiteColor].CGColor;
        _secondPageResetBtn.layer.borderWidth  = 1;
        _secondPageResetBtn.layer.cornerRadius = 3;
        [_secondPageResetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _secondPageResetBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        [_secondPageResetBtn setTitle:@"重置" forState:UIControlStateNormal];
        _secondPageResetBtn.backgroundColor = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
        [_secondPageResetBtn addTarget:self action:@selector(secondPageReset:) forControlEvents:UIControlEventTouchUpInside];
        [self.secondFiltrateView addSubview:_secondPageResetBtn];
    }
    return _secondPageResetBtn;
}

- (UIButton *)secondPageCommitBtn {
    if (!_secondPageCommitBtn) {
        _secondPageCommitBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _secondPageCommitBtn.layer.borderColor  = [UIColor whiteColor].CGColor;
        _secondPageCommitBtn.layer.borderWidth  = 1;
        _secondPageCommitBtn.layer.cornerRadius = 3;
        [_secondPageCommitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _secondPageCommitBtn.titleLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        [_secondPageCommitBtn setTitle:@"完成" forState:UIControlStateNormal];
        _secondPageCommitBtn.backgroundColor = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
        [_secondPageCommitBtn addTarget:self action:@selector(secondPageCommit:) forControlEvents:UIControlEventTouchUpInside];
        [self.secondFiltrateView addSubview:_secondPageCommitBtn];
    }
    return _secondPageCommitBtn;
}

- (YCHResultNotiTableView *)resultNotiTV {
    if (!_resultNotiTV) {
        _resultNotiTV = [[YCHResultNotiTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _resultNotiTV.resultNotiTVDelegate = self;
        [self.contentView addSubview:_resultNotiTV];
    }
    return _resultNotiTV;
}

- (UIView *)contentView {
    if (! _contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.scrollView addSubview:_contentView];
    }
    return _contentView;
}

- (UIScrollView *)scrollView {
    if (! _scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (BJDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker=[BJDatePicker shareDatePicker];
        [_datePicker.cancelBtn addTarget:self action:@selector(cancelDatePicker) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        [_datePicker datePickerDidSelected:^(NSString *date) {
             if (weakSelf.textFieldTpye == YCHHomePageTextFieldTpyeSecondPageStart) {
                weakSelf.dateRangeStartTF.text=date;
                [weakSelf.dateRangeStartTF resignFirstResponder];
                NSLog(@"第二页面开始时间：%@",date);
            } else if (weakSelf.textFieldTpye == YCHHomePageTextFieldTpyeSecondPageEnd) {
                weakSelf.dateRangeEndTF.text=date;
                [weakSelf.dateRangeEndTF resignFirstResponder];
                NSLog(@"第二页面结束时间：%@",date);
            }
        }];
    }
    return _datePicker;
}

- (YCHAssistExamineTableView *)assitExamineTV {
    if (!_assitExamineTV) {
        _assitExamineTV = [[YCHAssistExamineTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _assitExamineTV.assistExamineTVDelegate = self;
        [self.view addSubview:_assitExamineTV];
    }
    return _assitExamineTV;
}

- (YCHAssistExamineFiltrateView *)firstFiltrateView {
    if (!_firstFiltrateView) {
        _firstFiltrateView = [[YCHAssistExamineFiltrateView alloc] initWithFrame:CGRectZero];
        _firstFiltrateView.backgroundColor = [UIColor colorWithRed:238.0 / 255.0 green:242.0 / 255.0 blue:245.0 /255.0 alpha:1.0];
        _firstFiltrateView.hidden = YES;
        _firstFiltrateView.filtrateViewDelegate = self;
        [_firstFiltrateView.resetBtn addTarget:self action:@selector(firstPageReset) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_firstFiltrateView];
    }
    return _firstFiltrateView;
}

- (YCHHomePageEmptyView *)checkPageEmptyView {
    if (!_checkPageEmptyView) {
        _checkPageEmptyView = [[YCHHomePageEmptyView alloc] initWithFrame:CGRectZero];
        _checkPageEmptyView.hidden = YES;
        [self.view addSubview:_checkPageEmptyView];
    }
    return _checkPageEmptyView;
}

- (YCHHomePageEmptyView *)notiPageEmptyView {
    if (!_notiPageEmptyView) {
        _notiPageEmptyView = [[YCHHomePageEmptyView alloc] initWithFrame:CGRectZero];
        _notiPageEmptyView.hidden = YES;
        [self.view addSubview:_notiPageEmptyView];
    }
    return _notiPageEmptyView;
}

@end
