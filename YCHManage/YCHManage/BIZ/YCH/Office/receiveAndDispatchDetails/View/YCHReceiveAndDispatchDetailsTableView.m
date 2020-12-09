//
//  YCHReceiveAndDispatchDetailsTableView.m
//  YCHManage
//
//  Created by sunny on 2020/7/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHReceiveAndDispatchDetailsTableView.h"
#import "YCHHomePageDetailTableViewCell.h"
#import "YCHReceiveDetailsTextViewTableViewCell.h"
#import "YCHTableViewFooterView.h"

#define BIND_PARK_CARD_CELL_HEIGHT 44.0f

static NSString * receiveAndDispathDetailsCellID = @"receive_and_dispatch_details_cell_id";
static NSString * receiveAndDispathDetailsTextViewCellID = @"receive_and_dispatch_details_textview_cell_id";
static NSString * examineFootViewID = @"examine_footView_id";

@interface YCHReceiveAndDispatchDetailsTableView() <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) NSDictionary *itemDic;

@end


@implementation YCHReceiveAndDispatchDetailsTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sectionFooterHeight = 30.f;
        self.sectionHeaderHeight = 30.f;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHHomePageDetailTableViewCell class] forCellReuseIdentifier:receiveAndDispathDetailsCellID];
        [self registerClass:[YCHReceiveDetailsTextViewTableViewCell class] forCellReuseIdentifier:receiveAndDispathDetailsTextViewCellID];
         [self registerClass:[YCHTableViewFooterView class] forHeaderFooterViewReuseIdentifier:examineFootViewID];
    }
    return self;
}

- (void)updateTableViewWithItemArray:(NSDictionary *)itemDic {
    self.itemDic = itemDic;
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
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YCHHomePageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiveAndDispathDetailsCellID forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell updateCellTitle:@"标题" detail:self.itemDic[@"name"]];
        } else if (indexPath.row == 1) {
            [cell updateCellTitle:@"发送单位" detail:self.itemDic[@"department"]];
        } else if (indexPath.row == 2) {
            [cell updateCellTitle:@"发送时间" detail:self.itemDic[@"date"]];
        }
        return cell;
    } else {
        YCHReceiveDetailsTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiveAndDispathDetailsTextViewCellID forIndexPath:indexPath];
        cell.titleLabel.text = @"内容";
        cell.recordTextView.delegate = self;
        cell.recordTextView.editable = NO;
        cell.recordTextView.text = self.itemDic[@"address"];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
         return CELL_HEIGHT;
    } else {
        return 120.f;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.detailsTVDelegate && [self.detailsTVDelegate respondsToSelector:@selector(YCHReceiveAndDispatchDetailsTableViewTextViewDidChange:)]) {
        [self.detailsTVDelegate YCHReceiveAndDispatchDetailsTableViewTextViewDidChange:textView];
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 120.f)];
        view.backgroundColor = UMS_TABLE_BG_COLOR;
        
        UIButton *revokeButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 10, Width_Screen-32, 40.f)];
        [revokeButton.layer setCornerRadius:4.0];
        [revokeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [revokeButton setBackgroundColor:UMS_THEME_COLOR];
        [revokeButton setTitle:@"撤销" forState:UIControlStateNormal];
        revokeButton.layer.cornerRadius = 20.0f;
        [revokeButton addTarget:self action:@selector(clickRevokeButton) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:revokeButton];
        
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 60.f, Width_Screen-32, 40.f)];
        [deleteButton.layer setCornerRadius:4.0];
        [deleteButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [deleteButton setBackgroundColor:UMS_THEME_COLOR];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        deleteButton.layer.cornerRadius = 20.0f;
        [deleteButton addTarget:self action:@selector(clickDeletebutton) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:deleteButton];
        return view;
    } else {
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.00001f;
    } else {
        return 200.f;
    }
}

- (void)clickRevokeButton {
    if (self.detailsTVDelegate && [self.detailsTVDelegate respondsToSelector:@selector(reveceiveAndDispatchDetailsTableViewClickRevokeButton)]) {
        [self.detailsTVDelegate reveceiveAndDispatchDetailsTableViewClickRevokeButton];
    }
}

- (void)clickDeletebutton {
    if (self.detailsTVDelegate && [self.detailsTVDelegate respondsToSelector:@selector(reveceiveAndDispatchDetailsTableViewClickDeleteButton)]) {
        [self.detailsTVDelegate reveceiveAndDispatchDetailsTableViewClickDeleteButton];
    }
}
@end
