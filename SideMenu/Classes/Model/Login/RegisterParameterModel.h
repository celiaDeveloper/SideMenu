//
//  RegisterParameterModel.h
//  ColorFulShipper
//
//  Created by Celia on 2017/4/12.
//  Copyright © 2017年 彭小龙. All rights reserved.
//
//**  注册 model

#import "JSONModel.h"

@interface RegisterParameterModel : JSONModel

@property (nonatomic, strong) NSString *mobilePhone;    //手机号
@property (nonatomic, strong) NSString *userPassword;   //密码
@property (nonatomic, strong) NSString *SMScode;        //验证码
@property (nonatomic, assign) NSInteger carrierType;    //类型

@end
