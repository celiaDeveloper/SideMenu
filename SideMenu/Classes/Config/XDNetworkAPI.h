//
//  XDNetworkAPI.h
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//



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


