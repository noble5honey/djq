//
//  FilTrateTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/18.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "FilTrateTableView.h"
#import "FilTrateDateTableViewCell.h"
#import "FiltrateFooterView.h"

static NSString *filtrateDateCellId = @"filtrate_date_cell_id";
static NSString *deductItemCellId = @"deduct_item_cell_id";

@interface FilTrateTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) NSArray *sectionTitleArray;

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) FiltrateFooterView *FiltrateFooterView;

@end

@implementation FilTrateTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[FilTrateDateTableViewCell class] forCellReuseIdentifier:filtrateDateCellId];
        [self registerClass:[YCHExamineDeductItemTableViewCell class] forCellReuseIdentifier:deductItemCellId];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    

}

- (void)updateSectionTitleArray:(NSArray *)titleArray itemArray:(NSArray *)itemArray {
    self.sectionTitleArray = titleArray;
    self.itemArray = itemArray;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.itemArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FilTrateDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:filtrateDateCellId forIndexPath:indexPath];
        [cell.startTF addTarget:self action:@selector(strtTFtoSelectDate:) forControlEvents:UIControlEventEditingDidBegin];
        [cell.endTF addTarget:self action:@selector(endTFtoSelectDate:) forControlEvents:UIControlEventEditingDidBegin];
        return cell;
    } else {
        YCHExamineDeductItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deductItemCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.itemLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        cell.itemLabel.text = self.itemArray[indexPath.row][@"matterName"];
        cell.itemDic = self.itemArray[indexPath.row];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    } else {
        return 30;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        YCHExamineDeductItemTableViewCell *cell = (YCHExamineDeductItemTableViewCell *)[self cellForRowAtIndexPath:indexPath];
        if (self.filtrateTVdelegate && [self.filtrateTVdelegate respondsToSelector:@selector(filtrateTableViewDidSelectedRowWithIndexPath:cell:)]) {
            [self.filtrateTVdelegate filtrateTableViewDidSelectedRowWithIndexPath:indexPath cell:cell];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 30.f)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30.f)];
    titleLB.textColor = UMS_TEXT_BLACK;
    titleLB.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
    titleLB.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleLB];
    if (self.sectionTitleArray) {
        titleLB.text = self.sectionTitleArray[section];
    } else {
        if (section == 0) {
            titleLB.text = @"日期选择";
        } else if (section == 1) {
            titleLB.text = @"扣分项目";
        }
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 50;
    } else {
        return 0.000001;
    }
}

- (void)strtTFtoSelectDate:(UITextField *)textField {
    if (self.filtrateTVdelegate && [self.filtrateTVdelegate respondsToSelector:@selector(clickStartTextFiled:)]) {
        [self.filtrateTVdelegate clickStartTextFiled:textField];
    }
}

- (void)endTFtoSelectDate:(UITextField *)textField {
    if (self.filtrateTVdelegate && [self.filtrateTVdelegate
        respondsToSelector:@selector(clickEndTextFiled:)]) {
        [self.filtrateTVdelegate clickEndTextFiled:textField];
    }
}

@end
