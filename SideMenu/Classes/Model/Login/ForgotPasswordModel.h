//
//  ForgotPasswordModel.h
//  ColorFulShipper
//
//  Created by Celia on 2017/4/15.
//  Copyright © 2017年 彭小龙. All rights reserved.
//
//**  忘记密码 model

#import <JSONModel/JSONModel.h>

@interface ForgotPasswordModel : JSONModel

@property (nonatomic, strong) NSString *mobilePhone;    //手机号
@property (nonatomic, strong) NSString *userPassword;   //密码
@property (nonatomic, strong) NSString *valcode;        //验证码

@end
