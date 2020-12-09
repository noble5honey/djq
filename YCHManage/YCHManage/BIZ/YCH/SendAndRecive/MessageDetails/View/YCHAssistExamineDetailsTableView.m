//
//  YCHAssistExamineDetailsTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/29.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHAssistExamineDetailsTableView.h"
#import "YCHMessageDetailsKeyValueTableViewCell.h"
#import "YCHMessageDetailsContentTableViewCell.h"

static NSString *messageDetailKeyValueCellId = @"message_details_key_value_cell_id";
static NSString *messageDetailContentCellId = @"message_details_content_cell_id";

@interface YCHAssistExamineDetailsTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YCHMessageDetailsContentTableViewCell *contenCell;

@property (nonatomic, strong) NSDictionary *dictionary;

@property (nonatomic, strong) NSString *readStr;

@property (nonatomic, strong) NSString *noReadStr;

@property (nonatomic, strong) NSString *isMySend ;

@end
@implementation YCHAssistExamineDetailsTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHMessageDetailsKeyValueTableViewCell class] forCellReuseIdentifier:messageDetailKeyValueCellId];
        [self registerClass:[YCHMessageDetailsContentTableViewCell class] forCellReuseIdentifier:messageDetailContentCellId];
    }
    return self;
}

- (void)updateTableViewContentDictionary:(NSDictionary *)dictionary {
    self.dictionary = dictionary;
    self.isMySend = [NSString stringWithFormat:@"%@",self.dictionary[@"isMySend"]];
    NSArray *receiveReadList = dictionary[@"receiveReadList"];
    NSMutableArray *readList = [NSMutableArray array];
    NSMutableArray *noReadList = [NSMutableArray array];
    for (int i = 0; i < receiveReadList.count; i++) {
        if ([receiveReadList[i][@"isRead"] isEqual:@"0"]) {
            [noReadList addObject:receiveReadList[i]];
            if (self.noReadStr.length > 0) {
                self.noReadStr = [NSString stringWithFormat:@"%@ 、%@",self.noReadStr,receiveReadList[i][@"receiveName"]];
            } else {
                self.noReadStr = receiveReadList[i][@"receiveName"];
            }
           
        } else {
            if (self.readStr.length > 0) {
                self.readStr = [NSString stringWithFormat:@"%@ 、 %@",self.readStr,receiveReadList[i][@"receiveName"]];
            } else {
                self.readStr = receiveReadList[i][@"receiveName"];
            }
            [readList addObject:receiveReadList[i]];
        }
    }
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    } else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.isMySend isEqualToString:@"0"] ? 4 : 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.isMySend isEqualToString:@"0"] ? indexPath.row < 3 : indexPath.row < 5) {
        YCHMessageDetailsKeyValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageDetailKeyValueCellId forIndexPath:indexPath];
        if (indexPath.row == 0) {
            if ([self.isMySend isEqualToString:@"0"]) {
                cell.titleLabel.text = @"发件人:";
                cell.contentLabel.text = self.dictionary[@"sendName"];
            } else {
                cell.titleLabel.text = @"收件人:";
                NSArray *receiveNames = self.dictionary[@"receiveNames"];
                NSString *receiveNamesStr = @"";
                for (int i = 0; i<receiveNames.count; i++) {
                    if (i == 0) {
                        receiveNamesStr = [NSString stringWithFormat:@"%@",receiveNames[i]];
                    } else {
                        receiveNamesStr = [NSString stringWithFormat:@"%@、%@",receiveNamesStr,receiveNames[i]];
                    }
                }
                cell.contentLabel.text = receiveNamesStr;
            }
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = @"标题:";
            NSString *themeStr = [NSString stringWithFormat:@"%@",self.dictionary[@"topic"]];
            cell.contentLabel.text = themeStr;
        } else if (indexPath.row == 2) {
            NSString *checkDate = [NSString stringWithFormat:@"%@",self.dictionary[@"checkDate"]];
            cell.titleLabel.text = @"协检日期:";
            cell.contentLabel.text = [NSString ConvertStrToTime:checkDate];
        } else if (indexPath.row == 3) {
            cell.titleLabel.text = @"已读:";
            cell.contentLabel.text = self.readStr;
        } else if (indexPath.row == 4) {
            cell.titleLabel.text = @"未读:";
            cell.contentLabel.text = self.noReadStr;
        }
        return cell;
    } else {
        self.contenCell = [tableView dequeueReusableCellWithIdentifier:messageDetailContentCellId forIndexPath:indexPath];
        self.contenCell.contentLabel.text = self.dictionary[@"body"];
        return self.contenCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.isMySend isEqualToString:@"0"] ? indexPath.row < 3 : indexPath.row < 5) {
        if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4) {
            return 80.f;
        }
        return 60.f;
    }
    return [self.contenCell cellHeight];
}

@end
