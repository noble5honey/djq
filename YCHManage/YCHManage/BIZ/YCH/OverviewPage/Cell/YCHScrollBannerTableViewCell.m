//
//  YCHScrollBannerTableViewCell.m
//  YCHManage
//
//  Created by sunny on 2020/11/20.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "YCHScrollBannerTableViewCell.h"
#import "YCHScrollBannerView.h"

@interface YCHScrollBannerTableViewCell ()<ECAutoScrollBannerDelegate>

@property (nonatomic, strong) ECAutoScrollBanner *viewBannerView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *mutArray;

@property (nonatomic, strong) NSArray <YCHRecentNotificationModel*> *itemArray;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger viewCount;

@property (nonatomic, strong) YCHScrollBannerView *leftView;

@property (nonatomic, strong) YCHScrollBannerView *centerView;

@property (nonatomic, strong) YCHScrollBannerView *rightView;

@property (nonatomic, assign) NSInteger autoCount;

@property (nonatomic, strong) ECAutoScrollBanner *textBannerView;

@property (nonatomic, strong) NSMutableArray *textDataArray;

@end

@implementation YCHScrollBannerTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpdateConstraints];
        self.backgroundColor = UMS_TABLE_BG_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpdateConstraints {
    [self.contentBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentBackgroundView).offset(8);
        make.right.equalTo(self.contentBackgroundView).offset(-8);
        make.top.equalTo(self.contentBackgroundView).offset(8);
        make.height.mas_equalTo(25);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headerLabel);
        make.top.equalTo(self.headerLabel.mas_bottom);
        make.bottom.equalTo(self.contentBackgroundView);
    }];
//    [self addScrollBannerView];
}


- (void)updateCellWithRecentNotificationModelArray:(NSArray<YCHRecentNotificationModel *> *)bannerArry {
    if (bannerArry == nil || bannerArry.count == 0) {
        return;
    }
    self.itemArray = bannerArry;
    self.textDataArray = [NSMutableArray array];
//    if (self.itemArray.count > 0) {
//        for (int i = 0; i < self.itemArray.count; i++) {
//            NSString *timeStr = [NSString stringWithFormat:@"%ld",self.itemArray[i].createTime];
//            NSString *nameStr = [NSString stringWithFormat:@"%@",self.itemArray[i].fishName];
//            NSString *departmentStr = [NSString stringWithFormat:@"%@",self.itemArray[i].roleName];
//            if ([nameStr isEqual:@"(null)"]) {
//                nameStr = @"";
//            }
//            if ([departmentStr isEqual:@"(null)"]) {
//                departmentStr = @"";
//            }
//            [self.textDataArray addObject:[NSString stringWithFormat:@"渔家乐名称:  %@\n检查部门:     %@\n检查时间:     %@",nameStr,departmentStr,[NSString ConvertStrToTime:timeStr]]];
//        }
//    }
    if (self.itemArray.count > 0) {
        for (int i = 0; i < self.itemArray.count; i++) {
            NSString *timeStr = [NSString stringWithFormat:@"%ld",self.itemArray[i].createTime];
            NSString *nameStr = [NSString stringWithFormat:@"%@",self.itemArray[i].fishName];
            NSString *departmentStr = [NSString stringWithFormat:@"%@",self.itemArray[i].roleName];
            NSString *matterName = [NSString stringWithFormat:@"%@",self.itemArray[i].matterName];
            NSString *matterScore = [NSString stringWithFormat:@"%ld",self.itemArray[i].matterScore];
            if ([nameStr isEqual:@"(null)"]) {
                nameStr = @"";
            }
            if ([departmentStr isEqual:@"(null)"]) {
                departmentStr = @"";
            }
            [self.textDataArray addObject:[NSString stringWithFormat:@"%@ 因%@于%@被扣除分数%@",nameStr,matterName,[NSString ConvertStrToTime:timeStr],matterScore]];
        }
    }
    [self addSubview:self.textBannerView];
}

//- (void)addScrollViews {
//    if (self.itemArray.count > 2) {
//
//    } else {
//        return;
//    }
//    self.leftView = [[YCHScrollBannerView alloc] initWithFrame:CGRectMake(16, 0, Width_Screen-32, 110)];
//    [self.scrollView addSubview:self.leftView];
//
//    self.centerView = [[YCHScrollBannerView alloc] initWithFrame:CGRectMake(16, 110, Width_Screen-32, 110)];
//    [self.scrollView addSubview:self.centerView];
//
//    self.rightView = [[YCHScrollBannerView alloc] initWithFrame:CGRectMake(16, 220, Width_Screen-32, 110)];
//    [self.scrollView addSubview:self.rightView];
//
//}

//- (void)setDefaultContent {
//    self.leftView.nameDetailsLabel.text = self.itemArray[2][@"name"];
//    self.leftView.departmentDetailsLabel.text = self.itemArray[2][@"department"];
//    self.leftView.timeDetailsLabel.text = self.itemArray[2][@"time"];
//
//    self.centerView.nameDetailsLabel.text = self.itemArray[0][@"name"];
//    self.centerView.departmentDetailsLabel.text = self.itemArray[0][@"department"];
//    self.centerView.timeDetailsLabel.text = self.itemArray[0][@"time"];
//
//    self.rightView.nameDetailsLabel.text = self.itemArray[1][@"name"];
//    self.rightView.departmentDetailsLabel.text = self.itemArray[1][@"department"];
//    self.rightView.timeDetailsLabel.text = self.itemArray[1][@"time"];
//
//    self.viewCount = 0;
//
//}

