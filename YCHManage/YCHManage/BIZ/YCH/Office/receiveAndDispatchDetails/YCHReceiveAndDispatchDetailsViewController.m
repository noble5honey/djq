//
//  YCHReceiveAndDispatchDetailsViewController.m
//  YCHManage
//
//  Created by sunny on 2020/7/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHReceiveAndDispatchDetailsViewController.h"
#import "YCHReceiveAndDispatchDetailsTableView.h"

@interface YCHReceiveAndDispatchDetailsViewController () <YCHReceiveAndDispatchDetailsTableViewDelegate>

@property (nonatomic, strong) NSDictionary *detailDic;

@property (nonatomic, strong) YCHReceiveAndDispatchDetailsTableView *detailTableView;

@property (nonatomic, strong) NSString *contentStr;

@end

@implementation YCHReceiveAndDispatchDetailsViewController
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
    [self.detailTableView updateTableViewWithItemArray:self.detailDic];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_NAV_BACKGROUND_COLOR titleColor:UMS_TEXT_BLACK backgroundColor:UMS_NAV_BACKGROUND_COLOR needBottomLine:NO needTranslucent:NO];
}

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

#pragma -mark YCHReceiveAndDispatchDetailsTableViewDelegate
- (void)YCHReceiveAndDispatchDetailsTableViewTextViewDidChange:(UITextView *)textView {
    self.contentStr = textView.text;
}

- (void)reveceiveAndDispatchDetailsTableViewClickRevokeButton {
    
}

- (void)reveceiveAndDispatchDetailsTableViewClickDeleteButton {
    
}

- (YCHReceiveAndDispatchDetailsTableView *)detailTableView {
    if (!_detailTableView) {
        _detailTableView = [[YCHReceiveAndDispatchDetailsTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTableView.detailsTVDelegate = self;
        [self.view addSubview:_detailTableView];
    }
    return _detailTableView;
}

- (void)back {
    if (self.examineViewControllerBlock) {
        self.examineViewControllerBlock();
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
