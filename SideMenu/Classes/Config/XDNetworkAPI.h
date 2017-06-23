//
//  XDNetworkAPI.h
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//


/*1.每个请求的接口URL都不相同
 
#define HTTP_HEAD @"http://218.94.75.90:58002/"


//更换手机号
#define CHANGEMOBILE [HTTP_HEAD stringByAppendingString:@"zcwl-lis/mobile/updatePhone.action"]
//忘记密码
#define FORGET [HTTP_HEAD stringByAppendingString:@"zcwl-lis/mobile/forgetPassword.action"]
//登陆
#define Login [HTTP_HEAD stringByAppendingString:@"zcwl-lis/mobile/loginForMobile.action"]
//登出
#define LOGOUT_URL [HTTP_HEAD stringByAppendingString:@"zcwl-lis/mobile/logOut.action"]
//注册
#define REGISTER [HTTP_HEAD stringByAppendingString:@"zcwl-lis/TmsDriver/registerDriver.action"]

// 头像
#define HEARDURL [HTTP_HEAD stringByAppendingString:@"zcwl-lis/DownLoadImage?type=1&imagePath="]
//上传头像
#define UPDATEHERAD [HTTP_HEAD stringByAppendingString:@"zcwl-lis/TmsDriver/uploadHeadImage.action"]

//意见反馈
#define FEEDBACK [HTTP_HEAD stringByAppendingString:@"zcwl-lis/mobile/getAppFeedBack.action"]

*/


/*
 2.每个请求的接口URL都是BaseURL，但是携带的参数中包含一个apiKey，每个接口都不同
 */

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#endif

static NSString *  HTTP_PARA_KEY = @"httpRequest";
static NSString *  HTTP_RESULT_CODE = @"resultCode";        //http json 返回
static NSString *  HTTP_RESULT_DESC = @"resultDesc";
static NSString *  HTTP_RESULT_DATA = @"resultData";


static NSString * BaseURL           = @"http://218.94.75.90:58002/zcwl-lis/BehosoftService";
static NSString * BaseURL_Short     = @"http://218.94.75.90:58002/zcwl-lis/";

static NSString * ImageURLMiddle    = @"DownLoadImage?type=1&imagePath=";
static NSString * AgreementEnd      = @"html/consignorAgreement.html";
static NSString * HelpEnd           = @"html/consignorHelp.html";
static NSString * AboutEnd          = @"html/consignorAboutUs.html";


//登录
static NSString *  HTTPKEY_SMSCODE = @"TMSCUST00004";       //发送验证码
static NSString *  HTTPKEY_REGISTER = @"TMSCUST00003";      //注册
static NSString *  HTTPKEY_LOGIN = @"TMSCUST00001";         //登录
static NSString *  HTTPKEY_FORGET = @"TMSCUST00005";        //忘记密码
static NSString *  HTTPKEY_EXIT_ACCOUNT = @"TMSCUST00002";  //登出


static NSString *  HTTPKEY_PACKANDSOUCESTYPE = @"TMSCUST00058";     //货物和包装类型
static NSString *  HTTPKEY_PZTYPE = @"TMSCUST00057";                //配载方式
static NSString *  HTTPKEY_TRANSTYPE = @"TMSCUST00056";             //运输方式
static NSString *  HTTPKEY_CARTYPE = @"TMSCUST00042";               //车辆类型
static NSString *  HTTPKEY_ADDRESS = @"TMSCUST00044";               //区域选择
