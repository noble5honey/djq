//
//  YCHScoreQueryTableView.m
//  YCHManage
//
//  Created by sunny on 2020/6/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHScoreQueryTableView.h"
#import "YCHScoreQueryTableViewCell.h"

#define BIND_PARK_CARD_CELL_HEIGHT 44.0f

static NSString * scoreQueryCellID = @"score_query_cell_id";

@interface YCHScoreQueryTableView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) NSString *remainValue;

@end

@implementation YCHScoreQueryTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sectionFooterHeight = 30.f;
        self.sectionHeaderHeight = 30.f;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHScoreQueryTableViewCell class] forCellReuseIdentifier:scoreQueryCellID];
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

- (void)updateTableViewWithReamianValue:(NSString *)remainValue {
    self.remainValue = remainValue;
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCHScoreQueryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scoreQueryCellID forIndexPath:indexPath];
    [cell updateCellWithDate:self.itemArray[indexPath.row][@"date"] item:self.itemArray[indexPath.row][@"item"] reason:self.itemArray[indexPath.row][@"reason"] value:self.itemArray[indexPath.row][@"value"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YCHScoreQueryTableViewCell *headerView = [[YCHScoreQueryTableViewCell alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 30.f)];
    [headerView updateCellWithDate:@"日期" item:@"扣分项目" reason:@"扣分原因" value:@"扣除分值"];
    headerView.backgroundColor = [UIColor whiteColor];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 30.f)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, Width_Screen - 24.f, 30.f)];
    footerView.backgroundColor = [UIColor whiteColor];
    titleLabel.text = [NSString stringWithFormat:@"当前分值剩余:%@",self.remainValue];
    titleLabel.font = [UIFont ChinaMediumFontNameOfSize:13.f];
    titleLabel.textColor = UMS_TEXT_BLACK;
    [footerView addSubview:titleLabel];
    return footerView;
}
@end
