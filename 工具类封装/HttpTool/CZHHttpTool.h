//
//  CZHHttpTool.h
//  工具类封装
//
//  Created by 程召华 on 2017/12/12.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZHHttpTool : NSObject
#pragma MARK -- 基类
/**
 * 基类,get请求
 * url：可能全局是固定的
 * parameters ： 参数
 * progress ： 进度
 * success ： 指定成功的code回调
 * successOther ： 相对于成功的code 其他的code做处理，可能是需要交互的弹出框或者其他操作
 * failure ： 请求失败做处理
 * endRfresh ： 结束刷新的
 * showLoadingView ： 是否显示加载动画
 */
+ (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters progress:(void(^)(NSProgress * downloadProgress))progress  success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther failure:(void (^)(NSError *error))failure endRfresh:(void (^)(void))endRfresh  showLoadingView:(BOOL)showLoadingView;

+ (void)czh_post:(NSString *)url parameters:(NSMutableDictionary *)parameters progress:(void(^)(NSProgress * downloadProgress))progress  success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther failure:(void (^)(NSError *error))failure endRfresh:(void (^)(void))endRfresh  showLoadingView:(BOOL)showLoadingView;



#pragma MARK -- 针对各自需求的封装
///只需要管成功，并且一定需要加载动画
+ (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(id responseObject))success;
///需要加载动画，还要判断code为其他状态
+ (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther;
///有上啦加载下拉刷新的情况，
+ (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther failure:(void (^)(NSError *error))failure endRfresh:(void (^)(void))endRfresh  showLoadingView:(BOOL)showLoadingView;



@end
