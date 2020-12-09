//
//  YCHExamineDeductItemTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/16.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHExamineDeductItemTableViewCell.h"

@implementation YCHExamineDeductItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpdateConstraints {
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomLine.mas_top);
    }];
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UILabel *)itemLabel {
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _itemLabel.textColor = UMS_TEXT_BLACK;
        _itemLabel.font = [UIFont UMSChinaLightFontNameOfSize:14.f];
        _itemLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_itemLabel];
    }
    return _itemLabel;
}

@end
