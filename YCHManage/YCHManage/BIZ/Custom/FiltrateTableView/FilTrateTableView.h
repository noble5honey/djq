//
//  FilTrateTableView.h
//  YCHManage
//
//  Created by sunny on 2020/9/18.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHExamineDeductItemTableViewCell.h"

@protocol filTrateTableViewDelegate <NSObject>

- (void)clickStartTextFiled:(UITextField *)textField;

- (void)clickEndTextFiled:(UITextField *)textField;

- (void)filtrateTableViewDidSelectedRowWithIndexPath:(NSIndexPath *)indexPath cell:(YCHExamineDeductItemTableViewCell *)cell;

@end

@interface FilTrateTableView : UITableView

@property (nonatomic, weak) id<filTrateTableViewDelegate> filtrateTVdelegate;

- (void)updateSectionTitleArray:(NSArray *)titleArray itemArray:(NSArray *)itemArray;

@end
