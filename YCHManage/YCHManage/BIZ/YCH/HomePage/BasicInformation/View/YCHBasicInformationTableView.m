//
//  YCHBasicInformationTableView.m
//  YCHManage
//
//  Created by sunny on 2020/9/14.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHBasicInformationTableView.h"
#import "YCHBasicInformationTableViewCell.h"
#import "YCHPictureTableViewCell.h"

static NSString * basicInfoCell = @"basic_info_cell_id";
static NSString * basicInfoPictureCell = @"picture_cell_id";

#define hotelPictureFirstPhoto             10001
#define hotelPictureSecondPhoto            10002
#define hotelPictureThirdPhoto             10003

@interface YCHBasicInformationTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YCHPictureTableViewCell *hotelPictureCell;

@property (nonatomic, strong) NSDictionary *basicInfoDic;

@property (nonatomic, strong) NSArray *picArray;

@property (nonatomic, strong) YCHBasicInformationTableViewCell *infoCell;

@end

@implementation YCHBasicInformationTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        [self registerClass:[YCHBasicInformationTableViewCell class] forCellReuseIdentifier:basicInfoCell];
        [self registerClass:[YCHPictureTableViewCell class] forCellReuseIdentifier:basicInfoPictureCell];
    }
    return self;
}

- (void)updateTableViewWithBasicInfoDictionary:(NSDictionary *)basicInfoDic {
    self.basicInfoDic = basicInfoDic;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    } else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void)updateTableViewWithHotelPictureArray:(NSArray *)picArray {
    self.picArray = picArray;
    if ([[NSThread currentThread] isMainThread]) {
        [self reloadData];
    } else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 11;
    } else {
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YCHBasicInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:basicInfoCell forIndexPath:indexPath];
        self.infoCell = cell;
        if (indexPath.row == 0) {
            [cell cellUpadteWithTitle:@"法人身份证号:" value:self.basicInfoDic[@"businessCode"]]; return cell;
        } else if (indexPath.row == 1) {
            [cell cellUpadteWithTitle:@"渔家乐名称:" value:self.basicInfoDic[@"fishName"]];
            return cell;
        }
