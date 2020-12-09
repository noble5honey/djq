//
//  YCHHomePageNaviItemTableView.m
//  YCHManage
//
//  Created by sunny on 2020/11/25.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHHomePageNaviItemTableView.h"
#import "YCHReceiveDepartmentTableViewCell.h"

static NSString * homePageNaviItemCellID = @"home_page_naviItem_cell_id";

@interface YCHHomePageNaviItemTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YCHHomePageNaviItemTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHReceiveDepartmentTableViewCell class] forCellReuseIdentifier:homePageNaviItemCellID];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCHReceiveDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homePageNaviItemCellID forIndexPath:indexPath];
    [cell updateCellWithContent:self.itemArray[indexPath.row][@"title"]];
    if (self.indexPath == indexPath) {
        [cell departmentIsSelect:YES];
    } else {
        [cell departmentIsSelect:NO];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    [self reloadData];
    if (self.naviItemTVDelegate && [self.naviItemTVDelegate respondsToSelector:@selector(homePageDidSelectedNaviItemWithIndexPath:)]) {
        [self.naviItemTVDelegate homePageDidSelectedNaviItemWithIndexPath:indexPath];
    }
}

@end
