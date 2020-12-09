//
//  MposSegmentedControl.m
//  UMSMposI
//
//  Created by limin on 17/2/28.
//  Copyright © 2017年 chinaums. All rights reserved.
//

#import "YCHLoginSegmentedControl.h"
#define MPOS_GREY_150                                                    \
[UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1.0]

#define MPOS_THEME_COLOR                                                    \
[UIColor colorWithRed:0 / 255.0 green:118 / 255.0 blue:254 / 255.0 alpha:0.99]

#define MPOS_LINE_COLOR                                                    \
[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0]

#define SEGMENTED_LINE_HEIGHT                             2.f
#define SEGMENTED_DEFAULT_TITLE_FONT          [UIFont systemFontOfSize:16.f]
#define LINE_BACKGROUND_HEIGHT                             1.f
#define LINE_ANIMATION_INTERVAL                            0.2f

#define SEGMENTED_DEFAULT_BACKGROUND_COLOR                                         \
[UIColor colorWithRed:240 / 255.0 green:245 / 255.0 blue:246 / 255.0 alpha:1.0]

@interface YCHLoginSegmentedControl()

@property (nonatomic, weak)id target;

@property (nonatomic, copy)NSString *selector;

@property (nonatomic, strong)NSArray *itemsArray;

@property (nonatomic,strong) UIView *bottomLineView;

@property (nonatomic, strong)UIView *backgroundLineView;

@property (nonatomic, strong)UIView *selectedLineView;

@property (nonatomic, assign) float selectedLineWidth;

@end

@implementation YCHLoginSegmentedControl

- (instancetype)initWithItems:(NSArray *)items target:(id)target selector:(SEL)selector width:(float)width{
	if (self = [super initWithFrame:CGRectZero]) {
		self.itemsArray = items;
		self.target = target;
		self.selector = NSStringFromSelector(selector);
		self.selectedLineWidth = self.itemsArray.count <= 0? 0: width / self.itemsArray.count;
		[self setUpConstraints];
		[self initSubView];
	}
	return self;
}

- (void)setUpConstraints{
	
	[self.customSegmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
	
	[self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.left.right.equalTo(self);
		make.height.mas_equalTo(SEGMENTED_LINE_HEIGHT);
	}];
	
	[self.backgroundLineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.left.right.equalTo(self.bottomLineView);
		make.height.mas_equalTo(LINE_BACKGROUND_HEIGHT);
	}];
	
	[self.selectedLineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.left.top.bottom.equalTo(self.bottomLineView);
		make.width.mas_equalTo(self.selectedLineWidth);
	}];
}

- (void)initSubView{
	[self.customSegmentedControl addTarget:self.target action:NSSelectorFromString(self.selector) forControlEvents:UIControlEventValueChanged];
	
	[self.customSegmentedControl addTarget:self action:@selector(segmentedSelectToLineAtIndex:) forControlEvents:UIControlEventValueChanged];
	
	NSDictionary *unselectedTextAttribute = @{NSFontAttributeName:SEGMENTED_DEFAULT_TITLE_FONT,NSForegroundColorAttributeName:MPOS_GREY_150};
	
	[self.customSegmentedControl setTitleTextAttributes:unselectedTextAttribute forState:UIControlStateNormal];
	
	NSDictionary *selectedTextAttribute = @{NSFontAttributeName:SEGMENTED_DEFAULT_TITLE_FONT,NSForegroundColorAttributeName:UMS_THEME_COLOR};
	
	[self.customSegmentedControl setTitleTextAttributes:selectedTextAttribute forState:UIControlStateSelected];
	
}

- (UISegmentedControl *)customSegmentedControl{
	if (!_customSegmentedControl) {
		_customSegmentedControl = [[UISegmentedControl alloc] initWithItems:self.itemsArray];
//        _customSegmentedControl.backgroundColor = SEGMENTED_DEFAULT_BACKGROUND_COLOR;
        _customSegmentedControl.backgroundColor = [UIColor whiteColor];
//        _customSegmentedControl.tintColor = SEGMENTED_DEFAULT_BACKGROUND_COLOR;
        _customSegmentedControl.tintColor = [UIColor whiteColor];
		_customSegmentedControl.selectedSegmentIndex = 0;
		[self addSubview:_customSegmentedControl];
	}
	return  _customSegmentedControl;
}

- (UIView *)bottomLineView{
	if (!_bottomLineView) {
		_bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
		_bottomLineView.backgroundColor = SEGMENTED_DEFAULT_BACKGROUND_COLOR;
		_bottomLineView.tintColor = SEGMENTED_DEFAULT_BACKGROUND_COLOR;
		[self addSubview:_bottomLineView];
	}
	return _bottomLineView;
}

- (UIView *)backgroundLineView{
	if (!_backgroundLineView) {
		_backgroundLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundLineView.backgroundColor = UMS_TEXT_FIELD_COLOR;
		[self.bottomLineView addSubview:_backgroundLineView];
	}
	return _backgroundLineView;
}

- (UIView *)selectedLineView{
	if (!_selectedLineView) {
		_selectedLineView = [[UIView alloc] initWithFrame:CGRectZero];
		_selectedLineView.backgroundColor = UMS_THEME_COLOR;
		[self.bottomLineView addSubview:_selectedLineView];
	}
	return _selectedLineView;
}

#pragma mark - "segment 被点击事件"
- (void)segmentedSelectToLineAtIndex:(UISegmentedControl *)segmentedControl{
	self.selectedSegmentedIndex = segmentedControl.selectedSegmentIndex;
	[self lineSelectedAtIndex:self.selectedSegmentedIndex];
}

- (void)lineSelectedAtIndex:(NSInteger)index{
	[self.selectedLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.top.bottom.equalTo(self.bottomLineView);
		make.width.mas_equalTo(self.selectedLineWidth);
		make.left.equalTo(self.bottomLineView).with.offset((float)index * self.selectedLineWidth);
	}];
	[self setNeedsLayout];
	[UIView animateWithDuration:LINE_ANIMATION_INTERVAL animations:^{
		[self layoutIfNeeded];
	}];
}

@end
