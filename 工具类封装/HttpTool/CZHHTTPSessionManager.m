//
//  CZHHTTPSessionManager.m
//  工具类封装
//
//  Created by 程召华 on 2017/12/12.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "CZHHTTPSessionManager.h"

@implementation CZHHTTPSessionManager


+ (instancetype)shareManager {
    static CZHHTTPSessionManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[CZHHTTPSessionManager alloc] init];
        _manager.requestSerializer.timeoutInterval = 10;
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _manager;
}

@end
