//
//  YCHCheckRecordDetailsTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/28.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHCheckRecordDetailsTableView.h"
#import "YCHcheckRecordTableViewCell.h"
#import "YCHTableViewFooterView.h"

static NSString * examineUploadCellID = @"examine_upload_cell_id";

#define BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT 112.0f;
#define hotelPictureFirstPhoto             10001
#define hotelPictureSecondPhoto            10002
#define hotelPictureThirdPhoto             10003

static NSString * checkRecordCellID = @"check_record_cell_id";


@interface YCHCheckRecordDetailsTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YCHcheckRecordTableViewCell *checkRecordCell;

@property (nonatomic, strong) YCHExamineTableViewCell *cell;

@property (nonatomic, strong) NSString *limitText;

@property (nonatomic, strong) NSDictionary *itemDic;

@end

@implementation YCHCheckRecordDetailsTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        self.estimatedSectionFooterHeight = 0;
        [self registerClass:[YCHcheckRecordTableViewCell class] forCellReuseIdentifier:checkRecordCellID];
        [self registerClass:[YCHExamineTableViewCell class] forCellReuseIdentifier:examineUploadCellID];
    }
    return self;
}

- (void)updateTableViewWithItemDic:(NSDictionary *)itemDic {
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.checkRecordCell = [tableView dequeueReusableCellWithIdentifier:checkRecordCellID forIndexPath:indexPath];
        [self.checkRecordCell.firstButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
        self.checkRecordCell.firstButton.tag = hotelPictureFirstPhoto;
        [self.checkRecordCell.secondButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
        self.checkRecordCell.secondButton.tag = hotelPictureSecondPhoto;
        [self.checkRecordCell.thirdButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
        self.checkRecordCell.thirdButton.tag = hotelPictureThirdPhoto;
        //后期需要判断是修改信息还是查看详情
        self.checkRecordCell.fixButton.hidden = YES;
        [self.checkRecordCell updateCellContentWithDic:self.itemDic];
        [self.checkRecordCell updateCellWithPicArray:self.itemDic[@"checkPicIos"]];
        return self.checkRecordCell;
    } else {
        self.cell = [tableView dequeueReusableCellWithIdentifier:examineUploadCellID forIndexPath:indexPath];
        [self.cell.addButton addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
        self.cell.addButton.tag = 1001;
        [self.cell.secondButton addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
        self.cell.secondButton.tag = 1002;
        [self.cell.thirdButton addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
        self.cell.thirdButton.tag = 1003;
        self.cell.addImageView.hidden = YES;
        self.cell.tagLabel.hidden = YES;
        self.cell.addButton.layer.borderWidth = 0;
        self.cell.recordTextView.editable = NO;
        self.cell.recordTextView.placeholder = @"";
        [self.cell updateCellWithCorrectItemDic:self.itemDic[@"rectification"]];
        [self.cell updateCellShowPictureWithPictureArray:self.itemDic[@"rectification"][@"rectificationPicIos"]];
        return  self.cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self.checkRecordCell cellHeight];
    } else {
        return 240;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)showPictureView:(UIButton *)btn {
    if (btn.tag == hotelPictureFirstPhoto) {
        if (self.checkRecordDetailsTVDelegate && [self.checkRecordDetailsTVDelegate respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.checkRecordDetailsTVDelegate clickHotelPictureShowSacleImage:self.checkRecordCell.firstImageView.image];
        }
    } else if (btn.tag == hotelPictureSecondPhoto) {
        if (self.checkRecordDetailsTVDelegate && [self.checkRecordDetailsTVDelegate respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.checkRecordDetailsTVDelegate clickHotelPictureShowSacleImage:self.checkRecordCell.secondImageView.image];
        }
    } else {
        if (self.checkRecordDetailsTVDelegate && [self.checkRecordDetailsTVDelegate respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.checkRecordDetailsTVDelegate clickHotelPictureShowSacleImage:self.checkRecordCell.thirdImageView.image];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 30.f)];
    //    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30.f)];
    titleLB.textColor = UMS_TEXT_BLACK;
    titleLB.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
    titleLB.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleLB];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width_Screen-116, 0, 100, 30)];
    dateLabel.textColor = UMS_TEXT_BLACK;
    dateLabel.font = [UIFont ChinaDefaultFontNameOfSize:13.f];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:dateLabel];
    if (section == 0) {
        titleLB.text = @"扣分详情";
    } else if (section == 1) {
        titleLB.text = @"整改详情";
        NSString *time = [NSString stringWithFormat:@"%@",self.itemDic[@"rectification"][@"createTime"]];
        dateLabel.text = [NSString ConvertStrToTime:time];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (void)uploadImage:(UIButton *)btn {
    if (btn.tag == 1001) {
        if (self.checkRecordDetailsTVDelegate && [self.checkRecordDetailsTVDelegate respondsToSelector:@selector(checkRecordDetailClickHotelPictureShowSacleImage:)]) {
            [self.checkRecordDetailsTVDelegate checkRecordDetailClickHotelPictureShowSacleImage:self.cell.showImageView.image];
        }
    } else if (btn.tag == 1002) {
        if (self.checkRecordDetailsTVDelegate && [self.checkRecordDetailsTVDelegate respondsToSelector:@selector(checkRecordDetailClickHotelPictureShowSacleImage:)]) {
            [self.checkRecordDetailsTVDelegate checkRecordDetailClickHotelPictureShowSacleImage:self.cell.secondImageView.image];
        }
    } else {
        if (self.checkRecordDetailsTVDelegate && [self.checkRecordDetailsTVDelegate respondsToSelector:@selector(checkRecordDetailClickHotelPictureShowSacleImage:)]) {
            [self.checkRecordDetailsTVDelegate checkRecordDetailClickHotelPictureShowSacleImage:self.cell.thirdImageView.image];
        }
    }
    
}
@end
