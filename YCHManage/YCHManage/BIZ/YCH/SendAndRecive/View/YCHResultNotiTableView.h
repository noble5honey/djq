//
//  YCHResultNotiTableView.h
//  YCHManage
//
//  Created by sunny on 2020/9/23.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCHResultNotiTableViewDelegate <NSObject>

- (void)resultNotiTableViewDidSelectRowWithDictionary:(NSDictionary *)dic;

- (void)resultNotiTableViewDidScroll;

@end

@interface YCHResultNotiTableView : UITableView

@property (nonatomic, weak) id<YCHResultNotiTableViewDelegate>resultNotiTVDelegate;

- (void)updateResultNotiTableViewWithContenArray:(NSArray *)contentArray;

@end

