//
//  YCHExamineViewController.m
//  YCHManage
//
//  Created by sunny on 2020/6/28.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHExamineViewController.h"
#import "UMSImagePicker.h"
#import "YCHExamineTableView.h"
#import "YCHDeductScoreViewController.h"
#import "YCHExamineDeductItemViewController.h"

@interface YCHExamineViewController ()<YCHExamineTableViewDelegate>

@property (nonatomic, strong) NSDictionary *detailDic;

@property (nonatomic, strong) UMSImagePicker *imagePicker;

@property (nonatomic, strong)  YCHExamineTableView *examineTableView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSDictionary *deductItemDic;

@property (nonatomic, strong) NSMutableArray <UIImage *>*mutPicArray;

@property (nonatomic, strong) YCHExamineTableViewCell *addPhotoCell;

@property (nonatomic, strong) NSIndexPath *selectedIndex;

@property (nonatomic, strong) NSString *textViewStr;

@property (nonatomic, strong) NSString *textFieldStr;

@end

@implementation YCHExamineViewController

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar updateNaviBarTintColor:UMS_NAV_BACKGROUND_COLOR titleColor:UMS_TEXT_BLACK backgroundColor:UMS_NAV_BACKGROUND_COLOR needBottomLine:NO needTranslucent:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)updateNavigationBar {
    self.title = @"检查";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow_grey"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)initSubViews {
    [self.examineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)uploadImageToServerWithData:(NSData *)data {
//    self.addPhotoCell.showImageView.image
//    self.addPhotoCell.secondImageView.image
}

#pragma -mark YCHExamineTableViewDelegate
- (void)exmineTableViewClickDeductItemCell {
    YCHExamineDeductItemViewController *vc = [[YCHExamineDeductItemViewController alloc] initWithNibName:nil bundle:nil indexPath:self.selectedIndex];
    vc.blockparameter = ^(NSDictionary *selectedDic,NSIndexPath *indexPath) {
        self.deductItemDic = selectedDic;
        // @{@"itemName" : @"有无干手设备或擦手纸巾", @"itemKey" : @"012", @"grades" : @"1"}
        self.selectedIndex = indexPath;
        [self.examineTableView updateTableViewCellWithDictionary:selectedDic];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableViewDidSelectRow:(YCHBaseTableViewCell *)cell {
//    YCHDeductScoreViewController *vc = [[YCHDeductScoreViewController alloc]initWithNibName:nil bundle:nil indexPath:self.indexPath];
//    vc.blockparameter = ^(NSIndexPath *indexPath) {
//        self.indexPath = indexPath;
//        cell.titleContentLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)examineTableViewTextViewDidChange:(UITextView *)textView {
    self.textViewStr = textView.text;
    NSLog(@"TextView输入的文字:%@",textView.text);
}

- (void)examineTableViewTextFieldDidChange:(UITextField *)textField {
    self.textFieldStr = textField.text;
    NSLog(@"TextField输入的文字:%@",textField.text);
}

//提交按钮
- (void)examineTableViewClickCommitButton {
    NSString *matterName = [NSString stringWithFormat:@"%@",self.deductItemDic[@"matterName"]];
    if (matterName.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请填选择扣分选项"];
        return;
    }
    //[1]    (null)    @"matterCode" : @"noMatterScore"
    if (![self.deductItemDic[@"matterCode"] isEqual:@"noMatterScore"] || self.textFieldStr.length == 0) {
        [YCHManagerToast showToastToView:self.view text:@"请填整改期限"];
        return;
    }
    if (self.textViewStr.length == 0 || [self.textViewStr isEqualToString:@""]) {
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
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        [YCHManagerToast showToastToView:self.view text:@"照片上传失败"];
    }];
}

- (void)getPictureURLAndToRequest:(NSArray *)urlArray {
    NSMutableDictionary *temParamDict = [NSMutableDictionary dictionary];
    temParamDict[@"matterCode"] = self.deductItemDic[@"matterCode"];
    temParamDict[@"fishId"] = self.detailDic[@"id"];
    temParamDict[@"checkPicIos"] = urlArray;
    temParamDict[@"checkRemarks"] = self.textViewStr;
    temParamDict[@"createTime"] = [NSString getCurrentTimestamp];
    if (self.textFieldStr.length > 0) {
        temParamDict[@"rectificationPeriod"] = self.textFieldStr;
    } else {
        temParamDict[@"rectificationPeriod"] = @"";
    }
    [[ZBNetworking shaerdInstance] postWithUrl:YCH_examine_new_add cache:nil params:temParamDict progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
    } successBlock:^(id response) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        [YCHManagerToast showToastToView:self.view text:@"检查记录新增成功" time:2 completion:^{
            if (self.examineViewControllerBlock) {
                self.examineViewControllerBlock();
                [self back];
            }
        }];
    } failBlock:^(NSError *error) {
        [YCHManageLodingActivity hideLoadingActivityInView:self.view];
        [YCHManagerToast showToastToView:self.view text:[NSString stringWithFormat:@"%@",error] time:2 completion:^{
        }];
    }];
}

- (void)addImageActionWithCell:(YCHExamineTableViewCell *)cell {
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
        
//        [strongSelf uploadImageToServerWithData:UIImageJPEGRepresentation(image, 1.0f)];
    }];
}

- (void)exmineTableViewClickSecondButtonWithCell:(YCHExamineTableViewCell *)cell {
    [self.imagePicker addPhotoPickerToViewController:self quailityType:UMSPhotoPickerJPGQuailityTypeHigh imageSize:CGSizeMake(200, 600) completedBlock:^(UIImage *image) {
        cell.secondImageView.image = image;
    }];
}

- (void)exmineTableViewClickThirdButtonWithCell:(YCHExamineTableViewCell *)cell {
    [self.imagePicker addPhotoPickerToViewController:self quailityType:UMSPhotoPickerJPGQuailityTypeHigh imageSize:CGSizeMake(200, 600) completedBlock:^(UIImage *image) {
        cell.thirdImageView.image = image;
    }];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (YCHExamineTableView *)examineTableView {
    if (!_examineTableView) {
        _examineTableView = [[YCHExamineTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _examineTableView.examineDelegate = self;
    
        [self.view addSubview:_examineTableView];
    }
    return _examineTableView;
}

@end
