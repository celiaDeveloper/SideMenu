//
//  XTProgressHUD.h
//  XiaoTu
//
//  Created by 何振东 on 15/7/7.
//  Copyright © 2015年 LZA. All rights reserved.
//

/**
 *  网络加载HUD
 */

#import <UIKit/UIKit.h>

@interface XTProgressHUD : UIView

/**
 *  便利方法创建实例对象
 *
 *  @return Progress实例对象
 */
+ (instancetype)progressHUD;

/**
 *  显示HUD
 */
- (void)showHudAtView:(UIView *)aView;

/**
 *  显示Hud
 *
 *  @param aView 显示的父视图
 *  @param text  显示的文字内容
 */
- (void)showHudAtView:(UIView *)aView withText:(NSString *)text;


/**
 *  隐藏HUD
 */
- (void)hideHud;

/**
 *  显示提示文本内容
 *
 *  @param text  文本内容
 *  @param aView 显示的父视图
 */
+ (void)showText:(NSString *)text atView:(UIView *)aView;


@end
