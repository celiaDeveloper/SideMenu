//
//  UIView+XDParentVC.m
//  SideMenu
//
//  Created by Celia on 2017/6/19.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "UIView+XDParentVC.h"

@implementation UIView (XDParentVC)

- (UIViewController *)parentClass:(Class)estimateVCClass {
    
    if (self.superview) {
        
        for (UIView *next = self.superview; next; next = next.superview) {
            
            UIResponder *nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:estimateVCClass]) {
                return (UIViewController *)nextResponder;
            }
            
        }
        
    }
    
    return nil;
}

- (UIViewController *)getCurrentViewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
