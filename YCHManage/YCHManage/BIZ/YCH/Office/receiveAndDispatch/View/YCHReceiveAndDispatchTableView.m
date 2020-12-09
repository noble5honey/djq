//
//  YCHReceiveAndDispatchTableView.m
//  YCHManage
//
//  Created by sunny on 2020/7/20.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHReceiveAndDispatchTableView.h"
#import "YCHReceiveAndDispatchTableViewCell.h"

static NSString * receiveAndDispathCellID = @"receive_and_dispatch_cell_id";

#define BIND_PARK_CARD_CELL_HEIGHT 44.0f

@interface YCHReceiveAndDispatchTableView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) YCHReceiveAndDispatchTableViewCell *headerView;

@end

@implementation YCHReceiveAndDispatchTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sectionFooterHeight = 30.f;
        self.sectionHeaderHeight = 30.f;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHReceiveAndDispatchTableViewCell class] forCellReuseIdentifier:receiveAndDispathCellID];
    }
    return self;
}

- (void)updateTableViewWithItemArray:(NSArray *)itemArray {
    self.itemArray = itemArray;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = self.contentOffset;
    if (offset.y <= 0) {
        offset.y = 0;
    }
    self.contentOffset = offset;
    if (self.receiveAndDispatchTVDelegate && [self.receiveAndDispatchTVDelegate respondsToSelector:@selector(receiveAndDispatchTableViewDidScroll)]) {
        [self.receiveAndDispatchTVDelegate receiveAndDispatchTableViewDidScroll];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCHReceiveAndDispatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiveAndDispathCellID forIndexPath:indexPath];
    [cell updateCellWith:self.itemArray[indexPath.row][@"name"] departmentStr:self.itemArray[indexPath.row][@"department"] dateStr:self.itemArray[indexPath.row][@"date"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.headerView = [[YCHReceiveAndDispatchTableViewCell alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 30.f)];
    [self.headerView updateCellWith:@"通告内容" departmentStr:@"部门" dateStr:@"发布时间"];
    self.headerView.nameLabel.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
    self.headerView.departmentLabel.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
    self.headerView.dateLabel.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.arrowImageView.hidden = YES;
    return self.headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.receiveAndDispatchTVDelegate && [self.receiveAndDispatchTVDelegate respondsToSelector:@selector(receiveAndDispatchTableViewDidSelectRowWithDetailDic:)]) {
        [self.receiveAndDispatchTVDelegate receiveAndDispatchTableViewDidSelectRowWithDetailDic:self.itemArray[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}

@end
