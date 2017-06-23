//
//  XDAppConfig.h
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TEXTCOLOR_TabBarTitle   [UIColor colorWithRed:0.15 green:0.64 blue:0.93 alpha:1.00]

#define BGCOLOR_NaviBar     [UIColor colorWithRed:0.23 green:0.60 blue:0.84 alpha:1.00]

#define BGCOLOR_LightGray   mRGBA(240, 240, 242, 1.0f)

#define BGCOLOR_Side        [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00]

#define kAppMainColor mHexColor(0xeaeff3)
#define kButtonColor mHexColor(0x29a600)
#define kAppLabelColor mHexColor(0x114e5c)
#define kNavBarColor mHexColor(0x39a7f3)
#define kWebImageUrl(webImageStrng) [NSURL URLWithString:[NSString stringWithFormat:@"%@", webImageStrng]]


//常用的字符串
#define MENU_SHOWED             @"leftMenu_have_show"   //左侧菜单是否展示了
#define NOTIFICATION_ShowMenu   @"show_menu"
#define ISLOGINTAG              @"is_login"             //已登录标记

#define PANGESTURE_ADD          @"add_panGesture"       //添加滑动手势
#define PANGESTURE_REMOVE       @"remove_panGesture"    //移除滑动手势

#define LOGIN_Name              @"login_mobilePhone"    //登录手机号


///用户个人信息Key，使用NSUSerDefaults存取
// 0 为登陆 1 登陆
static NSString *const isLogin                      = @"isLogin";

//cookie值
static NSString *const kDriverCookieValue           = @"kDriverCookieValue";
//司机名称
static NSString *const kDriverName                  = @"kDriverName";
//头像
static NSString *const kDriverHeadImage             = @"kDriverHeadImage";
//主键ID
static NSString *const kDriverId                    = @"kDriverId";
//是否有GPS
static NSString *const kDriverIsGps                 = @"kDriverIsGps";
//密码
static NSString *const kDriverPassword              = @"kDriverPassword";
//手机号码
static NSString *const kDriverPhone                 = @"kDriverPhone";

