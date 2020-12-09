//
//  YCHHomePageDetailTableView.m
//  YCHManage
//
//  Created by sunny on 2020/6/24.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomePageDetailTableView.h"
#import "YCHHomePageDetailTableViewCell.h"
#import "YCHTableViewFooterView.h"
#import "YCHHomePageExamineTableViewCell.h"

#define BIND_PARK_CARD_CELL_HEIGHT 44.0f
#define BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT 112.0f;

static NSString * homePageDetailCellID = @"home_page_detail_cell_id";
static NSString * homePageDetailFooterViewID = @"homePage_detail_footerView_cell_id";
static NSString * homePageExamineCellID = @"homePage_examine_cell_id";

@interface YCHHomePageDetailTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *detailsDic;

@property (nonatomic, strong) NSArray *showElementList;

@end

@implementation YCHHomePageDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.sectionFooterHeight = 30.f;
//        self.sectionHeaderHeight = 30.f;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHHomePageDetailTableViewCell class] forCellReuseIdentifier:homePageDetailCellID];
        [self registerClass:[YCHHomePageExamineTableViewCell class] forCellReuseIdentifier:homePageExamineCellID];
//        [self registerClass:[YCHTableViewFooterView class] forHeaderFooterViewReuseIdentifier:homePageDetailFooterViewID];
//        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 100.f)];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

- (void)updateTableViewWithDetailsDic:(NSDictionary *)detailsDic {
    self.detailsDic = detailsDic;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void)reloadDataWithShowElementList:(NSArray *)showElementList {
    self.showElementList = showElementList;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGPoint offset = self.contentOffset;
//    if (offset.y <= 0) {
//        offset.y = 0;
//    }
//    self.contentOffset = offset;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 30.f;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return self.showElementList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YCHHomePageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homePageDetailCellID forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell updateCellTitle:@"名称" detail:self.detailsDic[@"name"]];
        } else if (indexPath.row == 1) {
            [cell updateCellTitle:@"联系人" detail:self.detailsDic[@"value"]];
        } else if (indexPath.row == 2) {
            [cell updateCellTitle:@"电话" detail:self.detailsDic[@"telphone"]];
            cell.detailBtn.hidden = NO;
            cell.detailLabel.textColor = [UIColor colorWithRed:0 green:122 / 255.f blue:255.0 / 255.0 alpha:1.0];
            [cell.detailBtn addTarget:self action:@selector(dialTelPhoneNum) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [cell updateCellTitle:@"地址" detail:self.detailsDic[@"address"]];
            cell.bottomLine.hidden = YES;
        }
        return cell;
    } else if (indexPath.section == 1) {
        YCHHomePageExamineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homePageExamineCellID forIndexPath:indexPath];
        [cell updateCellTitle:self.showElementList[indexPath.row][@"displayName"]];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (self.homepageDetailTVDelegate && [self.homepageDetailTVDelegate respondsToSelector:@selector(homePageDetailTableViewDidSelectRowWithDetailDic:)]) {
            [self.homepageDetailTVDelegate homePageDetailTableViewDidSelectRowWithDetailDic:self.showElementList[indexPath.row]];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 30.f)];
    view.backgroundColor = UMS_TABLE_BG_COLOR;
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 30.f)];
    titleLB.textColor = UMS_TEXT_BLACK;
    titleLB.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
    titleLB.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleLB];

    if (section == 0) {
        titleLB.text = @"详细信息";
    } else if (section == 1) {
        titleLB.text = @"现场检查";
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    YCHTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:homePageDetailFooterViewID];
//    footerView.backgroundColor = UMS_TABLE_BG_COLOR;
//    [footerView.nextBtn addTarget:self action:@selector(gotoCheck) forControlEvents:UIControlEventTouchUpInside];
//    [footerView.nextBtn setTitle:@"现场检查" forState:UIControlStateNormal];
//    return footerView;
//}

- (void)dialTelPhoneNum {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.detailsDic[@"telphone"]]];
}

- (void)gotoCheck {
    
}

@end
