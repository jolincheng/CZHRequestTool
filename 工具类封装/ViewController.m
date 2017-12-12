//
//  ViewController.m
//  工具类封装
//
//  Created by 程召华 on 2017/12/12.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "ViewController.h"
#import "CZHGlobalRequestTool.h"
#import "CZHHttpTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
}

- (void)updateInfoWithNickname:(NSString *)nickname {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"nickname"] = nickname;
    
    [CZHGlobalRequestTool czh_updateInfoWithParameters:parameters successBlock:^{
        
    }];
}




- (void)getOwnInfo {
    
    [CZHGlobalRequestTool czh_getOwnInfoWithSuccessBlock:^{
        
    }];
    
}


///只在当前控制器使用
- (void)usedOnlyInCurrentController {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"s"] = @"only";
    parameters[@"uid"] = @"";
    parameters[@"token"] = @"";
    
    [CZHHttpTool czh_get:@"https://www.baidu.com" parameters:parameters success:^(id responseObject) {
        
    }];
}

///只在当前控制器使用
- (void)refreshUsedOnlyInCurrentControllerWithShowLoadingView:(BOOL)showLoadingView {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"s"] = @"only";
    parameters[@"uid"] = @"";
    parameters[@"token"] = @"";
    parameters[@"pageSize"] = @"1";
    
    
    [CZHHttpTool czh_get:@"https://www.baidu.com" parameters:parameters success:^(id responseObject) {
        
    } successOther:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    } endRfresh:^{
        
    } showLoadingView:showLoadingView];
}



@end
