//
//  YCHDataRangeSelectTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCHDataRangeSelectTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *dateRangeLabel;

@property (nonatomic, strong) UITextField *startTF;

@property (nonatomic, strong) UILabel *middleLineLabel;

@property (nonatomic, strong) UITextField *endTF;

@end

NS_ASSUME_NONNULL_END
