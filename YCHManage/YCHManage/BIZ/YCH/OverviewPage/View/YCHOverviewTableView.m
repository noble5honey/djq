//
//  YCHOverviewTableView.m
//  YCHManage
//
//  Created by sunny on 2020/11/19.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHOverviewTableView.h"
#import "YCHOverviewTableViewCell.h"
#import "YCHScrollBannerTableViewCell.h"
#import "YCHEachVillageModel.h"

static NSString * overviewCellID = @"overview_page_cell_id";
static NSString * eachVaillageCellID = @"each_vaillage_cell_id";
static NSString * scrollBannerCellID = @"scroll_banner_cell_id";

@interface YCHOverviewTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YCHOverviewPageModel *overviewModel;

@end

@implementation YCHOverviewTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHOverviewTableViewCell class] forCellReuseIdentifier:overviewCellID];
        [self registerClass:[YCHEachVaillageTableViewCell class] forCellReuseIdentifier:eachVaillageCellID];
        [self registerClass:[YCHScrollBannerTableViewCell class] forCellReuseIdentifier:scrollBannerCellID];
    }
    return self;
}

- (void)updateTableViewWithOverviewModel:(YCHOverviewPageModel *)overviewModel {
    self.overviewModel = overviewModel;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        YCHOverviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:overviewCellID forIndexPath:indexPath];
        [cell updateCellHeaderString:@"全部渔家乐" firstTitle:@"全部渔家乐" firstTotal:[NSString stringWithFormat:@"%@家",self.overviewModel.totalFishNum] secondTitle:@"未整改渔家乐" secondTotal:[NSString stringWithFormat:@"%@家",self.overviewModel.notRectifiedNum]];
        if ([UserCenter.userType isEqual:@"com"]) {
            cell.firstLogoButton.enabled = NO;
            cell.secondLogoButton.enabled = NO;
            cell.fisrTitleLabel.textColor = UMS_GRAY_200;
            cell.firstTotalLaebl.textColor = UMS_GRAY_200;
            cell.secondTitleLabel.textColor = UMS_GRAY_200;
            cell.secondTotalLabel.textColor = UMS_GRAY_200;
            return cell;
        } else {
            cell.firstLogoButton.enabled = YES;
            cell.secondLogoButton.enabled = YES;
            cell.fisrTitleLabel.textColor = UMS_TEXT_BLACK;
            cell.firstTotalLaebl.textColor = UMS_TEXT_BLACK;
            cell.secondTitleLabel.textColor = UMS_TEXT_BLACK;
            cell.secondTotalLabel.textColor = UMS_TEXT_BLACK;
        }
        [cell.firstLogoButton addTarget:self action:@selector(requestAll) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondLogoButton addTarget:self action:@selector(requestAllNoRectification) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else if (indexPath.row == 1){
        YCHEachVillageModel *qingshui;
        YCHEachVillageModel *xinjing;
        YCHEachVillageModel *yuye;
        YCHEachVillageModel *lianhua;
        YCHEachVillageModel *yanggou;
        YCHEachVillageModel *tianjing;
        for (int i = 0; i < self.overviewModel.villageFishNumList.count; i++) {
            if ([self.overviewModel.villageFishNumList[i].fishArea isEqual:@"清水村"]) {
                qingshui = self.overviewModel.villageFishNumList[i];
            }
            if ([self.overviewModel.villageFishNumList[i].fishArea isEqual:@"新泾村"]) {
                xinjing = self.overviewModel.villageFishNumList[i];
            }
            if ([self.overviewModel.villageFishNumList[i].fishArea isEqual:@"渔业村"]) {
                yuye = self.overviewModel.villageFishNumList[i];
            }
            if ([self.overviewModel.villageFishNumList[i].fishArea isEqual:@"莲花村"]) {
                lianhua = self.overviewModel.villageFishNumList[i];
            }
            if ([self.overviewModel.villageFishNumList[i].fishArea isEqual:@"洋沟溇村"]) {
                yanggou = self.overviewModel.villageFishNumList[i];
            }
            if ([self.overviewModel.villageFishNumList[i].fishArea isEqual:@"沺泾社区"]) {
                tianjing = self.overviewModel.villageFishNumList[i];
            }
        }
        YCHEachVaillageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:eachVaillageCellID forIndexPath:indexPath];
        [cell updateCellWithHeaderTitle:@"各村渔家乐" BtnQingshui:[NSString stringWithFormat:@"清水村:%ld家",qingshui.fishNum] qingshuiTwo:[NSString stringWithFormat:@"清水村未整改:%ld家",qingshui.notRectifiedNum] xinjing:[NSString stringWithFormat:@"新泾村:%ld家",xinjing.fishNum] xinjingTwo:[NSString stringWithFormat:@"新泾村未整改:%ld家",xinjing.notRectifiedNum] yanggou:[NSString stringWithFormat:@"洋沟溇村:%ld家",yanggou.fishNum] yanggouTwo:[NSString stringWithFormat:@"洋沟溇村未整改:%ld家",yanggou.notRectifiedNum] lianhua:[NSString stringWithFormat:@"莲花村:%ld家",lianhua.fishNum] lianhuaTwo:[NSString stringWithFormat:@"莲花村未整改:%ld家",lianhua.notRectifiedNum] yuye:[NSString stringWithFormat:@"渔业村:%ld家",yuye.fishNum] yuyeTwo:[NSString stringWithFormat:@"渔业村未整改:%ld家",yuye.notRectifiedNum] tianjing:[NSString stringWithFormat:@"沺泾社区:%ld家",tianjing.fishNum] tianjingTwo:[NSString stringWithFormat:@"沺泾社区未整改:%ld家",tianjing.notRectifiedNum]];
        [cell.qingShuiNOCorrectBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.allQingShuiBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        cell.qingShuiNOCorrectBtn.enabled = [qingshui.isAvailable isEqual:@"0"] ? NO : YES;
        cell.allQingShuiBtn.enabled = [qingshui.isAvailable isEqual:@"0"] ? NO : YES;
        [cell.qingShuiNOCorrectBtn setTitleColor:[qingshui.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];
        [cell.allQingShuiBtn setTitleColor:[qingshui.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];
        
        [cell.allXinJingBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.xinJingNOCorrectBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        cell.allXinJingBtn.enabled = [xinjing.isAvailable isEqual:@"0"] ? NO : YES;
        cell.xinJingNOCorrectBtn.enabled = [xinjing.isAvailable isEqual:@"0"] ? NO : YES;
        [cell.allXinJingBtn setTitleColor:[xinjing.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];
        [cell.xinJingNOCorrectBtn setTitleColor:[xinjing.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];

        [cell.allYangGouBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.yangGouNOCorrectBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        cell.allYangGouBtn.enabled = [yanggou.isAvailable isEqual:@"0"] ? NO : YES;
        cell.yangGouNOCorrectBtn.enabled = [yanggou.isAvailable isEqual:@"0"] ? NO : YES;
        [cell.allYangGouBtn setTitleColor:[yanggou.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];
        [cell.yangGouNOCorrectBtn setTitleColor:[yanggou.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];

        [cell.lianHuaBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.lianHuaNOCorrectBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        cell.lianHuaBtn.enabled = [lianhua.isAvailable isEqual:@"0"] ? NO : YES;
        cell.lianHuaNOCorrectBtn.enabled = [lianhua.isAvailable isEqual:@"0"] ? NO : YES;
        [cell.lianHuaBtn setTitleColor:[lianhua.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];
        [cell.lianHuaNOCorrectBtn setTitleColor:[lianhua.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];

        [cell.allyuYeBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.yuYeNOCorrectBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        cell.allyuYeBtn.enabled = [yuye.isAvailable isEqual:@"0"] ? NO : YES;
        cell.yuYeNOCorrectBtn.enabled = [yuye.isAvailable isEqual:@"0"] ? NO : YES;
        [cell.allyuYeBtn setTitleColor:[yuye.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];
        [cell.yuYeNOCorrectBtn setTitleColor:[yuye.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];

        [cell.allJingTianBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.jingTianNOCorrectBtn addTarget:self action:@selector(clickVillagesItem:) forControlEvents:UIControlEventTouchUpInside];
        cell.allJingTianBtn.enabled = [tianjing.isAvailable isEqual:@"0"] ? NO : YES;
        cell.jingTianNOCorrectBtn.enabled = [tianjing.isAvailable isEqual:@"0"] ? NO : YES;
        [cell.allJingTianBtn setTitleColor:[tianjing.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];
        [cell.jingTianNOCorrectBtn setTitleColor:[tianjing.isAvailable isEqual:@"0"] ? UMS_GRAY_200 : UMS_TEXT_BLACK forState:UIControlStateNormal];
        return cell;
    } else if (indexPath.row == 2) {
        YCHEachVaillageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:eachVaillageCellID forIndexPath:indexPath];
        [cell updateCellWithHeaderTitle:@"近期检查情况" BtnQingshui:[NSString stringWithFormat:@"近7天:%@家",self.overviewModel.recentSevenDayCheckNum] qingshuiTwo:[NSString stringWithFormat:@"近七天未整改:%@家",self.overviewModel.sevenNotRectifiedNum] xinjing:[NSString stringWithFormat:@"近30天:%@家",self.overviewModel.recentThirtyDayCheckNum] xinjingTwo:[NSString stringWithFormat:@"近30天未整改:%@家",self.overviewModel.thirtyNotRectifiedNum]];
        [cell.qingShuiNOCorrectBtn addTarget:self action:@selector(clickRecentCheckItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.allQingShuiBtn addTarget:self action:@selector(clickRecentCheckItem:) forControlEvents:UIControlEventTouchUpInside];

        [cell.allXinJingBtn addTarget:self action:@selector(clickRecentCheckItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.xinJingNOCorrectBtn addTarget:self action:@selector(clickRecentCheckItem:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        if (indexPath.row == 3) {
            YCHScrollBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollBannerCellID forIndexPath:indexPath];
            [cell updateCellWithRecentNotificationModelArray:self.overviewModel.recentNotification];
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 150.f;
    } else if (indexPath.row == 1) {
        return 260.f;
    } else if (indexPath.row == 2) {
        return 120.f;
    } else {
        return 150.f;
    }
}

- (void)requestAll {
    if (self.overviewDelegate && [self.overviewDelegate respondsToSelector:@selector(requestAllYJL)]) {
        [self.overviewDelegate requestAllYJL];
    }
}

- (void)requestAllNoRectification {
    if (self.overviewDelegate && [self.overviewDelegate respondsToSelector:@selector(requestAllNoRectificationYJL)]) {
        [self.overviewDelegate requestAllNoRectificationYJL];
    }
}

- (void)clickVillagesItem:(UIButton *)btn {
    if (self.overviewDelegate && [self.overviewDelegate respondsToSelector:@selector(reusetVillageYJLWithVillageType:)]) {
        [self.overviewDelegate reusetVillageYJLWithVillageType:btn.tag];
    }
}

- (void)clickRecentCheckItem:(UIButton *)btn {
    if (self.overviewDelegate && [self.overviewDelegate respondsToSelector:@selector(requsetRecentCheckYJLWithCheckType:)]) {
        [self.overviewDelegate requsetRecentCheckYJLWithCheckType:btn.tag];
    }
}

@end
