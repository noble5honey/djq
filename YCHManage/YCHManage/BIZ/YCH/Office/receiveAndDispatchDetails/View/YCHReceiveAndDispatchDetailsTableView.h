//
//  YCHReceiveAndDispatchDetailsTableView.h
//  YCHManage
//
//  Created by sunny on 2020/7/21.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YCHReceiveAndDispatchDetailsTableViewDelegate <NSObject>

- (void)YCHReceiveAndDispatchDetailsTableViewTextViewDidChange:(UITextView *)textView;

- (void)reveceiveAndDispatchDetailsTableViewClickRevokeButton;

- (void)reveceiveAndDispatchDetailsTableViewClickDeleteButton;

@end

@interface YCHReceiveAndDispatchDetailsTableView : UITableView

@property (nonatomic, weak) id<YCHReceiveAndDispatchDetailsTableViewDelegate> detailsTVDelegate;

- (void)updateTableViewWithItemArray:(NSDictionary *)itemDic;

@end
