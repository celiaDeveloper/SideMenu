//
//  XDMacros.h
//  SideMenu
//
//  Created by Celia on 2017/6/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

//系统目录
#define mDocumentDir   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define mCacheDir      [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define mTmpDir        NSTemporaryDirectory()
#define mHomeDir       NSHomeDirectory()

#define kDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

//----------方法简写-------
#define mWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mNotificationCenter [NSNotificationCenter defaultCenter]
#define mFont(size)         [UIFont systemFontOfSize:size]
#define mB_Font(size)       [UIFont boldSystemFontOfSize:size]

//以tag读取View
#define mViewByTag(parentView, tag, Class)  (Class *)[parentView viewWithTag:tag]
//读取Xib文件的类
#define mViewByNib(Class, owner) [[[NSBundle mainBundle] loadNibNamed:Class owner:owner options:nil] lastObject]

//id对象与NSData之间转换
#define mObjectToData(object)   [NSKeyedArchiver archivedDataWithRootObject:object]
#define mDataToObject(data)     [NSKeyedUnarchiver unarchiveObjectWithData:data]

//度弧度转换
#define mDegreesToRadian(x)      (M_PI * (x) / 180.0)
#define mRadianToDegrees(radian) (radian*180.0) / (M_PI)

//颜色转换
#define mRGB(r, g, b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define mRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//rgb颜色转换（16进制->10进制）
#define mHexColor(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

//G－C－D
#define mGCDBackground(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define mGCDMain(block)       dispatch_async(dispatch_get_main_queue(),block)

//简单的以AlertView显示提示信息
#define mAlertView(self, title, msg) UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:(UIAlertControllerStyleAlert)];\
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];\
[alertController addAction:okAction];\
[self presentViewController:alertController animated:YES completion:nil];\


/*
 else{\
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil \
 cancelButtonTitle:@"确定" \
 otherButtonTitles:nil]; \
 [alert show];}
 */


//----------设备系统相关---------
#define mIsiP4    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size) : NO)
#define mIsiP5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)
#define mIsiP6    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size) : NO)
#define mIsiP6P    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size) : NO)

#define mIsiPad   [[UIDevice currentDevice].model containString:@"iPad"]
#define mIsiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define mIsiOS8 [[[UIDevice currentDevice] systemVersion] integerValue] == 8
#define mIsiOS7 [[[UIDevice currentDevice] systemVersion] integerValue] == 7
#define mIsiOS6 [[[UIDevice currentDevice] systemVersion] integerValue] == 6
#define mLanguage [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(mScreenWidth, mScreenHeight))
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)

#define mSystemVersion   ([[UIDevice currentDevice] systemVersion])
#define mCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define mAPPVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


//----------页面设计相关-------

#define mNavBarHeight         44 // (mIsiP6P?64:44)
#define mTabBarHeight         49//(mIsiP6P?73:49)
#define mScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define mScreenHeight         ([UIScreen mainScreen].bounds.size.height)
#define mStatusBarHeight      ([UIApplication sharedApplication].statusBarFrame.size.height)
#define mNavHeight            (mNavBarHeight + mStatusBarHeight)
#define m6PScale              mScreenWidth/1242.0
#define m6Scale               mScreenWidth/375.0
#define m5Scale               mScreenWidth/320.0


//调试模式下输入NSLog，发布后不再输入。
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif


// block self
#define mWeakSelf  __weak typeof (self)weakSelf = self;
#define mStrongSelf typeof(weakSelf) __strong strongSelf = weakSelf;
