//
//  ExitLoginModel.h
//  ColorFulShipper
//
//  Created by Celia on 2017/5/15.
//  Copyright © 2017年 彭小龙. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ExitLoginModel : JSONModel

@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *loginToken;

@end
