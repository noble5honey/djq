//
//  YCHAssistExamineTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAssistExamineTableView.h"
#import "YCHSendAndReciveTableViewCell.h"

static NSString * assistExamineCellID = @"assist_examine_cell_id";

@interface YCHAssistExamineTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *contentArray;

@end

@implementation YCHAssistExamineTableView
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

- (void)updateAssistExamineTableViewWithContentArray:(NSArray *)contentArray {
    self.contentArray = contentArray;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    }else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.assistExamineTVDelegate && [self.assistExamineTVDelegate respondsToSelector:@selector(assistExamineTableViewDidScroll)]) {
        [self.assistExamineTVDelegate assistExamineTableViewDidScroll];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCHSendAndReciveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:assistExamineCellID forIndexPath:indexPath];
    [cell updateCellContentWithDictionary:self.contentArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.assistExamineTVDelegate && [self.assistExamineTVDelegate respondsToSelector:@selector(assistExamineTableViewDidSelectRowWithDictionary:)]) {
        [self.assistExamineTVDelegate assistExamineTableViewDidSelectRowWithDictionary:self.contentArray[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
