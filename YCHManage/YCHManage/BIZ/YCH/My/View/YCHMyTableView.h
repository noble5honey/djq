//
//  YCHMyTableView.h
//  YCHManage
//
//  Created by sunny on 2020/10/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YCHMyTableViewDelegate <NSObject>

- (void)logOut;

@end

@interface YCHMyTableView : UITableView

@property (nonatomic, weak) id<YCHMyTableViewDelegate> myTableViewDelegate;

@end

NS_ASSUME_NONNULL_END
