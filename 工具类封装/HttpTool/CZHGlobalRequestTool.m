//
//  CZHGlobalRequestTool.m
//  工具类封装
//
//  Created by 程召华 on 2017/12/12.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "CZHGlobalRequestTool.h"
#import "CZHHttpTool.h"

@implementation CZHGlobalRequestTool


///这个接口是获取自己的信息
+ (void)czh_getOwnInfoWithSuccessBlock:(void(^)(void))successBlock {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"s"] = @"ownInfo";
    parameters[@"token"] = @"";
    parameters[@"uid"] = @"";
    
    [CZHHttpTool czh_get:@"https://www.baidu.com" parameters:parameters success:^(id responseObject) {
        //先保存个人信息
        
        //回调
        if (successBlock) {
            successBlock();
        }
    }];
    
}
///这个是更新信息，这样写只用传入修改的参数
+ (void)czh_updateInfoWithParameters:(NSMutableDictionary *)parameters successBlock:(void(^)(void))successBlock {
    
    parameters[@"s"] = @"updateInfo";
    parameters[@"token"] = @"";
    parameters[@"uid"] = @"";
    
    [CZHHttpTool czh_get:@"https://www.baidu.com" parameters:parameters success:^(id responseObject) {
        if (successBlock) {
            successBlock();
        }
    }];
}
///这个是发送消息接口,除了成功code为0的时候，还要判断code不为0某种特定的code来提示弹窗alert提示用户去充值，或者开通vip才能继续聊天
+ (void)czh_sendMessWithParameters:(NSMutableDictionary *)parameters successBlock:(void(^)(void))successBlock  otherCode:(void (^)(id obj))otherCode {
    
    parameters[@"s"] = @"sendmessage";
    parameters[@"token"] = @"";
    parameters[@"uid"] = @"";
    
    [CZHHttpTool czh_get:@"https://www.baidu.com" parameters:parameters success:^(id responseObject) {
        if (successBlock) {
            successBlock();
        }
    } successOther:^(id responseObject) {
        if (otherCode) {
            otherCode(responseObject);
        }
    }];

}
///关注接口只需要传入对方的uid，对成功做处理
+ (void)czh_addAttentionWithUserId:(NSString *)userId successBlock:(void(^)(void))successBlock {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"s"] = @"addAttention";
    parameters[@"token"] = @"";
    parameters[@"uid"] = @"";
    parameters[@"touid"] = userId;
    
    [CZHHttpTool czh_get:@"https://www.baidu.com" parameters:parameters success:^(id responseObject) {
        if (successBlock) {
            successBlock();
        }
    }];
}
///取消关注接口只需要传入对方的uid，对成功做处理
+ (void)czh_removeAttentionWithUserId:(NSString *)userId successBlock:(void(^)(void))successBlock {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"s"] = @"removeAttention";
    parameters[@"token"] = @"";
    parameters[@"uid"] = @"";
    parameters[@"touid"] = userId;
    
    [CZHHttpTool czh_get:@"https://www.baidu.com" parameters:parameters success:^(id responseObject) {
        if (successBlock) {
            successBlock();
        }
    }];
}

@end
