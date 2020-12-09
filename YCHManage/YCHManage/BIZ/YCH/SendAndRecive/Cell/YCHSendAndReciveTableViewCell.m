//
//  YCHSendAndReciveTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/9/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHSendAndReciveTableViewCell.h"

@implementation YCHSendAndReciveTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)updateCellContentWithDictionary:(NSDictionary *)dictionary {
    NSString *isMySend = [NSString stringWithFormat:@"%@",dictionary[@"isMySend"]];
    if ([isMySend isEqual:@"0"]) {//不是我发送的 是接收的
        self.statusLabel.text = @"收";
        self.departmentLabel.text = dictionary[@"sendName"];
        self.statusLabel.layer.backgroundColor = [UIColor orangeColor].CGColor;
    } else {
        self.statusLabel.text = @"发";
        self.statusLabel.layer.backgroundColor = [UIColor greenColor].CGColor;
        NSArray *receiveNames = dictionary[@"receiveNames"];
        NSString *receiveNamesStr = @"";
        for (int i = 0; i<receiveNames.count; i++) {
            if (i == 0) {
                receiveNamesStr = [NSString stringWithFormat:@"%@",receiveNames[i]];
            } else {
                receiveNamesStr = [NSString stringWithFormat:@"%@、%@",receiveNamesStr,receiveNames[i]];
            }
        }
        self.departmentLabel.text = receiveNamesStr;
    }
    self.themeLabel.text = [NSString stringWithFormat:@"%@",dictionary[@"topic"]];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",dictionary[@"body"]];
    self.dateLabel.text = [NSString ConvertStrToTime:[NSString stringWithFormat:@"%@",dictionary[@"createTime"]]];
//    NSString *readStatusStr = [NSString stringWithFormat:@"%@",dictionary[@"isRead"]];
//    if ([readStatusStr isEqual:@"<null>"]) {
//        self.readLabel.text = @"";
//    } else if ([readStatusStr isEqual:@"1"]) {
//        self.readLabel.text = @"已读";
//    } else if ([readStatusStr isEqual:@"0"]) {
//        self.readLabel.text = @"未读";
//    }
}

- (void)updateNotiCellContentDictionary:(NSDictionary *)dictionary {
    NSString *isMySend = [NSString stringWithFormat:@"%@",dictionary[@"isMySend"]];
    if ([isMySend isEqual:@"0"]) {//不是我发送的 是接收的
        self.statusLabel.text = @"收";
        self.statusLabel.layer.backgroundColor = [UIColor orangeColor].CGColor;
        self.departmentLabel.text = dictionary[@"sendName"];
    } else {
        self.statusLabel.text = @"发";
        self.statusLabel.layer.backgroundColor = [UIColor greenColor].CGColor;
        NSArray *receiveNames = dictionary[@"receiveNames"];
        NSString *receiveNamesStr = @"";
        for (int i = 0; i<receiveNames.count; i++) {
            if (i == 0) {
                receiveNamesStr = [NSString stringWithFormat:@"%@",receiveNames[i]];
            } else {
                receiveNamesStr = [NSString stringWithFormat:@"%@、%@",receiveNamesStr,receiveNames[i]];
            }
        }
        self.departmentLabel.text = receiveNamesStr;
    }
    self.themeLabel.text = [NSString stringWithFormat:@"%@",dictionary[@"topic"]];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",dictionary[@"body"]];
    self.dateLabel.text = [NSString ConvertStrToTime:[NSString stringWithFormat:@"%@",dictionary[@"createTime"]]];
//    NSString *readStatusStr = [NSString stringWithFormat:@"%@",dictionary[@"isRead"]];
//    if ([readStatusStr isEqual:@"<null>"]) {
//        self.readLabel.text = @"";
//    } else if ([readStatusStr isEqual:@"1"]) {
//        self.readLabel.text = @"已读";
//    } else if ([readStatusStr isEqual:@"0"]) {
//        self.readLabel.text = @"未读";
//    }
}

-(void)setUpdateConstraints {
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right).offset(8);
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self.dateLabel.mas_left).offset(-5);
        make.height.mas_equalTo(15);
    }];
    
    [self.themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.departmentLabel);
//        make.top.equalTo(self.departmentLabel.mas_bottom).offset(5);
        make.top.equalTo(self.departmentLabel.mas_bottom).offset(5);

    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.themeLabel);
//        make.top.equalTo(self.themeLabel.mas_bottom).offset(5);
        make.top.equalTo(self.themeLabel.mas_bottom);
        make.height.mas_equalTo(35);

    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.departmentLabel);
        make.right.equalTo(self).offset(-12);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-8);
    }];
    
    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.arrowImageView.mas_left).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.text = @"收";
        _statusLabel.layer.backgroundColor = [UIColor orangeColor].CGColor;
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.layer.cornerRadius = 10;
        _statusLabel.font = [UIFont ChinaDefaultFontNameOfSize:12];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (UILabel *)departmentLabel {
    if (!_departmentLabel) {
        _departmentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _departmentLabel.font = [UIFont ChinaDefaultFontNameOfSize:13];
        _departmentLabel.textAlignment = NSTextAlignmentLeft;
        _departmentLabel.textColor = UMS_TEXT_BLACK;
        _departmentLabel.text = @"外事办、水务局";
        [self addSubview:_departmentLabel];
    }
    return _departmentLabel;
}

- (UILabel *)themeLabel {
    if (!_themeLabel) {
        _themeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _themeLabel.font = [UIFont UMSChinaLightFontNameOfSize:12];
        _themeLabel.textAlignment = NSTextAlignmentLeft;
        _themeLabel.textColor = UMS_TEXT_BLACK;
        _themeLabel.text = @"这是一段标题测试这是一段标题测试这是一段标题测试";
        [self addSubview:_themeLabel];
    }
    return _themeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont UMSChinaLightFontNameOfSize:12];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = UMS_GRAY_150;
        _contentLabel.numberOfLines = 2;
        _contentLabel.text = @"这是一段内容测试这是一段内容测试这是一段内容测试";
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UILabel *)readLabel {
    if (!_readLabel) {
        _readLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _readLabel.font = [UIFont UMSChinaLightFontNameOfSize:12];
        _readLabel.textAlignment = NSTextAlignmentRight;
        _readLabel.textColor = UMS_GRAY_150;
        [self addSubview:_readLabel];
    }
    return _readLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel.font = [UIFont UMSChinaLightFontNameOfSize:13.f];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.textColor = UMS_GRAY_150;
        _dateLabel.text = @"12月10日";
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = UMS_LINE_COLOR;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _arrowImageView.image = [UIImage imageNamed:@"arrowright-small"];
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}

@end
