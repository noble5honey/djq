//
//  YCHMyTableView.m
//  YCHManage
//
//  Created by sunny on 2020/10/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHMyTableView.h"
#import "UMSMyHomeUserInfoCell.h"
#import "YCHLogoutTableViewCell.h"

static NSString * myHomeCellId = @"my_home_cell_id";
static NSString *logoutCellId = @"logout_cell_id";

@interface YCHMyTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation YCHMyTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[UMSMyHomeUserInfoCell class] forCellReuseIdentifier:myHomeCellId];
        [self registerClass:[YCHLogoutTableViewCell class] forCellReuseIdentifier:logoutCellId];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 20.f;
    } else {
        return 0.0000001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 20.f)];
    //    view.backgroundColor = UMS_TABLE_BG_COLOR;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UMSMyHomeUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:myHomeCellId forIndexPath:indexPath];
        [cell updateInfoCellContent];
        return cell;
    } else {
        YCHLogoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:logoutCellId forIndexPath:indexPath];
        return cell;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [UMSMyHomeUserInfoCell heightForCell];
    } else {
        return 64;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (self.myTableViewDelegate && [self.myTableViewDelegate respondsToSelector:@selector(logOut)]) {
            [self.myTableViewDelegate logOut];
        }
    }
}

@end
