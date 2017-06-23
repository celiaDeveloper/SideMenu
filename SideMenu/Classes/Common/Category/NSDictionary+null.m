//
//  NSDictionary+null.m
//  ColorFulShipper
//
//  Created by Celia on 2017/5/15.
//  Copyright © 2017年 彭小龙. All rights reserved.
//

#import "NSDictionary+null.h"
#import "NSArray+null.h"

@implementation NSDictionary (null)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks {
    
    const NSMutableDictionary *replaced = [self mutableCopy];
    
    const id nul = [NSNull null];
    
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        
        id object = [self objectForKey:key];
        
        if (object == nul) [replaced setObject:blank forKey:key];
        
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setObject:[object dictionaryByReplacingNullsWithBlanks] forKey:key];
        
        else if ([object isKindOfClass:[NSArray class]]) [replaced setObject:[object arrayByReplacingNullsWithBlanks] forKey:key];
        
    }
    
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
    
}

@end
