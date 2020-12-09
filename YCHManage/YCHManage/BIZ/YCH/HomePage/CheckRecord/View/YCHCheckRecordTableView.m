//
//  YCHCheckRecordTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/15.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHCheckRecordTableView.h"
#import "YCHcheckRecordTableViewCell.h"

#define hotelPictureFirstPhoto             10001
#define hotelPictureSecondPhoto            10002
#define hotelPictureThirdPhoto             10003

static NSString * checkRecordCellID = @"check_record_cell_id";

@interface YCHCheckRecordTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) YCHcheckRecordTableViewCell *checkRecordCell;

//@property (nonatomic, assign) YCHCorrectOrDetailsTpye btnTpye;

@end

@implementation YCHCheckRecordTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHcheckRecordTableViewCell class] forCellReuseIdentifier:checkRecordCellID];
    }
    return self;
}

- (void)updateTableViewWithItemArray:(NSArray *)itemArray {
    self.itemArray = itemArray;
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
    
    self.checkRecordCell = [tableView dequeueReusableCellWithIdentifier:checkRecordCellID forIndexPath:indexPath];
    [self.checkRecordCell.firstButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
    self.checkRecordCell.firstButton.tag = hotelPictureFirstPhoto;
    [self.checkRecordCell.secondButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
    self.checkRecordCell.secondButton.tag = hotelPictureSecondPhoto;
    [self.checkRecordCell.thirdButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
    self.checkRecordCell.thirdButton.tag = hotelPictureThirdPhoto;
    //后期需要判断是修改信息还是查看详情
    [self.checkRecordCell.fixButton addTarget:self action:@selector(toCorrectInfo:)
                             forControlEvents:UIControlEventTouchUpInside];
    NSString *str1 = [NSString stringWithFormat:@"%@",self.itemArray[indexPath.row][@"rectification"]];
    if ([str1 isEqualToString:@"<null>"]) {
        [self.checkRecordCell.fixButton setTitle:@"整改" forState:UIControlStateNormal];
        self.checkRecordCell.fixButton.tag = CheckRecord_CorrectButton;
        if (!UserCenter.isPublishAuth) {
            self.checkRecordCell.fixButton.enabled = NO;
            self.checkRecordCell.fixButton.backgroundColor = UMS_GRAY_220;
        }
        NSString *enableFix = [NSString stringWithFormat:@"%@",self.itemArray[indexPath.row][@"recAuth"]];
        if ([enableFix isEqual:@"1"]) {
            self.checkRecordCell.fixButton.enabled = YES;
            self.checkRecordCell.fixButton.backgroundColor = UMS_THEME_COLOR;
//            self.checkRecordCell.fixButton.hidden = NO;
        } else {
            self.checkRecordCell.fixButton.enabled = NO;
            self.checkRecordCell.fixButton.backgroundColor = UMS_GRAY_220;
//            self.checkRecordCell.fixButton.hidden = YES;
        }
    } else {
        self.checkRecordCell.fixButton.enabled = YES;
        self.checkRecordCell.fixButton.backgroundColor = UMS_THEME_COLOR;
        [self.checkRecordCell.fixButton setTitle:@"整改详情" forState:UIControlStateNormal];
        self.checkRecordCell.fixButton.tag = CheckRecord_DetailsButton;
    }
    [self.checkRecordCell updateCellContentWithDic:self.itemArray[indexPath.row]];
    [self.checkRecordCell updateCellWithPicArray:self.itemArray[indexPath.row][@"checkPicIos"]];
    return self.checkRecordCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 190.5f;
    return [self.checkRecordCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.checkRecordTVDeleagte && [self.checkRecordTVDeleagte respondsToSelector:@selector(checkRecordTableViewDidSelected)]) {
        [self.checkRecordTVDeleagte checkRecordTableViewDidSelected];
    }
}

- (void)showPictureView:(UIButton *)btn {
    UIView *contentView = [btn superview];
    YCHcheckRecordTableViewCell *cell2 = (YCHcheckRecordTableViewCell *)[contentView superview];
    NSIndexPath *indexPath = [self indexPathForCell:cell2];
    
    YCHcheckRecordTableViewCell * cell = (YCHcheckRecordTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    if (btn.tag == hotelPictureFirstPhoto) {
        if (self.checkRecordTVDeleagte && [self.checkRecordTVDeleagte respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.checkRecordTVDeleagte clickHotelPictureShowSacleImage:cell.firstImageView.image];
        }
    } else if (btn.tag == hotelPictureSecondPhoto) {
        if (self.checkRecordTVDeleagte && [self.checkRecordTVDeleagte respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.checkRecordTVDeleagte clickHotelPictureShowSacleImage:cell.secondImageView.image];
        }
    } else {
        if (self.checkRecordTVDeleagte && [self.checkRecordTVDeleagte respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.checkRecordTVDeleagte clickHotelPictureShowSacleImage:cell.thirdImageView.image];
        }
    }
}

- (void)toCorrectInfo:(UIButton *)btn {
    UIView *contentView = [btn superview];
    YCHcheckRecordTableViewCell *cell = (YCHcheckRecordTableViewCell *)[contentView superview];
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (self.checkRecordTVDeleagte && [self.checkRecordTVDeleagte respondsToSelector:@selector(clickCorrectOrDetailsButton: contentDic:)]) {
        [self.checkRecordTVDeleagte clickCorrectOrDetailsButton:btn contentDic:self.itemArray[indexPath.row]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGPoint offset = self.contentOffset;
//    if (offset.y <= 0) {
//        offset.y = 0;
//    }
//    self.contentOffset = offset;
    if (self.checkRecordTVDeleagte && [self.checkRecordTVDeleagte respondsToSelector:@selector(checkRecoredTableViewDidScroll)]) {
        [self.checkRecordTVDeleagte checkRecoredTableViewDidScroll];
    }
}

@end
