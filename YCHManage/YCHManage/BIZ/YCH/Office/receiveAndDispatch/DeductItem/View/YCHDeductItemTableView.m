//
//  YCHDeductItemTableView.m
//  YCHManage
//
//  Created by sunny on 2020/7/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHDeductItemTableView.h"
#import "YCHDeductItemTableViewCell.h"

static NSString * deductItemTableViewCellID = @"deduct_item_tableView_cell_id";

@interface YCHDeductItemTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;

@end

@implementation YCHDeductItemTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHDeductItemTableViewCell class] forCellReuseIdentifier:deductItemTableViewCellID];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

- (void)updateTableViewWithItemArray:(NSArray *)itemArray {
    self.itemArray = itemArray;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    } else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCHDeductItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deductItemTableViewCellID forIndexPath:indexPath];
    if (indexPath.row == self.itemArray.count - 1) {
        cell.bottomLine.hidden = YES;
    }
    cell.titleLable.text = self.itemArray[indexPath.row][@"departmentName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCHDeductItemTableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
    if (self.deductItemTVDelegate && [self.deductItemTVDelegate respondsToSelector:@selector(deductItemTableViewSelectdeductItemtResultItemStr:)]) {
        [self.deductItemTVDelegate deductItemTableViewSelectdeductItemtResultItemStr:cell.titleLable.text];
    }
    NSLog(@"a扣分选项：%@",cell.titleLable.text);
}

@end
