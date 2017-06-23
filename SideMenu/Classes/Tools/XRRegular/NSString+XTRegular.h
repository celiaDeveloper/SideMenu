//
//  NSString+XTRegular.h
//  XiaoTu
//
//  Created by 何振东 on 15/7/7.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  常用正则表达式
 */
@interface NSString (XTRegular)

//邮箱符合性验证。
- (BOOL)isValidateEmail;

//全是数字。
- (BOOL)isNumber;

//验证英文字母。
- (BOOL)isEnglishWords;

//验证密码：6—16位，只能包含字符、数字和 下划线。
- (BOOL)isValidatePassword;

//验证是否为汉字。
- (BOOL)isChineseWords;

//验证是否为网络链接。
- (BOOL)isInternetUrl;

//正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX
- (BOOL)isPhoneNumber;//验证是否为电话号码。

//是否为手机号。
- (BOOL)isMobilePhoneNum;

//验证是否为11位数字
- (BOOL)isElevenDigitNum;

//验证15或18位身份证。
- (BOOL)isIdentifyCardNumber;


@end
