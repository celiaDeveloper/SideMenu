//
//  LoginParameterModel.h
//  ColorFulShipper
//
//  Created by Celia on 2017/4/12.
//  Copyright © 2017年 彭小龙. All rights reserved.
//
//**  登录 model

#import "JSONModel.h"

@interface LoginParameterModel : JSONModel

@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *loginToken;
@property (nonatomic, strong) NSString *loginType;  //登录类型(0:手机号+密码,1:手机号+短信验证)

@end
