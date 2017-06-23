//
//  XDDNetworking.h
//  ColorFulShipper
//
//  Created by Celia on 2017/4/11.
//  Copyright © 2017年 彭小龙. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoginParameterModel.h"
#import "RegisterParameterModel.h"
#import "ExitLoginModel.h"
#import "ForgotPasswordModel.h"


typedef enum {
    HttpRequestTypePost,
    HttpRequestTypeGet
}HttpRequestType;

typedef enum {
    SMSTypeRegister = 0,
    SMSTypeForgotPass,
    SMSTypeChangePhone
}SMSType;


@interface XDDNetworking : NSObject

NS_ASSUME_NONNULL_BEGIN
//在这两个宏之间的代码NS_ASSUME_NONNULL_END，所有简单指针对象都被假定为nonnull
typedef void(^HttpSuccessBlock)(NSDictionary *successDic);
typedef void(^HttpFailedBlock)(NSError *error);


+(XDDNetworking *)shareNetworking;


#pragma mark - 登录、注册、找回密码
//登录   返回 LoginReturnedModel
- (void)userLoginModel:(LoginParameterModel *)model successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;

//登出
- (void)exitLoginModel:(ExitLoginModel *)model successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;

//注册
- (void)userRegisterModel:(RegisterParameterModel *)model successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;

//找回密码
- (void)findPasswordModel:(ForgotPasswordModel *)model successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;

//发送验证码
- (void)sendSMSPhone:(NSString *)phoneNum type:(SMSType)type successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;


#pragma mark - 常用数据类型请求
- (void)carTypeSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;

- (void)transportTypeSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;

- (void)areaDataSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;

//配载方式
- (void)loadPZTypeSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;

//货物类型/包装类型
- (void)loadGoodsTypeSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock;


NS_ASSUME_NONNULL_END
@end
