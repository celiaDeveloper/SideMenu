//
//  XDDNetworking.m
//  ColorFulShipper
//
//  Created by Celia on 2017/4/11.
//  Copyright © 2017年 彭小龙. All rights reserved.
//
//如果后台返回 是简单的成功与否的数据，则直接将三个字段回调回去
//如果后天返回 result_data中有需要用的数据，则将result_data数据回调回去

#import "XDDNetworking.h"
#import "CommonParameterModel.h"
#import "NSDictionary+null.h"
#import "NSArray+null.h"
#import "SMSModel.h"

@interface XDDNetworking ()

@end


@implementation XDDNetworking

+(XDDNetworking *)shareNetworking {
    static XDDNetworking *requestObj = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestObj == nil) {
            requestObj = [[XDDNetworking alloc] init];
        }
    });
    
    return requestObj;
}

- (NSMutableURLRequest *)httpHeaderSettingType:(HttpRequestType)type URL:(NSString *)url image:(BOOL)haveImage params:(NSDictionary *)paramsDic {
    
    NSURL *requestURL = [NSURL URLWithString:url];
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    
    NSLog(@"请求的URL %@", url);
    
    //http body 设置
    if (paramsDic != nil) {
        
        NSData *bodyData = [NSJSONSerialization dataWithJSONObject:paramsDic options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"请求的 body 参数 : %@", paramsDic);
        [theRequest setHTTPBody:bodyData];
        
    }
    
    //http header 设置
    NSString *httpMethod = (type == HttpRequestTypeGet ? @"GET" : @"POST");
    [theRequest setHTTPMethod:httpMethod];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest addValue:@"Ios" forHTTPHeaderField:@"equipmentType"];
    
    if (haveImage) {
        [theRequest addValue:@"YES" forHTTPHeaderField:@"isHaveImage"];
    }else {
        [theRequest addValue:@"NO" forHTTPHeaderField:@"isHaveImage"];
    }
    
    NSLog(@"请求头 all Header :%@", theRequest.allHTTPHeaderFields);
    
    return theRequest;
}

//异步http请求
//failedBlock 多是http设置 或者 网络问题  导致数据请求不到
- (void)sendHttpRequestWithType:(HttpRequestType)type URL:(nonnull NSString *)url image:(BOOL)haveImage params:(NSDictionary *)paramsDic successBlock:(HttpSuccessBlock)successBlock failedBlock:(HttpFailedBlock)failedBlock {
    
    NSMutableURLRequest *theRequest = [self httpHeaderSettingType:type URL:url image:haveImage params:paramsDic];
    [theRequest setTimeoutInterval:30.0];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionData = [session dataTaskWithRequest:theRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            if (failedBlock) {
                failedBlock(error);
            }
            
        }else {
            
            if (data) {
              
                NSError *err = nil;
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&err];
                
                //字典中null数据替换成空字符
                NSDictionary *returnDic = [jsonDic dictionaryByReplacingNullsWithBlanks];
                if (err) {
                    NSLog(@"json 解析失败 %@",err);
                }
                NSLog(@"请求获得的json --%@",returnDic);
                if (successBlock) {
                    successBlock(returnDic);
                }
            }
            
        }
        
    }];
    
    [sessionData resume];
    
}

#pragma mark - 获取当前时间
- (NSString *)getCurrentTime {
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}

#pragma mark - model 转 string
- (NSString *)stringFromModel:(JSONModel *)model {
    
    NSDictionary *dic = [model toDictionary];
    NSString *temp = [NSString stringWithFormat:@"%@",dic];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:temp];
    
    NSRange range = {0,temp.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    NSLog(@"string from model :%@", mutStr);
    return mutStr;
}

- (NSString *)jsonStringFromModel:(JSONModel *)model {
    
    NSDictionary *dataDic = [model toDictionary];
    
    NSString * headerData = [self jsonStringFromDic:dataDic];
//    Log(@"json string from model : %@", headerData);
    
    return headerData;
}

