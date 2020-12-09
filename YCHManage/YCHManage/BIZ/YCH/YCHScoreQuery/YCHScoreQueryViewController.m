//
//  YCHScoreQueryViewController.m
//  YCHManage
//
//  Created by sunny on 2020/6/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHScoreQueryViewController.h"
#import "YCHScoreQueryTopView.h"
#import "YCHScoreQueryTableView.h"

@interface YCHScoreQueryViewController () <UISearchBarDelegate>

@property (nonatomic, strong) YCHScoreQueryTopView *topView;

@property (nonatomic, strong) YCHScoreQueryTableView *scoreQueryTBView;

@end

@implementation YCHScoreQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationBar];
    [self initSubViews];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:nil titleColor:UMS_TEXT_BLACK backgroundColor:[UIColor whiteColor] needBottomLine:NO needTranslucent:NO];
}

- (void)updateNavigationBar {
    self.navigationItem.title = @"渔家乐查询";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)initSubViews {
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.mas_equalTo(60.f);
    }];
    
    [self.scoreQueryTBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
    }];
}

- (void)searchScore {
    [self.topView.searchBar resignFirstResponder];
    NSString *searchStr = self.topView.searchBar.text;
    NSLog(@"搜索的内容%@",searchStr);
    
    NSArray *testArray =
    @[@{@"date" : @"2020/05/30", @"item" : @"燃气安全", @"reason" : @"XXXXX123123", @"value" : @"2"},
      @{@"date" : @"2020/05/30", @"item" : @"燃气安全", @"reason" : @"XXXXX123123", @"value" : @"2"},
      @{@"date" : @"2020/05/30", @"item" : @"燃气安全", @"reason" : @"XXXXX123123", @"value" : @"2"},
      @{@"date" : @"2020/05/30", @"item" : @"燃气安全", @"reason" : @"XXXXX123123", @"value" : @"2"}
      ];
    [self.scoreQueryTBView updateTableViewWithItemArray:testArray];
    [self.scoreQueryTBView updateTableViewWithReamianValue:@"92"];
    self.scoreQueryTBView.hidden = NO;
    [self.topView.searchBar setShowsCancelButton:NO animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.topView.searchBar resignFirstResponder];
    [self.topView.searchBar setShowsCancelButton:NO animated:YES];
}

#pragma -mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"开始输入搜索内容");
    [searchBar setShowsCancelButton:YES animated:YES]; // 动画显示取消按钮
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.scoreQueryTBView.hidden = YES;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchScore];
}

- (YCHScoreQueryTopView *)topView {
    if (!_topView) {
        _topView = [[YCHScoreQueryTopView alloc] initWithFrame:CGRectZero];
        [_topView.confirmBtn addTarget:self action:@selector(searchScore) forControlEvents:UIControlEventTouchUpInside];
        _topView.searchBar.delegate = self;
        [self.view addSubview:_topView];
    }
    
    return _topView;
}

- (YCHScoreQueryTableView *)scoreQueryTBView {
    if (!_scoreQueryTBView) {
        _scoreQueryTBView = [[YCHScoreQueryTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _scoreQueryTBView.hidden = YES;
//        _scoreQueryTBView.bounces=NO;
        [self.view addSubview:_scoreQueryTBView];
    }
    return _scoreQueryTBView;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
