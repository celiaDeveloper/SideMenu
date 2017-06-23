//
//  UIView+XDParentVC.h
//  SideMenu
//
//  Created by Celia on 2017/6/19.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XDParentVC)

- (UIViewController *)parentClass:(Class)estimateVCClass;

- (UIViewController *)getCurrentViewController;

@end
