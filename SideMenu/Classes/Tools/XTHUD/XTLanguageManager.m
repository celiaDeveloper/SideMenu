//
//  XTLanguageManager.m
//  XiaoTuEBook
//
//  Created by relech on 16/2/18.
//  Copyright © 2016年 LZA. All rights reserved.
//


#define CNS @"zh-Hans"
#define EN @"en"

#import "XTLanguageManager.h"

typedef NS_ENUM(NSUInteger, XTLanguageType) {
    XTLanguageTypeDefault,
    XTLanguageTypeZH_CN,
    XTLanguageTypeEN,
};

static XTLanguageManager *sharedModel;
static NSString *const kXTLanguageSetUserDefaultKey = @"langeuageset";

typedef void (^XTResetAppBlock)();

@interface XTLanguageManager ()

@property(nonatomic, strong) NSBundle *bundle;

@property(nonatomic, copy) NSString *language;

@property (nonatomic, copy) XTResetAppBlock resetAppBlock;

@end

@implementation XTLanguageManager
//en:英文  zh-Hans:简体中文   zh-Hant:繁体中文
+ (BOOL)isEnglishDeviceLanguage
{
    NSString *tmp = [[NSUserDefaults standardUserDefaults]objectForKey:kXTLanguageSetUserDefaultKey];
    if (!tmp) {
        NSArray *languages = [NSLocale preferredLanguages];
        tmp = [languages objectAtIndex:0];
    }
    
    if ([tmp hasPrefix:@"en"]) {
        return YES;
    }else{
        return NO;
    }
}

-(void)initLanguage
{
    NSString *tmp = [[NSUserDefaults standardUserDefaults]objectForKey:kXTLanguageSetUserDefaultKey];
    NSString *path;
    //默认是中文
    if (!tmp)
    {
        self.bundle = nil;
    }else{
        self.language = tmp;
        path = [[NSBundle mainBundle]pathForResource:self.language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
    }
}

- (NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table
{
    if (self.bundle)
    {
        return NSLocalizedStringFromTableInBundle(key, table, self.bundle, @"");
    }
    
    return NSLocalizedStringFromTable(key, table, @"");
}

- (NSString *)getStringForKey:(NSString *)key
{
    if (self.bundle)
    {
        return NSLocalizedStringFromTableInBundle(key, @"Localizable", self.bundle, @"");
    }
    
    return NSLocalizedStringFromTable(key, @"Localizable", @"");
}


-(void)changeNowLanguage
{
    if ([self.language isEqualToString:EN])
    {
        [self setNewLanguage:CNS];
    }
    else
    {
        [self setNewLanguage:EN];
    }
}

-(void)setNewLanguage:(NSString *)language
{
    if ([language isEqualToString:EN] || [language isEqualToString:CNS])
    {
        NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
    }else{
        self.bundle = nil;
    }
    
    self.language = language;
    [[NSUserDefaults standardUserDefaults]setObject:language forKey:kXTLanguageSetUserDefaultKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if (self.resetAppBlock) {
        self.resetAppBlock();
    }
}


#pragma mark- 单例实现

//全局变量
static id _instance = nil;
//单例方法
+ (instancetype)sharedInstance{
    return [[self alloc] init];
}
////alloc会调用allocWithZone:
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    //只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
//初始化方法
- (instancetype)init{
    // 只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}
//copy在底层 会调用copyWithZone:
- (id)copyWithZone:(NSZone *)zone{
    return  _instance;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  _instance;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}


#pragma mark- Public Method

- (void)registWithResetAppBlock:(XTResetAppBlock)resetBlock
{
    _resetAppBlock = resetBlock;
    [self initLanguage];
}

@end
