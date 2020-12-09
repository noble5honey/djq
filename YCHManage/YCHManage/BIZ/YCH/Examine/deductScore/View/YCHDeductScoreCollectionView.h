//
//  YCHDeductScoreCollectionView.h
//  YCHManage
//
//  Created by sunny on 2020/6/30.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCHDeductScoreCollectionViewDelegate <NSObject>

- (void)YCHDeductScoreCollectionViewDidSelectedAtRow:(NSIndexPath *)indexPath;

@end

@interface YCHDeductScoreCollectionView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id<YCHDeductScoreCollectionViewDelegate> dectScoreCollectVDelegate;

- (void)reloadCollectionViewWithIndexPath:(NSIndexPath *)indexPath;

@end
