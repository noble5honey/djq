//
//  YCHBasicInformationViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/14.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHBasicInformationViewController.h"
#import "YCHBasicInformationTableView.h"
#import "YCHBasicInfoScalePictureView.h"

@interface YCHBasicInformationViewController () <YCHBasicInformationTableViewDelegate>

@property (nonatomic, strong) NSDictionary *detailDic;

@property (nonatomic, strong) YCHBasicInformationTableView *basicInfoTableView;

@property (nonatomic, strong) YCHBasicInfoScalePictureView *pictureView;

@end

@implementation YCHBasicInformationViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic {
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.detailDic = detailDic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateNavigationBar];
    [self initSubViews];
    [self.basicInfoTableView updateTableViewWithBasicInfoDictionary:self.detailDic];
//    [self downloadImage];
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
    self.title = @"基本信息";
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
    self.navigationItem.leftBarButtonItem.title = @"";
}

- (void)initSubViews {
    [self.basicInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

//- (void)downloadImage {
//    NSMutableArray *picArray = [NSMutableArray array];
//    NSArray *imageArray = self.detailDic[@"fishPicIos"];
//    if (imageArray.count > 0) {
//        if (imageArray.count > 3) {
//            return;
//        }
//        for (int i = 0; i < imageArray.count; i++) {
//            [[ZBNetworking shaerdInstance] downloadWithUrl:imageArray[i] progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
//
//            } successBlock:^(UIImage *image) {
//                [picArray addObject:image];
//                [self.basicInfoTableView updateTableViewWithHotelPictureArray:picArray];
//            } failBlock:^(NSError *error) {
//
//            }];
//        }
//    }
//}

#pragma -mark YCHBasicInformationTableViewDelegate
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

- (YCHBasicInformationTableView *)basicInfoTableView {
    if (!_basicInfoTableView) {
        _basicInfoTableView = [[YCHBasicInformationTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _basicInfoTableView.basicInfoTVDeleagte = self;
        [self.view addSubview:_basicInfoTableView];
    }
    return _basicInfoTableView;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
