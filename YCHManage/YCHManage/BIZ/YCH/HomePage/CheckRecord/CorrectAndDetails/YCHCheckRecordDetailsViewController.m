//
//  YCHCheckRecordDetailsViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/28.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHCheckRecordDetailsViewController.h"
#import "YCHCheckRecordDetailsTableView.h"
#import "YCHBasicInfoScalePictureView.h"

@interface YCHCheckRecordDetailsViewController () <YCHCheckRecordDetailsTableViewDelegate>

@property (nonatomic, strong) NSMutableArray <UIImage *>*mutPicArray;

@property (nonatomic, strong) NSDictionary *detailDic;

@property (nonatomic, strong) YCHBasicInfoScalePictureView *pictureView;

@property (nonatomic, strong) YCHCheckRecordDetailsTableView *checkRecordDetailsTV;

@end

@implementation YCHCheckRecordDetailsViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.detailDic = detailDic;
        [self updateNavigationBar];
        [self initSubViews];
        self.mutPicArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.checkRecordDetailsTV updateTableViewWithItemDic:self.detailDic];
    
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
    
    self.title = @"整改详情";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow_grey"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)updateNavigationBarToBlackColor {
    [self.navigationController.navigationBar updateNaviBarTintColor:[UIColor blackColor] titleColor:[UIColor blackColor] backgroundColor:[UIColor blackColor] needBottomLine:NO needTranslucent:NO];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@""];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil  style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem.title = @"";
}

- (void)initSubViews {
    [self.checkRecordDetailsTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma -mark YCHCheckRecordDetailsTableViewDelegate
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

- (void)checkRecordDetailClickHotelPictureShowSacleImage:(UIImage *)image {
    if (image == nil) {
        return;
    }
    self.pictureView = [[YCHBasicInfoScalePictureView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, Height_Screen - (kIs_iPhoneX ? 88 : 64))];
    [self.pictureView updateViewWihtImage:image];
    [self.pictureView.closeButton addTarget:self action:@selector(closePictureView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pictureView];
    [self updateNavigationBarToBlackColor];
}

- (YCHCheckRecordDetailsTableView *)checkRecordDetailsTV {
    if (!_checkRecordDetailsTV) {
        _checkRecordDetailsTV = [[YCHCheckRecordDetailsTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _checkRecordDetailsTV.checkRecordDetailsTVDelegate = self;
        [self.view addSubview:_checkRecordDetailsTV];
    }
    return _checkRecordDetailsTV;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