- (NSString *)jsonStringFromDic:(NSDictionary *)dataDic {
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString *dataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSString * headerData = dataString;
    headerData = [headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return headerData;
}

#pragma mark - 获取请求参数
- (NSDictionary *)parameterFromModel:(JSONModel *)model apiKey:(NSString *)key {
    
    CommonParameterModel *commonModel = [[CommonParameterModel alloc] init];
    commonModel.currentTime = [self getCurrentTime];
    commonModel.apiKey = key;
    NSLog(@"请求接口的key -- %@",key);
    if (model) {
        commonModel.requestData = [self jsonStringFromModel:model];
    }else {
        commonModel.requestData = @{};
    }
    
    NSDictionary *parameter = [commonModel toDictionary];
    
    return parameter;
}

#pragma mark - 判断 http请求是否拿到正确数据
- (BOOL)requestIsSuccess:(NSDictionary *)dataDic {
    if ((dataDic[HTTP_RESULT_CODE] && [dataDic[HTTP_RESULT_CODE] isEqualToString:@"0"])) {
        return YES;
    }
    return NO;
}

#pragma mark - 业务接口
#pragma mark - 登录、注册
- (void)userLoginModel:(LoginParameterModel *)model successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    //登录类型(0:手机号+密码,1:手机号+短信验证)
    //返回参数说明
    //resultCode 0 或 1
    //resultDesc 后台返回的中文描述信息
    //resultData 如果有返回数据，后台返回json格式字符串，否则没有该字段
    /* 示例
     resultCode = 0;
     resultData = "[{\"customerName\":\"\U6e29\U9274\U82cf\",\"customerId\":\"O2O705040000001\",\"mobilePhone\":\"15639002900\",\"headImage\":null,\"carrierType\":\"0\",\"code\":\"TMS00004\"}]";
     resultDesc = "";
     */
    
    NSDictionary *parameter = [self parameterFromModel:model apiKey:HTTPKEY_LOGIN];
    mWeakSelf
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary * _Nonnull successDic) {
        
        if ([weakSelf requestIsSuccess:successDic]) {
            
            NSString *resultData = successDic[HTTP_RESULT_DATA];
            
            NSData *data = [resultData dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
            NSDictionary *dic = [dataArr[0] dictionaryByReplacingNullsWithBlanks];
            if (successBlock) {
                successBlock(dic);
            }
            
        }else {
            if (failBlock) {
                failBlock(successDic);
            }
        }
        
        
    } failedBlock:^(NSError * _Nonnull error) {
        
        if (failBlock) {
            failBlock(@{@"error": error});
        }
        
    }];
    
}

//登出
- (void)exitLoginModel:(ExitLoginModel *)model successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    /*
     {
     resultCode = 0;
     resultData = "该账号退出成功";
     resultDesc = "";
     }
     */
    
    NSDictionary *parameter = [self parameterFromModel:model apiKey:HTTPKEY_EXIT_ACCOUNT];
    mWeakSelf
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary * _Nonnull successDic) {
        
        if ([weakSelf requestIsSuccess:successDic]) {
            
            if (successBlock) {
                successBlock(successDic);
            }
            
        }else {
            if (failBlock) {
                failBlock(successDic);
            }
        }
        
        
    } failedBlock:^(NSError * _Nonnull error) {
        
        if (failBlock) {
            failBlock(@{@"error": error});
        }
        
    }];
}

//注册
- (void)userRegisterModel:(RegisterParameterModel *)model successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    /*
     {
     resultCode = 0;
     resultData = "注册成功";
     resultDesc = "";
     }
     */
    
    NSDictionary *parameter = [self parameterFromModel:model apiKey:HTTPKEY_REGISTER];
    mWeakSelf
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary *successDic) {
        
        if ([weakSelf requestIsSuccess:successDic]) {
            //成功
            if (successBlock) {
                successBlock(successDic);
            }
            
        }else {
            //失败
            if (failBlock) {
                failBlock(successDic);
            }
        }
        
    } failedBlock:^(NSError *error) {
        
        if (failBlock) {
            failBlock(@{@"error":@"数据请求失败，请检查网络"});
        }
        
    }];
    
}

//找回密码
- (void)findPasswordModel:(ForgotPasswordModel *)model successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    NSDictionary *parameter = [self parameterFromModel:model apiKey:HTTPKEY_FORGET];
    
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary * _Nonnull successDic) {
        
        if (successDic[HTTP_RESULT_CODE] && [successDic[HTTP_RESULT_CODE] isEqualToString:@"0"]) {
            //成功
            if (successBlock) {
                successBlock(successDic);
            }
            
        }else {
            //失败
            if (failBlock) {
                failBlock(successDic);
            }
        }
    } failedBlock:^(NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(@{@"error": error});
        }
    }];
    
}

