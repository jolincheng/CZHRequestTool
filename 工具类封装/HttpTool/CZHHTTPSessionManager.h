//
//  CZHHTTPSessionManager.h
//  工具类封装
//
//  Created by 程召华 on 2017/12/12.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface CZHHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)shareManager;
@end
