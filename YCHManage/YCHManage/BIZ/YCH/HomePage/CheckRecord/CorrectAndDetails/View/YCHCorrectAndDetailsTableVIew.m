//
//  YCHCorrectAndDetailsTableVIew.m
//  YCHManage
//
//  Created by sunny on 2020/9/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHCorrectAndDetailsTableVIew.h"
#import "YCHcheckRecordTableViewCell.h"
#import "YCHTableViewFooterView.h"

static NSString * examineUploadCellID = @"examine_upload_cell_id";
static NSString * examineFootViewID = @"examine_footView_id";

#define BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT 112.0f;
#define hotelPictureFirstPhoto             10001
#define hotelPictureSecondPhoto            10002
#define hotelPictureThirdPhoto             10003

static NSString * checkRecordCellID = @"check_record_cell_id";


@interface YCHCorrectAndDetailsTableVIew ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) YCHcheckRecordTableViewCell *checkRecordCell;

@property (nonatomic, strong) YCHExamineTableViewCell *cell;

@property (nonatomic, strong) NSString *limitText;

@property (nonatomic, strong) NSDictionary *itemDic;

@end

@implementation YCHCorrectAndDetailsTableVIew
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHcheckRecordTableViewCell class] forCellReuseIdentifier:checkRecordCellID];
        [self registerClass:[YCHExamineTableViewCell class] forCellReuseIdentifier:examineUploadCellID];
        [self registerClass:[YCHTableViewFooterView class] forHeaderFooterViewReuseIdentifier:examineFootViewID];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.cell.recordTextView) {
        return;;
    }
    [self.cell.recordTextView resignFirstResponder];
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
        self.cell.recordTextView.delegate = self;
        return  self.cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        return 190.5f;
        return [self.checkRecordCell cellHeight];
    } else {
        return 240.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)showPictureView:(UIButton *)btn {
    if (btn.tag == hotelPictureFirstPhoto) {
        if (self.correctAndDetailsTVDelegate && [self.correctAndDetailsTVDelegate respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.correctAndDetailsTVDelegate clickHotelPictureShowSacleImage:self.checkRecordCell.firstImageView.image];
        }
    } else if (btn.tag == hotelPictureSecondPhoto) {
        if (self.correctAndDetailsTVDelegate && [self.correctAndDetailsTVDelegate respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.correctAndDetailsTVDelegate clickHotelPictureShowSacleImage:self.checkRecordCell.secondImageView.image];
        }
    } else {
        if (self.correctAndDetailsTVDelegate && [self.correctAndDetailsTVDelegate respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.correctAndDetailsTVDelegate clickHotelPictureShowSacleImage:self.checkRecordCell.thirdImageView.image];
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
//    dateLabel.text = @"2020-09-22";
    if (section == 0) {
        titleLB.text = @"扣分详情";
    } else if (section == 1) {
        titleLB.text = @"整改详情";
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)textViewDidChange:(UITextView *)textView {
    UITextRange *markRange = textView.markedTextRange;
    NSInteger pos = [textView offsetFromPosition:markRange.start
                                      toPosition:markRange.end];
    NSInteger nLength = textView.text.length - pos;
    if (nLength > 150 && pos == 0) {
        self.cell.recordTextView.text = self.limitText;
    } else {
        self.cell.tagLabel.text = [NSString stringWithFormat:@"%ld/150",(long)nLength];
        self.limitText = textView.text;
    }
//    if (textView.text.length > 150) {
//                textView.text = [textView.text substringToIndex:150];
//            }
    if (self.correctAndDetailsTVDelegate && [self.correctAndDetailsTVDelegate respondsToSelector:@selector(correctAndDetailsTableViewTextViewDidChange:)]) {
        [self.correctAndDetailsTVDelegate correctAndDetailsTableViewTextViewDidChange:textView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return BIND_PARK_CARD_COMPLETE_FOOTER_HEIGHT;
    } else {
        return 0.000001f;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        YCHTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:examineFootViewID];
        footerView.backgroundColor = UMS_TABLE_BG_COLOR;
        [footerView.nextBtn addTarget:self action:@selector(clickCommitButton) forControlEvents:UIControlEventTouchUpInside];
        [footerView.nextBtn setTitle:@"提交" forState:UIControlStateNormal];
        return footerView;
    }
    return nil;
}

- (void)clickCommitButton {
    if (self.correctAndDetailsTVDelegate && [self.correctAndDetailsTVDelegate respondsToSelector:@selector(correctAndDetailsTableViewClickCommitButton)]) {
        [self.correctAndDetailsTVDelegate correctAndDetailsTableViewClickCommitButton];
    }
}

- (void)uploadImage:(UIButton *)btn {
    if (btn.tag == 1001) {
        if (self.correctAndDetailsTVDelegate && [self.correctAndDetailsTVDelegate respondsToSelector:@selector(correctAndDetailTableViewClickFirstButtonWithCell:)]) {
            [self.correctAndDetailsTVDelegate correctAndDetailTableViewClickFirstButtonWithCell:self.cell];
        }
    } else if (btn.tag == 1002) {
        if (self.correctAndDetailsTVDelegate && [self.correctAndDetailsTVDelegate respondsToSelector:@selector(correctAndDetailTableViewClickSecondButtonWithCell:)]) {
            [self.correctAndDetailsTVDelegate correctAndDetailTableViewClickSecondButtonWithCell:self.cell];
        }
    } else {
        if (self.correctAndDetailsTVDelegate && [self.correctAndDetailsTVDelegate respondsToSelector:@selector(correctAndDetailTableViewClickThirdButtonWithCell:)]) {
            [self.correctAndDetailsTVDelegate correctAndDetailTableViewClickThirdButtonWithCell:self.cell];
        }
    }
    
}

@end
