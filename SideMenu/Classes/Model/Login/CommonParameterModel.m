//
//  CommonParameterModel.m
//  ColorFulShipper
//
//  Created by Celia on 2017/4/12.
//  Copyright © 2017年 彭小龙. All rights reserved.
//

#import "CommonParameterModel.h"

@implementation CommonParameterModel


- (void)setTicket:(NSString *)ticket {
    if (_ticket != ticket) {
        _ticket = ticket;
    }
    
}

- (NSString *)ticket {
    return @"7E3C684947E955CFCF931179B53C1600";
}

- (void)setUserName:(NSString *)userName {
    if (_userName != userName) {
        _userName = userName;
    }
}

- (NSString *)userName {
    return @"tms";
}

- (void)setV:(NSString *)v {
    if (_v != v) {
        _v = v;
    }
}

- (NSString *)v {
    return @"1.0";
}


@end