//        else if (indexPath.row == 2) {
//            NSString *time = [NSString stringWithFormat:@"%@",self.basicInfoDic[@"businessRegisterTime"]];
//            [cell cellUpadteWithTitle:@"营业执照注册日期:" value:[NSString ConvertStrToTime:time]];
//            return cell;
//        } else if (indexPath.row == 3) {
//            NSString *time = [NSString stringWithFormat:@"%@",self.basicInfoDic[@"businessApprovalTime"]];
//            [cell cellUpadteWithTitle:@"营业执照颁发日期:" value:[NSString ConvertStrToTime:time]];
//            return cell;
//        }
        else if (indexPath.row == 2) {
            [cell cellUpadteWithTitle:@"食品卫生许可证编号:" value:self.basicInfoDic[@"hygieneCode"]];
            return cell;
        } else if (indexPath.row == 3) {
            NSString *time = [NSString stringWithFormat:@"%@",self.basicInfoDic[@"hygieneApprovalTime"]];
            [cell cellUpadteWithTitle:@"食品卫生许可证颁发日期:" value:[NSString ConvertStrToTime:time]];
            return cell;
        } else if (indexPath.row == 4) {
            NSString *time = [NSString stringWithFormat:@"%@",self.basicInfoDic[@"hygieneValidTime"]];
            [cell cellUpadteWithTitle:@"食品卫生许可证有效期至:" value:[NSString ConvertStrToTime:time]];
            return cell;
        } else if (indexPath.row == 5) {
            NSString *str = [NSString stringWithFormat:@"%@",self.basicInfoDic[@"isMember"]];
            NSString *isMember;
            if ([str isEqual:@"0"]) {
                isMember = @"否";
            } else {
                isMember = @"是";
            }
            [cell cellUpadteWithTitle:@"渔家乐协会成员单位:" value:isMember];
            return cell;
        } else if (indexPath.row == 6) {
            [cell cellUpadteWithTitle:@"法人:" value:self.basicInfoDic[@"contacts"]];
            return cell;
        } else if (indexPath.row == 7) {
            [cell cellUpadteWithTitle:@"联系电话:" value:self.basicInfoDic[@"contactsTel"]];
            return cell;
        } else if (indexPath.row == 8) {
            [cell cellUpadteWithTitle:@"地址:" value:self.basicInfoDic[@"fishAddress"]];
            return cell;
        } else if (indexPath.row == 9) {
            [cell cellUpadteWithTitle:@"星级:" value:[NSString stringWithFormat:@"%@",self.basicInfoDic[@"fishGrade"]]];
            return cell;
        } else if (indexPath.row == 10) {
            [cell cellUpadteWithTitle:@"所属片区:" value:self.basicInfoDic[@"fishArea"]];
            return cell;
        }
    } else {
        self.hotelPictureCell = [tableView dequeueReusableCellWithIdentifier:basicInfoPictureCell forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [self.hotelPictureCell.firstButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
            self.hotelPictureCell.firstButton.tag = hotelPictureFirstPhoto;
            [self.hotelPictureCell.secondButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
            self.hotelPictureCell.secondButton.tag = hotelPictureSecondPhoto;
            [self.hotelPictureCell.thirdButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
            self.hotelPictureCell.thirdButton.tag = hotelPictureThirdPhoto;
            [self.hotelPictureCell updatePictureWithUrlArray:self.basicInfoDic[@"fishPicIos"]];
            return self.hotelPictureCell;
        } else if (indexPath.row == 1) {
            self.hotelPictureCell.titleLabel.text = @"营业执照:";
            [self.hotelPictureCell.firstButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
            self.hotelPictureCell.firstButton.tag = hotelPictureFirstPhoto;
            [self.hotelPictureCell.secondButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
            self.hotelPictureCell.secondButton.tag = hotelPictureSecondPhoto;
            [self.hotelPictureCell.thirdButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
            self.hotelPictureCell.thirdButton.tag = hotelPictureThirdPhoto;
            [self.hotelPictureCell updatePictureWithUrlArray:self.basicInfoDic[@"businessPicIos"]];
            return self.hotelPictureCell;
        } else if (indexPath.row == 2) {
            self.hotelPictureCell.titleLabel.text = @"卫生许可证:";
            [self.hotelPictureCell.firstButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
            self.hotelPictureCell.firstButton.tag = hotelPictureFirstPhoto;
            [self.hotelPictureCell.secondButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
            self.hotelPictureCell.secondButton.tag = hotelPictureSecondPhoto;
            [self.hotelPictureCell.thirdButton addTarget:self action:@selector(showPictureView:) forControlEvents:UIControlEventTouchUpInside];
            self.hotelPictureCell.thirdButton.tag = hotelPictureThirdPhoto;
            [self.hotelPictureCell updatePictureWithUrlArray:self.basicInfoDic[@"hygienePicIos"]];
             return self.hotelPictureCell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 8 || indexPath.row == 1) {
            return [self.infoCell cellHeight];
        } else {
            return 44;
        }
    }
    if (indexPath.section == 1) {
        return 80;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)showPictureView:(UIButton *)btn {
    
    UIView *contentView = [btn superview];
    YCHPictureTableViewCell *cell2 = (YCHPictureTableViewCell *)[contentView superview];
    NSIndexPath *indexPath = [self indexPathForCell:cell2];
//    YCHPictureTableViewCell *cell = (YCHPictureTableViewCell *)[btn superview];
//    NSIndexPath *indexPath = [self indexPathForCell:cell];
    YCHPictureTableViewCell * cell = (YCHPictureTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    if (btn.tag == hotelPictureFirstPhoto) {
        if (self.basicInfoTVDeleagte && [self.basicInfoTVDeleagte respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.basicInfoTVDeleagte clickHotelPictureShowSacleImage:cell.firstImageView.image];
        }
    } else if (btn.tag == hotelPictureSecondPhoto) {
        if (self.basicInfoTVDeleagte && [self.basicInfoTVDeleagte respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.basicInfoTVDeleagte clickHotelPictureShowSacleImage:cell.secondImageView.image];
        }
    } else {
        if (self.basicInfoTVDeleagte && [self.basicInfoTVDeleagte respondsToSelector:@selector(clickHotelPictureShowSacleImage:)]) {
            [self.basicInfoTVDeleagte clickHotelPictureShowSacleImage:cell.thirdImageView.image];
        }
    }
}

@end