//发送验证码
- (void)sendSMSPhone:(NSString *)phoneNum type:(SMSType)type successBlock:(void (^)(NSDictionary *successDic))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    /*
     {
     resultCode = 0;
     resultData = "发送成功";
     resultDesc = "";
     }
     */
    
    SMSModel *tempM = [[SMSModel alloc] initWithDictionary:@{@"mobilePhone":phoneNum, @"type":[NSString stringWithFormat:@"%d",type]} error:nil];
    NSDictionary *parameter = [self parameterFromModel:tempM apiKey:HTTPKEY_SMSCODE];
    mWeakSelf
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary * _Nonnull successDic) {
        
        NSLog(@"smscode %@",successDic);
        
        if ([weakSelf requestIsSuccess:successDic]) {
            
            if (successBlock) {
                successBlock(successDic);
            }
            
        }else {
            if (failBlock) {
                failBlock(successDic);
            }
        }
        
    } failedBlock:^(NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(@{@"error": error});
        }
    }];
    
}


#pragma mark - 常用数据类型请求
- (void)carTypeSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    NSDictionary *parameter = [self parameterFromModel:nil apiKey:HTTPKEY_CARTYPE];
    mWeakSelf
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary * _Nonnull successDic) {
        
        if ([weakSelf requestIsSuccess:successDic]) {
            
            NSString *resultData = successDic[HTTP_RESULT_DATA];
            
            NSData *data = [resultData dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
            if (successBlock) {
                successBlock(dataArr);
            }
            
        }else {
            if (failBlock) {
                failBlock(successDic);
            }
        }
        
    } failedBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)transportTypeSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    NSDictionary *parameter = [self parameterFromModel:nil apiKey:HTTPKEY_TRANSTYPE];
    mWeakSelf
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary * _Nonnull successDic) {
        
        if ([weakSelf requestIsSuccess:successDic]) {
            
            NSString *resultData = successDic[HTTP_RESULT_DATA];
            
            NSData *data = [resultData dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
            if (successBlock) {
                successBlock(dataArr);
            }
            
        }else {
            if (failBlock) {
                failBlock(successDic);
            }
        }
        
    } failedBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)areaDataSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    NSDictionary *parameter = [self parameterFromModel:nil apiKey:HTTPKEY_ADDRESS];
    mWeakSelf
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary * _Nonnull successDic) {
        
        if ([weakSelf requestIsSuccess:successDic]) {
            
            NSString *resultData = successDic[HTTP_RESULT_DATA];
            
            NSData *data = [resultData dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
            
            if (successBlock) {
                successBlock(dataArr);
            }
            
        }else {
            if (failBlock) {
                failBlock(successDic);
            }
        }
        
    } failedBlock:^(NSError * _Nonnull error) {
        
    }];
    
}

//配送方式
- (void)loadPZTypeSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    NSDictionary *parameter = [self parameterFromModel:nil apiKey:HTTPKEY_PZTYPE];
    mWeakSelf
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary * _Nonnull successDic) {
        
        if ([weakSelf requestIsSuccess:successDic]) {
            
            NSString *resultData = successDic[HTTP_RESULT_DATA];
            
            NSData *data = [resultData dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
            
            if (successBlock) {
                successBlock(dataArr);
            }
            
        }else {
            if (failBlock) {
                failBlock(successDic);
            }
        }
        
    } failedBlock:^(NSError * _Nonnull error) {
        
    }];
}

//货物类型
- (void)loadGoodsTypeSuccessBlock:(void (^)(NSArray *successArr))successBlock failBlock:(void (^)(NSDictionary *failDic))failBlock {
    
    NSDictionary *parameter = [self parameterFromModel:nil apiKey:HTTPKEY_PACKANDSOUCESTYPE];
    mWeakSelf
    [self sendHttpRequestWithType:HttpRequestTypePost URL:BaseURL image:NO params:parameter successBlock:^(NSDictionary * _Nonnull successDic) {
        
        if ([weakSelf requestIsSuccess:successDic]) {
            
            NSString *resultData = successDic[HTTP_RESULT_DATA];
            
            NSData *data = [resultData dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
            
            if (successBlock) {
                successBlock(dataArr);
            }
             
        }else {
            if (failBlock) {
                failBlock(successDic);
            }
        }
        
    } failedBlock:^(NSError * _Nonnull error) {
        
    }];
}


@end
