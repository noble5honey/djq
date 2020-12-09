//
//  YCHCorrectAndDetailsViewController.m
//  YCHManage
//
//  Created by sunny on 2020/9/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHCorrectAndDetailsViewController.h"
#import "YCHCorrectAndDetailsTableVIew.h"
#import "YCHBasicInfoScalePictureView.h"
#import "UMSImagePicker.h"

@interface YCHCorrectAndDetailsViewController () <YCHCorrectAndDetailsTableVIewDelegate>

@property (nonatomic, strong) NSDictionary *detailDic;

@property (nonatomic, assign) YCHCorrectOrDetailsTpye correctOrDetailsTpye;

@property (nonatomic, strong) YCHCorrectAndDetailsTableVIew *correctAndDetailsTV;

@property (nonatomic, strong) YCHBasicInfoScalePictureView *pictureView;

@property (nonatomic, strong) UMSImagePicker *imagePicker;

@property (nonatomic, strong) YCHExamineTableViewCell *addPhotoCell;

@property (nonatomic, strong) NSMutableArray <UIImage *>*mutPicArray;

@property (nonatomic, strong) NSString *remarksStr;

@end

@implementation YCHCorrectAndDetailsViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailDic:(NSDictionary *)detailDic type:(YCHCorrectOrDetailsTpye)type{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.detailDic = detailDic;
        self.correctOrDetailsTpye = type;
        [self updateNavigationBar];
        [self initSubViews];
        self.mutPicArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.correctAndDetailsTV updateTableViewWithItemDic:self.detailDic];
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
    self.title = @"整改";
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
    [self.correctAndDetailsTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma -mark YCHCorrectAndDetailsTableVIewDelegate
- (void)clickHotelPictureShowSacleImage:(UIImage *)image {
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

- (void)correctAndDetailsTableViewTextViewDidChange:(UITextView *)textView {
    NSLog(@"TextView输入的文字:%@",textView.text);
    self.remarksStr = textView.text;
}

- (void)correctAndDetailsTableViewClickCommitButton {
    if (self.remarksStr.length == 0 || [self.remarksStr isEqualToString:@""]) {
        [YCHManagerToast showToastToView:self.view text:@"请填写相关记录"];
        return;
    }
    if (self.addPhotoCell.secondImageView.image == nil) {
        [YCHManagerToast showToastToView:self.view text:@"请上传图片"];
        return;
    }
    [YCHManageLodingActivity showLoadingActivityInView:self.view];
    NSMutableArray *picDataMutArray = [NSMutableArray array];
    NSMutableArray *picUrlMutArray = [NSMutableArray array];
    if (self.addPhotoCell.showImageView.image != nil) {
        NSData *data = UIImageJPEGRepresentation(self.addPhotoCell.showImageView.image,1.0);
        [picDataMutArray addObject:data];
    }
    if (self.addPhotoCell.secondImageView.image != nil) {
        NSData *data = UIImageJPEGRepresentation(self.addPhotoCell.secondImageView.image,1.0);
        [picDataMutArray addObject:data];
    }
    if (self.addPhotoCell.thirdImageView.image != nil) {
        NSData *data = UIImageJPEGRepresentation(self.addPhotoCell.thirdImageView.image,1.0);
        [picDataMutArray addObject:data];
    }
    [[ZBNetworking shaerdInstance] uploadMultFileWithUrl:YCH_upload_file_Server fileDatas:picDataMutArray name:@"file" fileName:@"ios.jpg" mimeType:@"image/jpeg" progressBlock:^(int64_t bytesWritten, int64_t totalBytes) {
        
    } successBlock:^(NSArray *responses) {
        for (int i = 0; i < responses.count; i++) {
            [picUrlMutArray addObject:responses[i][@"data"]];
        }
        if (picUrlMutArray.count == picDataMutArray.count) {
            [self getPictureURLAndToRequest:picUrlMutArray];
        }
    } failBlock:^(NSArray *errors) {
        
    }];
//    dispatch_queue_t queue = dispatch_queue_create("getPicUrlQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
//    for (int i = 0; i < picDataMutArray.count; i++) {
//        //后台只能一张张接收上传照片  拿到照片相对地址去请求接下来整改接口
//        dispatch_async(queue, ^{
//            // 这里放同步执行任务代码
//            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//            NSLog(@"执行第%d次",i);
//            [[ZBNetworking shaerdInstance] uploadFileWithUrl:YCH_upload_file_Server fileData:picDataMutArray[i] name:@"file" fileName:@"ios.jpg" mimeType:@"image/jpeg" progressBlock:^(int64_t bytesWritten, int64_t totalBytes) {
//            } successBlock:^(id response) {
//                [picUrlMutArray addObject:response[@"data"]];
//                if (picUrlMutArray.count == picDataMutArray.count) {
//                    [self getPictureURLAndToRequest:picUrlMutArray];
//                }
//                dispatch_semaphore_signal(sema);
//            } failBlock:^(NSError *error) {
//
//            }];
//        });
//    }
}

- (void)getPictureURLAndToRequest:(NSArray *)urlArray {
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"checkId"] = self.detailDic[@"id"];
    temParamDict[@"fishId"] = self.detailDic[@"fishId"];
    temParamDict[@"rectificationRemark"] = self.remarksStr;
    temParamDict[@"rectificationPicIos"] = urlArray;
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_examine_correct_Server cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        [YCHManagerToast showToastToView:self.view text:@"整改成功" time:2 completion:^{
            if (self.blockparameter) {
                self.blockparameter(YES);
            }
            [self back];
        }];
    } failBlock:^(NSError *error) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        [YCHManagerToast showToastToView:self.view text:[NSString stringWithFormat:@"%@",error] time:2 completion:^{
            if (self.blockparameter) {
                self.blockparameter(NO);
            }
            [self back];
        }];
    }];
}

