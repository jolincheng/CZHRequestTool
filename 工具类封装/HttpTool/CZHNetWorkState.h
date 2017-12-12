//
//  CZHNetWorkState.h
//  工具类封装
//
//  Created by 程召华 on 2017/12/12.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CZHNetWorkState : NSObject

///
@property (nonatomic, assign) BOOL isRightNetwork;

+ (instancetype)checkNetWorkState;

@end
