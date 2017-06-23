//
//  XDViewTools.m
//  SideMenu
//
//  Created by Celia on 2017/6/21.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDViewTools.h"

@implementation XDViewTools

+ (XDViewTools *)shareTools {
    
    static XDViewTools *tools = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (tools == nil) {
            tools = [[XDViewTools alloc] init];
        }
        
    });
    
    return tools;
}

#pragma mark - label
- (UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)TColor font:(CGFloat)font {
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:frame];
    tempLabel.text = text;
    tempLabel.textColor = TColor;
    tempLabel.font = [UIFont systemFontOfSize:font];
    
    return tempLabel;
}


- (UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)TColor font:(CGFloat)font cornerR:(CGFloat)corner {
    UILabel *tempLabel = [self labelFrame:frame text:text textColor:TColor font:font];
    
    tempLabel.layer.masksToBounds = YES;
    tempLabel.layer.cornerRadius = corner;
    
    return tempLabel;
}


#pragma mark - button
- (UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)TColor {
    
    UIButton *tempBtn = [[UIButton alloc] initWithFrame:frame];
    [tempBtn setTitle:title forState:UIControlStateNormal];
    [tempBtn setTitleColor:TColor forState:UIControlStateNormal];
    
    return tempBtn;
}

- (UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)TColor image:(NSString *)imageName {
    
    UIButton *tempBtn = [self buttonFrame:frame title:title titleColor:TColor];
    [tempBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    return tempBtn;
}

- (UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)TColor font:(CGFloat)font {
    
    UIButton *tempBtn = [self buttonFrame:frame title:title titleColor:TColor];
    tempBtn.titleLabel.font = [UIFont systemFontOfSize:font];
    
    return tempBtn;
}

- (UIButton *)buttonFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)TColor cornerRadius:(CGFloat)cornerRadius {
    
    UIButton *tempBtn = [self buttonFrame:frame title:title titleColor:TColor];
    tempBtn.backgroundColor = bgColor;
    tempBtn.layer.cornerRadius = cornerRadius;
    tempBtn.layer.masksToBounds = YES;
    
    return tempBtn;
}

- (UIButton *)buttonFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)TColor cornerRadius:(CGFloat)cornerRadius tag:(NSInteger)tag  {
    UIButton *tempBtn = [self buttonFrame:frame title:title titleColor:TColor];
    tempBtn.backgroundColor = bgColor;
    tempBtn.layer.cornerRadius = cornerRadius;
    tempBtn.tag = tag;
    
    return tempBtn;
}

- (UIButton *)buttonFrame:(CGRect)frame image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    UIButton *tempBtn = [[UIButton alloc] initWithFrame:frame];
    [tempBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [tempBtn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    
    return tempBtn;
}


#pragma mark - imageview
- (UIImageView *)imageViewFrame:(CGRect)frame image:(NSString *)image {
    
    UIImageView *tempImageV = [[UIImageView alloc] initWithFrame:frame];
    [tempImageV setImage:[UIImage imageNamed:image]];
    
    return tempImageV;
}


#pragma mark - alertController
- (UIAlertController *)alertTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)title1 style:(UIAlertActionStyle)style actionHandler:(void (^)(UIAlertAction *action))actionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (actionHandler) {
            actionHandler(action);
        }
        
    }]];
    
    return alert;
}

- (UIAlertController *)alertTitle:(NSString *)title cancelTitle:(NSString *)title1 action2Title:(NSString *)title2 cancelHandler:(void (^)(UIAlertAction *action))actionHandlerOne action2Handler:(void (^)(UIAlertAction *action))actionHandlerTwo {
    
    UIAlertController *alert = [self alertTitle:title message:nil actionTitle:title1 style:UIAlertActionStyleCancel actionHandler:^(UIAlertAction *action) {
        if (actionHandlerOne) {
            actionHandlerOne(action);
        }
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (actionHandlerTwo) {
            actionHandlerTwo(action);
        }
    }]];
    
    return alert;
}

- (UIAlertController *)alertSheetTitle:(NSString *)title cancelTitle:(NSString *)title1 action2Title:(NSString *)title2 cancelHandler:(void (^)(UIAlertAction *action))actionHandlerOne action2Handler:(void (^)(UIAlertAction *action))actionHandlerTwo {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (actionHandlerOne) {
            actionHandlerOne(action);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (actionHandlerTwo) {
            actionHandlerTwo(action);
        }
    }]];
    
    return alert;
}



@end
