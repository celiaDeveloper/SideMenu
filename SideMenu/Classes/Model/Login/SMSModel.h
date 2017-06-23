//
//  SMSModel.h
//  ColorFulShipper
//
//  Created by Celia on 2017/5/15.
//  Copyright © 2017年 彭小龙. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SMSModel : JSONModel

@property (nonatomic, strong) NSString *mobilePhone;
@property (nonatomic, strong) NSString *type;//0 注册 1忘记密码 2更换手机

@end
