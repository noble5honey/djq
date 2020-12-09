//
//  YCHBasicInformationTableView.h
//  YCHManage
//
//  Created by sunny on 2020/9/14.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCHBasicInformationTableViewDelegate <NSObject>

- (void)clickHotelPictureShowSacleImage:(UIImage *)image;

@end

@interface YCHBasicInformationTableView : UITableView

@property (nonatomic, weak) id<YCHBasicInformationTableViewDelegate> basicInfoTVDeleagte;

- (void)updateTableViewWithBasicInfoDictionary:(NSDictionary *)basicInfoDic;

- (void)updateTableViewWithHotelPictureArray:(NSArray *)picArray;

@end

