//
//  YCHResultNotiTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHResultNotiTableView.h"
#import "YCHSendAndReciveTableViewCell.h"

static NSString * assistExamineCellID = @"assist_examine_cell_id";

@interface YCHResultNotiTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *contentArray;

@end

@implementation YCHResultNotiTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHSendAndReciveTableViewCell class] forCellReuseIdentifier:assistExamineCellID];
    }
    return self;
}

- (void)updateResultNotiTableViewWithContenArray:(NSArray *)contentArray {
    self.contentArray = contentArray;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    } else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.resultNotiTVDelegate && [self.resultNotiTVDelegate respondsToSelector:@selector(resultNotiTableViewDidScroll)]) {
        [self.resultNotiTVDelegate resultNotiTableViewDidScroll];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCHSendAndReciveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:assistExamineCellID forIndexPath:indexPath];
    [cell updateNotiCellContentDictionary:self.contentArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.resultNotiTVDelegate && [self.resultNotiTVDelegate respondsToSelector:@selector(resultNotiTableViewDidSelectRowWithDictionary:)]) {
        [self.resultNotiTVDelegate resultNotiTableViewDidSelectRowWithDictionary:self.contentArray[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