- (void)startTimer {
    self.viewCount = 0;
    self.autoCount = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(nextView) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
  }
  //停止计时器
- (void)stopTimer {
    //结束计时
    [self.timer invalidate];
    //计时器被系统强引用，必须手动释放
    self.timer = nil;
    
}

- (void)nextView {
    
    self.viewCount = self.viewCount + 1;
    self.autoCount = self.autoCount + 1;
    if (self.viewCount < self.itemArray.count) {
        [self.scrollView setContentOffset:CGPointMake(0, self.viewCount * 110) animated:YES];
    } else {
//        [self reloadImage];
//        //移动回中间
//        self.scrollView.contentOffset = CGPointMake(16, 110);

        self.viewCount = 0;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
 }

- (void)tapScrollBannerItem:(NSInteger)itemTag withObject:(id)object {
    
}
//-(void)reloadImage
//{
//    NSInteger leftImageIndex,rightImageIndex;
//
//    CGPoint offset = self.scrollView.contentOffset;
//
//    if (offset.x > 110) {//向右滑动
//        self.viewCount = (self.viewCount+1)%self.itemArray.count;
//    }else if(offset.x < 110){//向左滑动
//        self.viewCount = (self.viewCount+self.itemArray.count-1)%self.itemArray.count;
//    }
//    self.centerView.nameDetailsLabel.text = self.itemArray[self.viewCount][@"name"];
//    self.centerView.departmentDetailsLabel.text = self.itemArray[self.viewCount][@"department"];
//    self.centerView.timeDetailsLabel.text = self.itemArray[self.viewCount][@"time"];
//
//    leftImageIndex = (self.viewCount+self.itemArray.count-1)%self.itemArray.count;
//    rightImageIndex = (self.viewCount+1)%self.itemArray.count;
//
//    self.leftView.nameDetailsLabel.text = self.itemArray[leftImageIndex][@"name"];
//    self.leftView.departmentDetailsLabel.text = self.itemArray[leftImageIndex][@"department"];
//    self.leftView.timeDetailsLabel.text = self.itemArray[leftImageIndex][@"time"];
//
//    self.rightView.nameDetailsLabel.text = self.itemArray[rightImageIndex][@"name"];
//    self.rightView.departmentDetailsLabel.text = self.itemArray[rightImageIndex][@"department"];
//    self.rightView.timeDetailsLabel.text = self.itemArray[rightImageIndex][@"time"];
//}


//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //重新加载图片
//    [self reloadImage];
//    //移动回中间
//    self.scrollView.contentOffset = CGPointMake(16, 110);
//    //修改分页控件上的小圆点
////    _pageControl.currentPage = _currentImageIndex;
//}

//滚动停止事件  decelerate 减速,减缓

//- (ECAutoScrollBanner *)viewBannerView {
//    if (_viewBannerView == nil) {
//        _viewBannerView = [[ECAutoScrollBanner alloc] initViewBannerWithFrame:CGRectMake(16, 41, Width_Screen-32, 110) withViewsDataSouce:self.mutArray withBannerScrollDirection:ECAutoScrollBannerScrollDirectionVertical];
//        _viewBannerView.isAutoPaging = YES;
////        _viewBannerView.isInfinitePaging = YES;
//        _viewBannerView.isEnabledPanGestureRecognizer = YES;
//        [self addSubview:_viewBannerView];
//    }
//    return _viewBannerView;
//}
- (ECAutoScrollBanner *)textBannerView {
    if (_textBannerView == nil) {
        _textBannerView = [ECAutoScrollBanner initTextBannerWithFrame:CGRectMake(32, 55, Width_Screen-64, 90) withTextDataSource:self.textDataArray withBannerScrollDirection:ECAutoScrollBannerScrollDirectionVertical];
        _textBannerView.delegate = self;
        _textBannerView.isAutoPaging = YES;
        _textBannerView.isHavePageControl = NO;
        _textBannerView.isInfinitePaging = YES;
        _textBannerView.isEnabledPanGestureRecognizer = NO;
        _textBannerView.autoPageInterval = 4.0f;
    }
    return _textBannerView;
}

- (UIView *)contentBackgroundView {
    if (!_contentBackgroundView) {
        _contentBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentBackgroundView.backgroundColor = [UIColor whiteColor];
        _contentBackgroundView.layer.cornerRadius = 10;
        [self.contentView addSubview:_contentBackgroundView];
    }
    return _contentBackgroundView;
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _headerLabel.textAlignment = NSTextAlignmentLeft;
        _headerLabel.font = [UIFont ChinaDefaultFontNameOfSize:15.f];
        _headerLabel.textColor = UMS_TEXT_BLACK;
        _headerLabel.text = @"近期检查通告";
        [self.contentBackgroundView addSubview:_headerLabel];
    }
    
    return _headerLabel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        //横竖两种滚轮都不显示
        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(Width_Screen-32, 110*3);

        [self.contentBackgroundView addSubview:_scrollView];
        //在scrollView中添加三个图片按钮，因为后面需要响应点击事件，所以我直接用按钮不用imageView了，感觉更方便一些
//        for (int i = 0;i < imageBtnCount; i++) {
//        UIButton *imageBtn = [[UIButton alloc] init];
//        [scrollView addSubview:imageBtn];
//        }
    }
    return _scrollView;;
}

@end

