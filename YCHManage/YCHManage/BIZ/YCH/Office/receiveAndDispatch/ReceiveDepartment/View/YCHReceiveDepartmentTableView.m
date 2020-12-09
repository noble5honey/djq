//
//  YCHReceiveDepartmentTableView.m
//  YCHManage
//
//  Created by sunny on 2020/7/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHReceiveDepartmentTableView.h"
#import "YCHReceiveDepartmentTableViewCell.h"

static NSString * departmentTableViewCellID = @"department_tableView_cell_id";

@interface YCHReceiveDepartmentTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) NSMutableArray *departmentResultArray;

@end

@implementation YCHReceiveDepartmentTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHReceiveDepartmentTableViewCell class] forCellReuseIdentifier:departmentTableViewCellID];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.departmentResultArray = [NSMutableArray array];
    }
    return self;
}

- (void)updateTableViewWithItemArray:(NSArray *)itemArray selectArray:(NSArray *)selectArray {
    self.itemArray = itemArray;
    if (selectArray.count > 0) {
        [self.departmentResultArray addObjectsFromArray:selectArray];
    }
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
    YCHReceiveDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:departmentTableViewCellID forIndexPath:indexPath];
    if (indexPath.row == self.itemArray.count - 1) {
        cell.bottomLine.hidden = YES;
    }
    if (self.departmentResultArray.count > 0) {
        for (int i = 0; i < self.departmentResultArray.count; i++) {
            if (self.departmentResultArray[i][@"roleId"] == self.itemArray[indexPath.row][@"roleId"]) {
                [cell departmentIsSelect:YES];
                cell.selectBtn.selected = YES;
            }
        }
    }
    [cell updateCellWithContent:self.itemArray[indexPath.row][@"roleName"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCHReceiveDepartmentTableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
    cell.selectBtn.selected = !cell.selectBtn.selected;
    [cell departmentIsSelect:cell.selectBtn.selected];
    if (cell.selectBtn.selected) {
        [self.departmentResultArray addObject:self.itemArray[indexPath.row]];
    } else {
        [self.departmentResultArray removeObject:self.itemArray[indexPath.row]];
    }
    if (self.receiveDepartmentTVDelegate && [self.receiveDepartmentTVDelegate respondsToSelector:@selector(receiveDepartmentTableViewSelectDepartmentResultItemArray:)]) {
        [self.receiveDepartmentTVDelegate receiveDepartmentTableViewSelectDepartmentResultItemArray:self.departmentResultArray];
    }
    NSLog(@"数组结果：%@",self.departmentResultArray);
}

@end
