//
//  XTLanguageManager.h
//  XiaoTuEBook
//
//  Created by relech on 16/2/18.
//  Copyright © 2016年 LZA. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef XTLanguageManager_h
#define XTLanguageManager_h
#define XTGetStringWithKeyFromTable(key, tbl) [[XTLanguageManager sharedInstance] getStringForKey:key withTable:tbl]
#define XTGetStringWithKey(key) [[XTLanguageManager sharedInstance] getStringForKey:key]
#endif
@interface XTLanguageManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  应用启动时，重设语言环境
 *
 *  @param resetBlock 重设根视图的Block
 */
- (void)registWithResetAppBlock:(void (^)())resetBlock;

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
- (NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;

/**
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */

- (NSString *)getStringForKey:(NSString *)key;

/**
 *  改变当前语言
 */
- (void)changeNowLanguage;

/**
 *  设置新的语言
 *
 *  @param language 新语言
 */
- (void)setNewLanguage:(NSString*)language;


+ (BOOL)isEnglishDeviceLanguage;
@end
