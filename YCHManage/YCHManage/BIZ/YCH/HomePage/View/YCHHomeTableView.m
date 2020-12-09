//
//  YCHHomeTableView.m
//  YCHManage
//
//  Created by sunny on 2020/6/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomeTableView.h"
#import "YCHHomePageManagerTableViewCell.h"

static NSString * homePageCellID = @"home_page_cell_id";

#define BIND_PARK_CARD_CELL_HEIGHT 44.0f

@interface YCHHomeTableView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) YCHHomePageManagerTableViewCell *headerView;

@property (nonatomic, strong) NSIndexPath *SelectedIndexPath;

@property (nonatomic, assign) BOOL isClickCellSingleNum; //点击单数显示 偶数影藏

@end

@implementation YCHHomeTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHHomePageManagerTableViewCell class] forCellReuseIdentifier:homePageCellID];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGPoint offset = self.contentOffset;
//    if (offset.y <= 0) {
//        offset.y = 0;
//    }
//    self.contentOffset = offset;
    if (self.homepageTVDelegate && [self.homepageTVDelegate respondsToSelector:@selector(homePageTableViewDidScroll)]) {
        [self.homepageTVDelegate homePageTableViewDidScroll];
    }
}

- (void)updateTableViewWithItemArray:(NSArray *)itemArray {
    self.itemArray = itemArray;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCHHomePageManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homePageCellID forIndexPath:indexPath];
    if (self.SelectedIndexPath == indexPath) {
        if (self.isClickCellSingleNum) {
            [cell showBottomButton];
        } else {
            [cell hiddenBottomButton];
            self.SelectedIndexPath = nil;
        }
    } else {
        [cell hiddenBottomButton];
    }
    [cell updateCellWithName:self.itemArray[indexPath.row][@"fishName"] code:self.itemArray[indexPath.row][@"businessCode"] score:self.itemArray[indexPath.row][@"fishScore"] levelStr:nil];
    [cell settingPermission:[NSString stringWithFormat:@"%@",self.itemArray[indexPath.row][@"readPerssion"]]];
    [cell.basicInformationBtn addTarget:self action:@selector(clickBasicInformationBtn) forControlEvents:UIControlEventTouchUpInside];
    [cell.recordBtn addTarget:self action:@selector(clickRecordBtn) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //出现按钮高度为90  隐藏为60
    if (self.SelectedIndexPath && self.SelectedIndexPath == indexPath) {
        if (self.isClickCellSingleNum) {
            return 90;
        } else {
            return 60;
        }
    } else {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.SelectedIndexPath && self.SelectedIndexPath == indexPath) {
        self.isClickCellSingleNum = NO;
    } else {
        self.isClickCellSingleNum = YES;
    }
    self.SelectedIndexPath = indexPath;
    if (self.homepageTVDelegate && [self.homepageTVDelegate respondsToSelector:@selector(homePageTableViewDidSelectRow)]) {
        [self.homepageTVDelegate homePageTableViewDidSelectRow];
    }
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void)clickBasicInformationBtn {
    if (self.homepageTVDelegate && [self.homepageTVDelegate respondsToSelector:@selector(homePageTableViewClickBasicInformationButtonWithDetailDic:)]) {
        [self.homepageTVDelegate homePageTableViewClickBasicInformationButtonWithDetailDic:self.itemArray[self.SelectedIndexPath.row]];
    }
}

- (void)clickRecordBtn {
    if (self.homepageTVDelegate && [self.homepageTVDelegate respondsToSelector:@selector(homePageTableViewClickRecordButtonWithDetailDic:)]) {
        [self.homepageTVDelegate homePageTableViewClickRecordButtonWithDetailDic:self.itemArray[self.SelectedIndexPath.row]];
    }
}

@end
