//
//  CommonParameterModel.h
//  ColorFulShipper
//
//  Created by Celia on 2017/4/12.
//  Copyright © 2017年 彭小龙. All rights reserved.
//
//**  http请求 必创建的 model  基础model

#import "JSONModel.h"

@interface CommonParameterModel : JSONModel {
    NSString *_ticket;
    NSString *_userName;
    NSString *_v;
    
}

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *currentTime;
@property (nonatomic, strong) NSString *ticket;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *v;
@property (nonatomic, strong) NSString *requestData;

@end
