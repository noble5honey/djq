//
//  YCHAssistExamineDetailsViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAssistExamineDetailsViewController.h"
#import "YCHAssistExamineDetailsTableView.h"

@interface YCHAssistExamineDetailsViewController ()

@property (nonatomic, strong) NSDictionary *detailDic;

@property (nonatomic, strong) YCHAssistExamineDetailsTableView *assistExamineDetailsTV;

@end

@implementation YCHAssistExamineDetailsViewController
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
    [self.assistExamineDetailsTV updateTableViewContentDictionary:self.detailDic];
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
    [self.assistExamineDetailsTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)readConfirm {
    NSString *readStatus = [NSString stringWithFormat:@"%@",self.detailDic[@"isRead"]];
    if ([readStatus isEqual:@"0"]) {
        [[ZBNetworking shaerdInstance] postWithUrl:[NSString stringWithFormat:@"%@%@",YCH_exmine_read_confirm_server,self.detailDic[@"id"]] cache:nil params:nil progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
                    
                } successBlock:^(id response) {
                    if (self.assistExamineDetailsViewControllerBlock) {
                        self.assistExamineDetailsViewControllerBlock(YES);
                    }
                } failBlock:^(NSError *error) {
                    
                }];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (YCHAssistExamineDetailsTableView *)assistExamineDetailsTV {
    if (!_assistExamineDetailsTV) {
        _assistExamineDetailsTV = [[YCHAssistExamineDetailsTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_assistExamineDetailsTV];
    }
    return _assistExamineDetailsTV;
}


@end
