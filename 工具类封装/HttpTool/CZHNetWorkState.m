//
//  CZHNetWorkState.m
//  工具类封装
//
//  Created by 程召华 on 2017/12/12.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "CZHNetWorkState.h"
#import "AFNetworkReachabilityManager.h"

@implementation CZHNetWorkState

+ (void)load {
    
    [CZHNetWorkState checkNetWorkState];
    
}

+ (instancetype)checkNetWorkState {
    

    CZHNetWorkState *state = [[CZHNetWorkState alloc] init];
    
    return state;
    
   
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.isRightNetwork = YES;
        //1.创建网络监测者
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        
        /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
         typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
         AFNetworkReachabilityStatusUnknown          = -1,      未知
         AFNetworkReachabilityStatusNotReachable     = 0,       无网络
         AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
         AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
         };
         */
        __weak typeof(self) weakSelf = self;
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            //这里是监测到网络改变的block  可以写成switch方便
            //在里面可以随便写事件
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    NSLog(@"未知网络状态");
                    strongSelf.isRightNetwork = NO;
                    //                self.networkState = NO;
                    //                [ONSTipsView ons_showTipsViewWithString:@"网络异常,请检查你的网络情况"];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"无网络");
                    strongSelf.isRightNetwork = NO;
                    //                [ONSTipsView ons_showTipsViewWithString:@"网络异常,请检查你的网络情况"];
                    //                self.networkState = NO;
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"蜂窝数据网");
                    strongSelf.isRightNetwork = YES;
                    //                self.networkState = YES;
                    //                [ONSTipsView hideTips];
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"WiFi网络");
                    strongSelf.isRightNetwork = YES;
                    //                self.networkState = YES;
                    //                [ONSTipsView hideTips];
                    break;
                    
                default:
                    break;
            }
            
        }] ;
        //开始监听
        [manager startMonitoring];
        
        
    }
    return self;
}

@end
