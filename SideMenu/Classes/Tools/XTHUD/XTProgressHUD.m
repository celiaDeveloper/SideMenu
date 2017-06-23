//
//  XTProgressHUD.m
//  XiaoTu
//
//  Created by 何振东 on 15/7/7.
//  Copyright © 2015年 LZA. All rights reserved.
//

// block self
#define XTWeakSelf  __weak typeof (self)weakSelf = self;
#define XTStrongSelf typeof(weakSelf) __strong strongSelf = weakSelf;

#import "XTProgressHUD.h"
#import "XTLanguageManager.h"

@interface XTProgressHUD ()
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *textLbl;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end


@implementation XTProgressHUD

+ (instancetype)progressHUD
{
    static XTProgressHUD *proHUD = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (proHUD == nil) {
            proHUD = [[XTProgressHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
    });
    
    return proHUD;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:(CGRect)frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
        
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
//        self.contentView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
        self.contentView.layer.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        [self addSubview:self.contentView];
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicatorView.color = [UIColor whiteColor];
        [self.indicatorView startAnimating];
        [self.contentView addSubview:self.indicatorView];
        
        self.textLbl = [[UILabel alloc] init];
        self.textLbl.font = [UIFont systemFontOfSize:16];
        self.textLbl.textAlignment = NSTextAlignmentCenter;
        self.textLbl.textColor = [UIColor whiteColor];
        self.textLbl.text = XTGetStringWithKeyFromTable(@"Loading", @"XTFoundation") ;
        self.textLbl.adjustsFontSizeToFitWidth = YES;
        [self.textLbl sizeToFit];
        [self.contentView addSubview:self.textLbl];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.bounds = CGRectMake(0, 0, 100, 100);
    self.contentView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2-20);
    self.indicatorView.center = CGPointMake(self.contentView.bounds.size.width/2, self.contentView.bounds.size.height/2 - 15);
    self.textLbl.center = CGPointMake(self.contentView.bounds.size.width/2, self.contentView.bounds.size.height/2 + 20);
}

- (void)showHudAtView:(UIView *)aView
{
    [aView addSubview:self];
}

- (void)showHudAtView:(UIView *)aView withText:(NSString *)text
{
    self.textLbl.text = text;
    [aView addSubview:self];
}

- (void)hideHud
{
    XTWeakSelf;
    [UIView animateWithDuration:0.45 animations:^{
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


+ (void)showText:(NSString *)text atView:(UIView *)aView
{
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = text;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:14.5];
    lbl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    lbl.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [lbl sizeToFit];
    lbl.layer.cornerRadius = lbl.frame.size.height/2;
    lbl.clipsToBounds = YES;
    [aView addSubview:lbl];
    
    lbl.center = CGPointMake(aView.center.x, aView.bounds.size.height);
    lbl.bounds = CGRectMake(0, 0, lbl.bounds.size.width + 20, lbl.bounds.size.height + 16);
    
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    window.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:1.15 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        lbl.center = CGPointMake(aView.center.x, aView.bounds.size.height - 50);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            lbl.center = CGPointMake(aView.center.x, aView.bounds.size.height + 30);
        } completion:^(BOOL finished) {
//            window.userInteractionEnabled = YES;
            [lbl removeFromSuperview];
        }];
    }];
}



@end
