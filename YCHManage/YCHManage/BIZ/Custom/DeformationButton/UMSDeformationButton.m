//
//  UMSDeformationButton.m
//  ChinaUMS
//
//  Created by ums on 16/2/13.
//  Copyright © 2016年 ChinaUMS. All rights reserved.
//

#import "UMSDeformationButton.h"
#import "UMSSpinnerView.h"

@interface UMSDeformationButton ()

@property(nonatomic, strong) UMSSpinnerView *spinnerView;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation UMSDeformationButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType withColor:(UIColor*)color {
    
    UMSDeformationButton *button = [super buttonWithType:buttonType];
    if (button) {
        
        [button addObserver];
        
        [button initSubViewsWithColor:(UIColor*)color];
        
        [button setUpConstrain];
    }
    return button;
    
}

- (void)addObserver {
    [self addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"backgroundColor"]) {
        if (!self.isLoading) {
            self.bgView.backgroundColor = change[NSKeyValueChangeNewKey];
        }
    }
    
}

- (void)initSubViewsWithColor:(UIColor*)color{

    self.bgView = [[UIView alloc]initWithFrame:CGRectZero];
    self.bgView.userInteractionEnabled = NO;
    self.bgView.hidden = YES;
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = NO;
    [self addSubview:self.bgView];
    
        
    //[self.forDisplayButton setBackgroundImage:[[self imageWithColor:color cornerRadius:3] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
//    [self addSubview:self.displayView];
    
    
    self.spinnerView = [[UMSSpinnerView alloc] initWithFrame:CGRectZero];
    
    self.spinnerView.tintColor = [UIColor whiteColor];
    self.spinnerView.lineWidth = 2;
    self.spinnerView.center = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
    self.spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.spinnerView.userInteractionEnabled = NO;
    [self addSubview:self.spinnerView];
    
}

- (void)setUpConstrain {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(void)setIsLoading:(BOOL)isLoading{
    _isLoading = isLoading;
    if (_isLoading) {
        [self startLoading];
    }else{
        [self stopLoading];
    }
}

//- (void)loadingAction{
//    if (self.isLoading) {
//        [self stopLoading];
//    }else{
//        [self startLoading];
//    }
//}

- (void)startLoading{
        
//    self.isLoading = YES;
    
    CGFloat defaultW = self.bgView.frame.size.width;
    CGFloat defaultH = self.bgView.frame.size.height;
    CGFloat defaultR = self.bgView.layer.cornerRadius;
    CGFloat scale = 1.2;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:defaultR];
    animation.toValue = [NSNumber numberWithFloat:defaultH*scale*0.5];
    animation.duration = 0.3;
    
    [self.bgView.layer setCornerRadius:defaultH*scale*0.5];
    [self.bgView.layer addAnimation:animation forKey:@"cornerRadius"];
    self.bgView.hidden = NO;
    
    self.spinnerView.bounds = CGRectMake(0, 0, defaultH*0.95, defaultH*0.95);
    self.spinnerView.center = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.bgView.layer.bounds = CGRectMake(0, 0, defaultW*scale*1.5, defaultH*scale*1.5);
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        if (_isLoading) {
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.bgView.layer.bounds = CGRectMake(0, 0, defaultH*scale, defaultH*scale);
            } completion:^(BOOL finished) {
                if (_isLoading) {
                    [self.spinnerView startAnimating];
                }
            }];
        }
    }];
}

- (void)stopLoading{
    
    [self.spinnerView stopAnimating];
    
//    _isLoading = NO;
    
    CGFloat defaultW = self.bgView.frame.size.width;
    CGFloat defaultH = self.bgView.frame.size.height;
    CGFloat defaultR = self.bgView.layer.cornerRadius;
    CGFloat scale = 1.2;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:defaultH*scale*0.5];
    animation.toValue = [NSNumber numberWithFloat:defaultR];
    animation.duration = 0.3;
    
    [self.bgView.layer setCornerRadius:defaultR];
    [self.bgView.layer addAnimation:animation forKey:@"cornerRadius"];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.bgView.layer.bounds = CGRectMake(0, 0, defaultW*scale*1.5, defaultH*scale*1.5);
    } completion:^(BOOL finished) {
        if (!_isLoading) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
            animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
            animation.fromValue = [NSNumber numberWithFloat:self.bgView.layer.cornerRadius];
            animation.toValue = [NSNumber numberWithFloat:defaultR];
            animation.duration = 0.3;
            [self.bgView.layer setCornerRadius:self.layer.cornerRadius];
            [self.bgView.layer addAnimation:animation forKey:@"cornerRadius"];
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.bgView.layer.bounds = CGRectMake(0, 0, defaultW, defaultH);
            } completion:^(BOOL finished) {
                if (!_isLoading) {
//                    if (btnBackgroundImage != nil) {
//                        [self.forDisplayButton setBackgroundImage:btnBackgroundImage forState:UIControlStateNormal];
//                    }
                    self.backgroundColor = self.bgView.backgroundColor;
                    self.bgView.hidden = YES;
                }
            }];
        }
    }];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"backgroundColor"];
}

@end
