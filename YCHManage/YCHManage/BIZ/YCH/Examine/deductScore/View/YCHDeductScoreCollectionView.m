//
//  YCHDeductScoreCollectionView.m
//  YCHManage
//
//  Created by sunny on 2020/6/30.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHDeductScoreCollectionView.h"
#import "YCHDeductScoreCollectionViewCell.h"

static NSString *deductsScorelCellID = @"deductScore_Cell_ID";

@interface YCHDeductScoreCollectionView ()

@property (nonatomic, strong) NSIndexPath *indexpath;

@end

@implementation YCHDeductScoreCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        self.alwaysBounceVertical = YES;
        [self registCell];
    }
    return self;
}

- (void)registCell {
    [self registerClass:[YCHDeductScoreCollectionViewCell class] forCellWithReuseIdentifier:deductsScorelCellID];
}

- (void)reloadCollectionViewWithIndexPath:(NSIndexPath *)indexPath {
    self.indexpath = indexPath;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YCHDeductScoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:deductsScorelCellID forIndexPath:indexPath];
    [cell updateCellTitle:[NSString stringWithFormat:@"%lu",indexPath.row + 1]];
    if (self.indexpath.length > 0) {
        if (indexPath == self.indexpath) {
            cell.title.backgroundColor = UMS_THEME_COLOR;
        } else {
            cell.title.backgroundColor = [UIColor whiteColor];
        }
    }
//    if (FlashLightManager.channelStr.length == 0) {
//        if (indexPath.row == 0) {
//            cell.title.backgroundColor = Scamera_CollectionCell_Selected;
//        }
//    } else {
//        if (indexPath == self.indexpath || indexPath.row == FlashLightManager.channelStr.integerValue - 1) {
//            cell.title.backgroundColor = Scamera_CollectionCell_Selected;
//        } else {
//            cell.title.backgroundColor = Scamera_CollectionCell_Normal;
//        }
//    }
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.001;
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.001;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YCHDeductScoreCollectionViewCell *cell = (YCHDeductScoreCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.indexpath = indexPath;
     [self reloadData];
    if (self.dectScoreCollectVDelegate && [self.dectScoreCollectVDelegate respondsToSelector:@selector(YCHDeductScoreCollectionViewDidSelectedAtRow:)]) {
        [self.dectScoreCollectVDelegate YCHDeductScoreCollectionViewDidSelectedAtRow:indexPath];
    }
}


@end
