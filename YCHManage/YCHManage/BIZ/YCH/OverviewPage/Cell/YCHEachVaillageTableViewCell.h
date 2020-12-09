//
//  YCHEachVaillageTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/11/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, villagesButtonType) {
    villagesButtonTypeQingShuiVillage = 20201124,
    villagesButtonTypeQingShuiVillageNo,
    villagesButtonTypeXinJingVillage,
    villagesButtonTypeXinJingVillageNo,
    villagesButtonTypeYuYeVillage,
    villagesButtonTypeYuYeVillageNo,
    villagesButtonTypeLianHuaVillage,
    villagesButtonTypeLianhuaVillageNo,
    villagesButtonTypeYangGouVillage,
    villagesButtonTypeYangGouVillageNO,
    villagesButtonTypeTianJinVillage,
    villagesButtonTypeTianJinVillageNo
};

typedef NS_ENUM(NSInteger, recentCheckType) {
    recentCheckTypeSevenDay = 30201124,
    recentCheckTypeSevenDayNo,
    recentCheckTypeMonth,
    recentCheckTypeMonthNo
};

@interface YCHEachVaillageTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *contentBackgroundView;

@property (nonatomic, strong) UILabel *headerLabel;

@property (nonatomic, strong) UIButton *allQingShuiBtn;

@property (nonatomic, strong) UIButton *qingShuiNOCorrectBtn;

@property (nonatomic, strong) UIButton *allXinJingBtn;

@property (nonatomic, strong) UIButton *xinJingNOCorrectBtn;

@property (nonatomic, strong) UIButton *allYangGouBtn;

@property (nonatomic, strong) UIButton *yangGouNOCorrectBtn;

@property (nonatomic, strong) UIButton *lianHuaBtn;

@property (nonatomic, strong) UIButton *lianHuaNOCorrectBtn;

@property (nonatomic, strong) UIButton *allyuYeBtn;

@property (nonatomic, strong) UIButton *yuYeNOCorrectBtn;

@property (nonatomic, strong) UIButton *allJingTianBtn;

@property (nonatomic, strong) UIButton *jingTianNOCorrectBtn;

- (void)updateCellWithHeaderTitle:(NSString *)headerTitle BtnQingshui:(NSString *)qingshui qingshuiTwo:(NSString *)qingshuiTwo xinjing:(NSString *)xinjing xinjingTwo:(NSString *)xinjingTwo yanggou:(NSString *)yanggou yanggouTwo:(NSString *)yanggouTwo lianhua:(NSString *)lianhua lianhuaTwo:(NSString *)lianhuaTwo yuye:(NSString *)yuye yuyeTwo:(NSString *)yuyeTwo tianjing:(NSString *)tianjing tianjingTwo:(NSString *)tianjingTwo;

- (void)updateCellWithHeaderTitle:(NSString *)headerTitle BtnQingshui:(NSString *)qingshui qingshuiTwo:(NSString *)qingshuiTwo xinjing:(NSString *)xinjing xinjingTwo:(NSString *)xinjingTwo;

@end

NS_ASSUME_NONNULL_END
