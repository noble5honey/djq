//
//  YCHOverviewViewController.m
//  YCHManage
//
//  Created by sunny on 2020/11/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHOverviewViewController.h"
#import "YCHOverviewTableView.h"
#import "YCHHomePageViewController.h"

@interface YCHOverviewViewController () <YCHOverviewTableViewDelegate>

@property (nonatomic, strong) YCHOverviewTableView *overViewTableView;

@end

@implementation YCHOverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpConstrains];
    self.title = @"渔家乐概览";
    //[self requestOverViewData];
    //延迟请求是因为网络单例还没有创建完成 没有获取到网络状态
    [self performSelector:@selector(requestOverViewData) withObject:nil afterDelay:0.1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_THEME_COLOR titleColor:[UIColor whiteColor] backgroundColor:UMS_THEME_COLOR needBottomLine:NO needTranslucent:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_THEME_COLOR titleColor:[UIColor whiteColor] backgroundColor:UMS_THEME_COLOR needBottomLine:NO needTranslucent:YES];
}

- (void)setUpConstrains {
    [self.overViewTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestOverViewData {
    [YCHManageLodingActivity showLoadingActivityInView:self.view];
    [[ZBNetworking shaerdInstance] getWithUrl:YCH_overView_query_Server cache:nil params:nil progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
            
        } successBlock:^(id response) {
            YCHOverviewPageModel * overviewModel = [YCHOverviewPageModel overviewPageModelWithDict:response[@"data"]];
            [self.overViewTableView updateTableViewWithOverviewModel:overviewModel];
            [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        } failBlock:^(NSError *error) {
            [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        }];
}

#pragma -mark YCHOverviewTableViewDelegate
- (void)requestAllYJL {
    YCHHomePageViewController *vc = [[YCHHomePageViewController alloc] initWithNibName:nil bundle:nil village:nil isNoRectification:nil recentSevenDay:nil recentMonth:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestAllNoRectificationYJL {
    YCHHomePageViewController *vc = [[YCHHomePageViewController alloc] initWithNibName:nil bundle:nil village:nil isNoRectification:YES recentSevenDay:nil recentMonth:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reusetVillageYJLWithVillageType:(villagesButtonType)villagesBtnType {
    NSString *villageStr  = @"";
    bool isNoRectification = nil;
    switch (villagesBtnType) {
        case villagesButtonTypeQingShuiVillage:
            villageStr = @"清水村";
            isNoRectification = nil;
            break;
        case villagesButtonTypeQingShuiVillageNo:
            villageStr = @"清水村";
            isNoRectification = YES;
            break;
        case villagesButtonTypeXinJingVillage:
            villageStr = @"新泾村";
            isNoRectification = nil;
            break;
        case villagesButtonTypeXinJingVillageNo:
            villageStr = @"新泾村";
            isNoRectification = YES;
            break;
        case villagesButtonTypeYuYeVillage:
            villageStr = @"渔业村";
            isNoRectification = nil;
            break;
        case villagesButtonTypeYuYeVillageNo:
            villageStr = @"渔业村";
            isNoRectification = YES;
            break;
        case villagesButtonTypeLianHuaVillage:
            villageStr = @"莲花村";
            isNoRectification = nil;
            break;
        case villagesButtonTypeLianhuaVillageNo:
            villageStr = @"莲花村";
            isNoRectification = YES;
            break;
        case villagesButtonTypeYangGouVillage:
            villageStr = @"洋沟溇村";
            isNoRectification = nil;
            break;
        case villagesButtonTypeYangGouVillageNO:
            villageStr = @"洋沟溇村";
            isNoRectification = YES;
            break;
        case villagesButtonTypeTianJinVillage:
            villageStr = @"沺泾社区";
            isNoRectification = nil;
            break;
        case villagesButtonTypeTianJinVillageNo:
            villageStr = @"沺泾社区";
            isNoRectification = YES;
            break;
        default:
            break;
    }
    YCHHomePageViewController *vc = [[YCHHomePageViewController alloc] initWithNibName:nil bundle:nil village:villageStr isNoRectification:isNoRectification recentSevenDay:nil recentMonth:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requsetRecentCheckYJLWithCheckType:(recentCheckType)recentCheckType {
    NSString *recentSevenDay = @"";
    NSString *recentMonth = @"";
    bool isNoRectification = nil;
    switch (recentCheckType) {
        case recentCheckTypeSevenDay:
            recentSevenDay = [NSString getCurrentTimestamp];
            recentMonth = nil;
            isNoRectification = nil;
            break;
        case recentCheckTypeSevenDayNo:
            recentSevenDay = [NSString getCurrentTimestamp];
            recentMonth = nil;
            isNoRectification = YES;
            break;
        case recentCheckTypeMonth:
            recentSevenDay = nil;
            recentMonth = [NSString getCurrentTimestamp];
            isNoRectification = nil;
            break;
        case recentCheckTypeMonthNo:
            recentSevenDay = nil;
            recentMonth = [NSString getCurrentTimestamp];
            isNoRectification = YES;
            break;
        default:
            break;
    }
    YCHHomePageViewController *vc = [[YCHHomePageViewController alloc] initWithNibName:nil bundle:nil village:nil isNoRectification:isNoRectification recentSevenDay:recentSevenDay recentMonth:recentMonth];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (YCHOverviewTableView *)overViewTableView {
    if (!_overViewTableView) {
        _overViewTableView = [[YCHOverviewTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _overViewTableView.overviewDelegate = self;
        [self.view addSubview:_overViewTableView];
    }
    return _overViewTableView;
}

@end
