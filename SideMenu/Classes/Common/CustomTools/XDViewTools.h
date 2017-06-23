//
//  XDViewTools.h
//  SideMenu
//
//  Created by Celia on 2017/6/21.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDViewTools : UIView

//单例
+ (XDViewTools *)shareTools;

/**
 文字
 */
- (UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)TColor font:(CGFloat)font;


/**
 文字 + corner
 */
- (UILabel *)labelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)TColor font:(CGFloat)font cornerR:(CGFloat)corner;

/**
 文字
 */
- (UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)TColor;

/**
 文字 + 图片
 */
- (UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)TColor image:(NSString *)imageName;

/**
 文字 + 大小
 */
- (UIButton *)buttonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)TColor font:(CGFloat)font;

/**
 未选中图片 + 选中图片
 */
- (UIButton *)buttonFrame:(CGRect)frame image:(NSString *)image selectedImage:(NSString *)selectedImage;

/**
 背景色 + 文字 + 圆角
 */
- (UIButton *)buttonFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)TColor cornerRadius:(CGFloat)cornerRadius;

- (UIButton *)buttonFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)TColor cornerRadius:(CGFloat)cornerRadius tag:(NSInteger)tag;


/**
 图片
 */
- (UIImageView *)imageViewFrame:(CGRect)frame image:(NSString *)image;


/**
 AlertController  alert类型  一个action
 */
- (UIAlertController *)alertTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)title1 style:(UIAlertActionStyle)style actionHandler:(void (^)(UIAlertAction *action))actionHandler;

/**
 AlertController  alert类型  两个action Cancel+Default类型
 */
- (UIAlertController *)alertTitle:(NSString *)title cancelTitle:(NSString *)title1 action2Title:(NSString *)title2 cancelHandler:(void (^)(UIAlertAction *action))actionHandlerOne action2Handler:(void (^)(UIAlertAction *action))actionHandlerTwo;


/**
 AlertController  sheet类型  两个action Cancel+Default类型
 */
- (UIAlertController *)alertSheetTitle:(NSString *)title cancelTitle:(NSString *)title1 action2Title:(NSString *)title2 cancelHandler:(void (^)(UIAlertAction *action))actionHandlerOne action2Handler:(void (^)(UIAlertAction *action))actionHandlerTwo;

@end
