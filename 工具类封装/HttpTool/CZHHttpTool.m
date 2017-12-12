//
//  CZHHttpTool.m
//  工具类封装
//
//  Created by 程召华 on 2017/12/12.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "CZHHttpTool.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "CZHHTTPSessionManager.h"
#import "CZHNetWorkState.h"

@interface CZHHttpTool ()
/**<#注释#>*/
@property (nonatomic, strong) CZHHTTPSessionManager *manager;
@end

@implementation CZHHttpTool


- (CZHHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [CZHHTTPSessionManager shareManager];
    }
    return _manager;
}


+ (void)czh_post:(NSString *)url parameters:(NSMutableDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id))success successOther:(void (^)(id))successOther failure:(void (^)(NSError *))failure endRfresh:(void (^)(void))endRfresh showLoadingView:(BOOL)showLoadingView {
    
    if ([CZHNetWorkState checkNetWorkState].isRightNetwork == YES) {
        if (showLoadingView) {
            //加载动画
        }
        
        [[[CZHHttpTool alloc] init].manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (showLoadingView) {//隐藏动画
                
            }
            if (endRfresh) {
                endRfresh();
            }
            
            if (responseObject) {
                //具体看项目接口返回的层级
                NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
                
                if (code == 0) {
                    
                    if (success) {
                        success(responseObject);
                    }
                    
                } else if (code == 100) {//比如全局统一的，直接在里面弹窗处理
                    
                } else {
                    
                    if (code == 200) {//需要弹窗提示充值
                        if (successOther) {
                            successOther(responseObject);
                        }
                    } else {
                        //提示吐司窗口
                    }
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (showLoadingView) {//隐藏动画
                
            }
            if (endRfresh) {
                endRfresh();
            }
            if (failure) {
                failure(error);
            }
        }];
    } else {
        //没有网络
    }
}

+ (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id))success successOther:(void (^)(id))successOther failure:(void (^)(NSError *))failure endRfresh:(void (^)(void))endRfresh showLoadingView:(BOOL)showLoadingView {
    if ([CZHNetWorkState checkNetWorkState].isRightNetwork == YES) {
        if (showLoadingView) {
            //加载动画
        }
        
        [[[CZHHttpTool alloc] init].manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (showLoadingView) {//隐藏动画
                
            }
            if (endRfresh) {
                endRfresh();
            }
            
            if (responseObject) {
                //具体看项目接口返回的层级
                NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
                
                if (code == 0) {
                    
                    if (success) {
                        success(responseObject);
                    }
                    
                } else if (code == 100) {//比如全局统一的，直接在里面弹窗处理
                    
                } else {
                    
                    if (code == 200) {//需要弹窗提示充值
                        if (successOther) {
                            successOther(responseObject);
                        }
                    } else {
                        //提示吐司窗口
                    }
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (showLoadingView) {//隐藏动画
                
            }
            if (endRfresh) {
                endRfresh();
            }
            if (failure) {
                failure(error);
            }
        }];
    } else {
        //没有网络
    }
}

///只需要管成功，并且一定需要加载动画
+ (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(id responseObject))success {
    [self czh_get:url parameters:parameters progress:nil success:success successOther:nil failure:nil endRfresh:nil showLoadingView:YES];
}
///需要加载动画，还要判断code为其他状态
+ (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther {
   [self czh_get:url parameters:parameters progress:nil success:success successOther:successOther failure:nil endRfresh:nil showLoadingView:YES];
}
///有上啦加载下拉刷新的情况，
+ (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther failure:(void (^)(NSError *error))failure endRfresh:(void (^)(void))endRfresh  showLoadingView:(BOOL)showLoadingView {
    [self czh_get:url parameters:parameters progress:nil success:success successOther:successOther failure:failure endRfresh:endRfresh showLoadingView:showLoadingView];
}


@end
