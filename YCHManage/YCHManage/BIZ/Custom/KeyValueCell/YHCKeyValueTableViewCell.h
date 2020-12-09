//
//  YHCKeyValueTableViewCell.h
//  YCHManage
//
//  Created by sunny on 2020/6/11.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHCKeyValueTableViewCell : UITableViewCell

@property(nonatomic,strong)UITextField * cardNoTF;
@property(nonatomic,strong)UILabel     * cardNoL;
@property(nonatomic,strong)UIView     *bottomLine;

-(void)updateCellContentWithCardLTitle:(NSString *)Ltitle andCardTFPlaceHolder:(NSString *)placeHolder andCardTFTitle:(NSString *)tfTitle;


@end
