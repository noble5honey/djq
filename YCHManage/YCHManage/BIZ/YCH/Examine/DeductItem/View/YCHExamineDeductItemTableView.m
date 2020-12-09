//
//  YCHExamineDeductItemTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHExamineDeductItemTableView.h"
#import "YCHExamineDeductItemTableViewCell.h"

static NSString * examineBaseCellID = @"examine_base_cell_id";

@interface YCHExamineDeductItemTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YCHExamineDeductItemTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHExamineDeductItemTableViewCell class] forCellReuseIdentifier:examineBaseCellID];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

- (void)updateTableViewWithItemArray:(NSArray *)itemArray indexPath:(NSIndexPath *)indexPath{
    self.itemArray = itemArray;
    self.indexPath = indexPath;
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
    YCHExamineDeductItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:examineBaseCellID forIndexPath:indexPath];
    cell.itemLabel.text = self.itemArray[indexPath.row][@"matterName"];
//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (indexPath == self.indexPath) {
        cell.backgroundColor = [UIColor lightGrayColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.itemDic = self.itemArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YCHExamineDeductItemTableViewCell *cell = (YCHExamineDeductItemTableViewCell *)[self cellForRowAtIndexPath:indexPath];
//    cell.selected = YES;
    if (self.examineDeductItemTVDelagate && [self.examineDeductItemTVDelagate respondsToSelector:@selector(examineDeductItemTableViewDidSelectedRowWithIndexPath:cell:)]) {
        [self.examineDeductItemTVDelagate examineDeductItemTableViewDidSelectedRowWithIndexPath:indexPath cell:cell];
    }
}

@end
