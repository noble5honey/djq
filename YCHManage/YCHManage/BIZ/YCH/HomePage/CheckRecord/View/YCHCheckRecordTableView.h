//
//  YCHCheckRecordTableView.h
//  YCHManage
//
//  Created by sunny on 2020/9/15.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CheckRecord_DetailsButton      20200929
#define CheckRecord_CorrectButton      20200930
//typedef NS_ENUM(NSUInteger, YCHCorrectOrDetailsTpye) {
//    YCHCheckRecordTypeCorrect = 0,
//    YCHCheckRecordTypeDetails
//};

@protocol YCHCheckRecordTableViewDelegate <NSObject>

- (void)clickHotelPictureShowSacleImage:(UIImage *)image;

- (void)checkRecoredTableViewDidScroll;

- (void)checkRecordTableViewDidSelected;

- (void)clickCorrectOrDetailsButton:(UIButton *)btn contentDic:(NSDictionary *)contentDic;

@end

@interface YCHCheckRecordTableView : UITableView

@property (nonatomic, weak) id<YCHCheckRecordTableViewDelegate> checkRecordTVDeleagte;

- (void)updateTableViewWithItemArray:(NSArray *)itemArray;

@end
