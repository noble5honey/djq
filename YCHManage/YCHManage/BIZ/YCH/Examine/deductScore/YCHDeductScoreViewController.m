//
//  YCHDeductScoreViewController.m
//  YCHManage
//
//  Created by sunny on 2020/6/30.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHDeductScoreViewController.h"
#import "YCHDeductScoreCollectionView.h"

@interface YCHDeductScoreViewController ()<YCHDeductScoreCollectionViewDelegate>

@property (nonatomic, strong) YCHDeductScoreCollectionView *deductScoreView;

@end

@implementation YCHDeductScoreViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setUpConstrains];
        [self updateNavigation];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil indexPath:(NSIndexPath *)indexPath {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.indexPath = indexPath;
        [self setUpConstrains];
        [self updateNavigation];
        [self.deductScoreView reloadCollectionViewWithIndexPath:indexPath];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateNavigation {
    self.title = @"扣除分数";
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"navi_back_arrow"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)setUpConstrains {
    
    [self.deductScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma -mark YCHDeductScoreCollectionViewDelegate
- (void)YCHDeductScoreCollectionViewDidSelectedAtRow:(NSIndexPath *)indexPath {
    if (self.blockparameter) {
        self.blockparameter(indexPath);
    }
    [self back];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (YCHDeductScoreCollectionView *)deductScoreView {
    if (!_deductScoreView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake((Width_Screen - 60)/4, 100 )];
        flowLayout.sectionInset = UIEdgeInsetsMake(13, 14, 20, 14);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _deductScoreView = [[YCHDeductScoreCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _deductScoreView.dectScoreCollectVDelegate = self;
        [self.view addSubview:_deductScoreView];
    }
    return _deductScoreView;
}


@end
