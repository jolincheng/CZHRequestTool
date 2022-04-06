# CZHRequestTool


####一个项目中，请求是最基本的功能，一般有点经验的都会把请求封装成一个工具类，方便修改和降低第三方代码的入侵

- 针对项目的使用需求的不同封装也会做很多种，有的请求需要加载视图，有的不需要加载视图，有的需要上啦和下拉的，有的需要判断不同的code做操作，有的请求是get，有的是post，所以需求太多了，我这边的做法就是先封装一个包含所有需求的基类

```
///get
///url:请求地址
///parameters:参数
///refreshStyle:yes有加载动画，no没有加载动画
///progress：请求进度
///success：请求成功后台指定code
///successOther：其他code回调
///failure:请求失败
///endRfresh：结束刷新等的一些操作写在里面
- (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters refreshStyle:(BOOL)refreshStyle progress:(void(^)(NSProgress * downloadProgress))progress  success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther failure:(void (^)(NSError *error))failure endRfresh:(void (^)())endRfresh;

///post
- (void)czh_post:(NSString *)url parameters:(NSMutableDictionary *)parameters refreshStyle:(BOOL)refreshStyle progress:(void(^)(NSProgress * downloadProgress))progress success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther failure:(void (^)(NSError *error))failure endRfresh:(void (^)())endRfresh;
```


- 然后针对需求的不同可以扩展几个，比如不需要结束刷新，这个请求只需要请求成功，不需要其他code状态，不需要进度，一定需要加载动画的，多写几个方便使用，不用每个请求都用基类

```
/**有刷新的使用这个方法，吧结束刷新写在endRfresh*/
- (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters refreshStyle:(BOOL)refreshStyle success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure endRfresh:(void (^)())endRfresh;
/**get请求需要进度*/
- (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters progress:(void(^)(NSProgress * downloadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**get请求不需要进度*/
- (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**get请求不需要进度并且返回除了code=0的其他情况*/
- (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther failure:(void (^)(NSError *error))failure ;
/**get请求不需要进度并且返回除了code=0的其他情况*/
- (void)czh_get:(NSString *)url parameters:(NSMutableDictionary *)parameters refreshStyle:(BOOL)refreshStyle success:(void (^)(id responseObject))success successOther:(void (^)(id responseObject))successOther failure:(void (^)(NSError *error))failure endRfresh:(void (^)())endRfresh;
```

- 具体根据自己的需求来增加，目的是为了方便使用，后面有不同的需求也可以随时增加一个


####开发中多多少少会有很多接口是好多地方用得到的，如果还是用上面的封装使用的话这样又会有问题了，比如这个接口要增加一个必要的参数，那么就要找到所有的地方每个地方都加一个，这样就很麻烦，所以我对使用多的接口又会进行一层封装，写一个全局请求工具类，把使用较多的接口都封装在里面

```
///这个接口是获取自己的信息
+ (void)czh_getOwnInfoWithSuccessBlock:(void(^)(void))successBlock;
///这个是更新信息，这样写只用传入修改的参数
+ (void)czh_updateInfoWithParameters:(NSMutableDictionary *)parameters successBlock:(void(^)(void))successBlock;
///这个是发送消息接口,除了成功code为0的时候，还要判断code不为0某种特定的code来提示弹窗alert提示用户去充值，或者开通vip才能继续聊天
+ (void)czh_sendMessWithParameters:(NSMutableDictionary *)parameters successBlock:(void(^)(void))successBlock  otherCode:(void (^)(id obj))otherCode;
///关注接口只需要传入对方的uid，对成功做处理
+ (void)czh_addAttentionWithUserId:(NSString *)userId successBlock:(void(^)(void))successBlock;
///取消关注接口只需要传入对方的uid，对成功做处理
+ (void)czh_removeAttentionWithUserId:(NSString *)userId successBlock:(void(^)(void))successBlock;
```
- 具体针对各自的项目做具体的处理，我是我的经验，希望对你们也有用

```
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
```
