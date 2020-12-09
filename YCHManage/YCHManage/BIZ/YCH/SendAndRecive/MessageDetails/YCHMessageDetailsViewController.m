//
//  YCHMessageDetailsViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHMessageDetailsViewController.h"
#import "YCHMessageDetailsTableView.h"

@interface YCHMessageDetailsViewController ()

@property (nonatomic, strong) NSDictionary *detailDic;

@property (nonatomic, strong) YCHMessageDetailsTableView *messageDetailsTV;

@end

@implementation YCHMessageDetailsViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.detailDic = detailDic;
        [self updateNavigationBar];
        [self initSubViews];
        [self readConfirm];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.messageDetailsTV updateTableViewContentDictionary:self.detailDic];
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
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow_grey"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)initSubViews {
    [self.messageDetailsTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)readConfirm {
    NSString *readStatus = [NSString stringWithFormat:@"%@",self.detailDic[@"isRead"]];
    if ([readStatus isEqual:@"0"]) {
        [[ZBNetworking shaerdInstance] postWithUrl:[NSString stringWithFormat:@"%@%@",YCH_noti_read_confirm_server,self.detailDic[@"id"]] cache:nil params:nil progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
                    
                } successBlock:^(id response) {
                    if (self.messageDetailsViewControllerBlock) {
                        self.messageDetailsViewControllerBlock(YES);
                    }
                } failBlock:^(NSError *error) {
                    
                }];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (YCHMessageDetailsTableView *)messageDetailsTV {
    if (!_messageDetailsTV) {
        _messageDetailsTV = [[YCHMessageDetailsTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_messageDetailsTV];
    }
    return _messageDetailsTV;
}

@end
