//
//  YCHMessageDetailsKeyValueTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHMessageDetailsKeyValueTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *bottomLine;

- (void)updateCellWithDictionary:(NSDictionary *)dictionary;

@end
