//
//  NSString+XDCategory.m
//  SideMenu
//
//  Created by Celia on 2017/6/23.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "NSString+XDCategory.h"

@implementation NSString (XDCategory)

- (BOOL)isBlankString {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
