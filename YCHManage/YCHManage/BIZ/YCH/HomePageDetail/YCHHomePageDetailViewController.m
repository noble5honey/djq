//
//  YCHHomePageDetailViewController.m
//  YCHManage
//
//  Created by sunny on 2020/6/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomePageDetailViewController.h"
#import "YCHHomePageDetailTableView.h"
#import "YCHExamineViewController.h"

@interface YCHHomePageDetailViewController ()<YCHHomePagDetaileTableViewDelegate>

@property (nonatomic, strong) NSDictionary *detailDic;

@property (nonatomic, strong) YCHHomePageDetailTableView *detailTableView;

@end

@implementation YCHHomePageDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.detailDic = detailDic;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationBar];
    [self initSubViews];
    [self.detailTableView updateTableViewWithDetailsDic:self.detailDic];
    NSArray *testArray =  @[@{@"displayName" : @"食品卫生内容", @"keyName" : @""}
                            ,@{@"displayName" : @"燃气安全内容", @"keyName" : @""}
                            ,@{@"displayName" : @"消防要求", @"keyName" : @""}
                            ,@{@"displayName" : @"污水排放", @"keyName" : @""}
                            ,@{@"displayName" : @"油烟净化器设备", @"keyName" : @""}
                            ,@{@"displayName" : @"渔家乐人居环境", @"keyName" : @""}
                            ,@{@"displayName" : @"治安情况", @"keyName" : @""}
                            ,@{@"displayName" : @"公共空间", @"keyName" : @""}
                            ,@{@"displayName" : @"渔家乐服务", @"keyName" : @""}
                            ,@{@"displayName" : @"渔家乐证照", @"keyName" : @""}];
    [self.detailTableView reloadDataWithShowElementList:testArray];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar updateNaviBarTintColor:nil titleColor:UMS_TEXT_BLACK backgroundColor:[UIColor whiteColor] needBottomLine:NO needTranslucent:NO];
    
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_NAV_BACKGROUND_COLOR titleColor:UMS_TEXT_BLACK backgroundColor:UMS_NAV_BACKGROUND_COLOR needBottomLine:NO needTranslucent:NO];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar updateNaviBarTintColor:[UIColor clearColor] titleColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor] needBottomLine:NO needTranslucent:YES];
//}

- (void)updateNavigationBar {
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)initSubViews {
    [self.detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma -mark YCHHomePagDetaileTableViewDelegate
- (void)homePageDetailTableViewDidSelectRowWithDetailDic:(NSDictionary *)detailDic {
    YCHExamineViewController *vc = [[YCHExamineViewController alloc] initWithNibName:nil bundle:nil detailDic:detailDic];
    vc.examineViewControllerBlock = ^{
        [YCHManagerToast showToastToView:self.view text:@"上传完成"];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (YCHHomePageDetailTableView *)detailTableView {
    if (!_detailTableView) {
        _detailTableView = [[YCHHomePageDetailTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTableView.homepageDetailTVDelegate = self;
        [self.view addSubview:_detailTableView];
    }
    return _detailTableView;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
