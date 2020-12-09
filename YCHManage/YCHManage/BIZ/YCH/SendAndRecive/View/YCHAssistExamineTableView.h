//
//  YCHAssistExamineTableView.h
//  YCHManage
//
//  Created by sunny on 2020/9/22.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCHAssistExamineTableViewDelegate <NSObject>

- (void)assistExamineTableViewDidSelectRowWithDictionary:(NSDictionary *)dic;

- (void)assistExamineTableViewDidScroll;

@end

@interface YCHAssistExamineTableView : UITableView

@property (nonatomic, weak) id<YCHAssistExamineTableViewDelegate>assistExamineTVDelegate;

- (void)updateAssistExamineTableViewWithContentArray:(NSArray *)contentArray;

@end