- (void)correctAndDetailTableViewClickFirstButtonWithCell:(YCHExamineTableViewCell *)cell {
    self.addPhotoCell = cell;
    self.imagePicker = [[UMSImagePicker alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.imagePicker addPhotoPickerToViewController:self quailityType:UMSPhotoPickerJPGQuailityTypeHigh imageSize:CGSizeMake(200, 600) completedBlock:^(UIImage *image) {
        if (weakSelf.mutPicArray.count == 2) {
            cell.addImageView.hidden = YES;
            cell.showImageView.image = image;
        } else {
            [weakSelf.mutPicArray addObject:image];
            [cell nativeUpdateCellPictureWithPictureArray:weakSelf.mutPicArray];
        }
        
    }];
}

- (void)correctAndDetailTableViewClickSecondButtonWithCell:(YCHExamineTableViewCell *)cell {
    [self.imagePicker addPhotoPickerToViewController:self quailityType:UMSPhotoPickerJPGQuailityTypeHigh imageSize:CGSizeMake(200, 600) completedBlock:^(UIImage *image) {
        cell.secondImageView.image = image;
    }];
}

- (void)correctAndDetailTableViewClickThirdButtonWithCell:(YCHExamineTableViewCell *)cell {
    [self.imagePicker addPhotoPickerToViewController:self quailityType:UMSPhotoPickerJPGQuailityTypeHigh imageSize:CGSizeMake(200, 600) completedBlock:^(UIImage *image) {
        cell.thirdImageView.image = image;
    }];
}

- (YCHCorrectAndDetailsTableVIew *)correctAndDetailsTV {
    if (!_correctAndDetailsTV) {
        _correctAndDetailsTV = [[YCHCorrectAndDetailsTableVIew alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _correctAndDetailsTV.correctAndDetailsTVDelegate = self;
        [self.view addSubview:_correctAndDetailsTV];
    }
    return _correctAndDetailsTV;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
