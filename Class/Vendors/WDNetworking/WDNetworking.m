//
//  WDNetworking.m
//  WDNetworking
//
//  Created by WzxJiang on 16/6/16.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import "WDNetworking.h"
#import "AFNetworking.h"

@implementation WDNetworking

- (NSString *)_baseUrl:(NSString *)url apiVersion:(WDApiVersion)apiVersion {
    NSString * version = @"";
    switch (apiVersion) {
        case V1_0: version = @"1.0";
            break;
        case V1_1: version = @"1.1";
            break;
        case V1_2: version = @"1.2";
            break;
        case NONE: version = @"";
            break;
        default:
            break;
    }
    if (_baseURL == nil || _baseURL.length == 0) {
        _baseURL = SITE_Formal_URL;
    }
    
    if (version.length > 0) {
        return [NSString stringWithFormat:@"%@/%@/%@",_baseURL,version,url];
    } else {
        return [NSString stringWithFormat:@"%@/%@",_baseURL,url];
    }
}

+ (instancetype)manager {
    WDNetworking * manager = [[WDNetworking alloc]init];
    [manager _checkNetworkStateSetUp];
    manager.session = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requests = [NSMutableArray array];
    manager.currentRequestIndex = 0;
    return manager;
}

- (void)setMaxConcurrentOperationCount:(NSUInteger)maxConcurrentOperationCount {
    self.session.operationQueue.maxConcurrentOperationCount = maxConcurrentOperationCount;
}

//MARK: 配置好检查网络的回调
- (void)_checkNetworkStateSetUp {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable||status ==AFNetworkReachabilityStatusUnknown){
            NSLog(@"网络连接已断开，请检查您的网络！");
            return ;
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            NSLog(@"你现在使用的是移动数据");
            return;
        }
    }];
}

//MARK: 检查网络
- (void)checkNetworkState {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark -- 网络操作
- (void)cancelAllRequest {
    [self.session.operationQueue cancelAllOperations];
}

- (void)cancelRequest:(NSUInteger)index {
    if (self.session.dataTasks.count > index) {
        NSURLSessionDataTask * task = self.session.dataTasks[index];
        [task suspend];
    } else {
        NSLog(@"没有该任务");
    }
}

#pragma mark -- parameters操作
//MARK: ?加请求信息的方式
- (NSURL *)_GETURL:(NSString *)url version:(WDApiVersion)apiVersion parameters:(id)parameters {
    if (parameters) {
        NSMutableString * bodyString = [NSMutableString stringWithString:@"?"];
        if ([parameters isKindOfClass:[NSDictionary class]]) {
            NSDictionary * parameterDic = (NSDictionary *)parameters;
            for (NSString * key in parameterDic.allKeys) {
                [bodyString appendFormat:@"%@=%@",key,parameterDic[key]];
                if (![key isEqual:parameterDic.allKeys.lastObject]) {
                    [bodyString appendString:@"&"];
                }
            }
            return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[self _baseUrl:url apiVersion:apiVersion],bodyString]];
        } else if ([parameters isKindOfClass:[NSString class]]){
            return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[self _baseUrl:url apiVersion:apiVersion],parameters]];
        } else {
            return [NSURL URLWithString:[self _baseUrl:url apiVersion:apiVersion]];
        }
    } else {
        return [NSURL URLWithString:[self _baseUrl:url apiVersion:apiVersion]];
    }
}

//MARK: 填充body的方式
- (NSData *)_parametersToBody:(id)parameters {
    if (parameters) {
        if ([parameters isKindOfClass:[NSData class]]) {
            return parameters;
        } else {
            return [parameters yy_modelToJSONData];
        }
    } else {
        return nil;
    }
}

#pragma mark -- 网络请求
- (void)GET:(NSString *)url version:(WDApiVersion)apiVersion parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self _showHUD];
    WDURLRequest * request = [WDURLRequest requestWithURL:[self _GETURL:url version:apiVersion parameters:parameters] headerDic:_HTTPHeaderFieldDic];
    [request setHTTPMethod:@"GET"];
    if ([parameters isKindOfClass:[NSData class]]) {
        [request setHTTPBody:parameters];
    }
    @weakify(self)
    [_requests addObject:request];
    NSURLSessionDataTask * dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self)
        _currentRequestIndex ++;
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if (error) {
            [self _showErrorHUD];
            failure(error);
        } else {
            [self _hideHUD];
            success(responseObject, httpResponse.statusCode);
        }
    }];
    [dataTask resume];
}

- (void)DELETE:(NSString *)url version:(WDApiVersion)apiVersion parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self _showHUD];
    WDURLRequest * request = [WDURLRequest requestWithURL:[self _GETURL:url version:apiVersion parameters:parameters] headerDic:_HTTPHeaderFieldDic];
    [request setHTTPMethod:@"DELETE"];
    @weakify(self)
    [_requests addObject:request];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self)
        _currentRequestIndex ++;
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if (error) {
            [self _showErrorHUD];
            failure(error);
        } else {
            [self _hideHUD];
            success(responseObject, httpResponse.statusCode);
        }
    }];
    [dataTask resume];
}

- (void)POST:(NSString *)url version:(WDApiVersion)apiVersion parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self _showHUD];
    WDURLRequest * request = [WDURLRequest requestWithURL:[NSURL URLWithString:[self _baseUrl:url apiVersion:apiVersion]] headerDic:_HTTPHeaderFieldDic];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[self _parametersToBody:parameters]];
    @weakify(self)
    [_requests addObject:request];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self)
        _currentRequestIndex ++;
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if (error) {
            [self _showErrorHUD];
            failure(error);
        } else {
            [self _hideHUD];
            success(responseObject, httpResponse.statusCode);
        }
    }];
    [dataTask resume];
}

- (void)PUT:(NSString *)url version:(WDApiVersion)apiVersion parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self _showHUD];
     WDURLRequest * request = [WDURLRequest requestWithURL:[NSURL URLWithString:[self _baseUrl:url apiVersion:apiVersion]] headerDic:_HTTPHeaderFieldDic];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:[self _parametersToBody:parameters]];
    @weakify(self)
    [_requests addObject:request];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self)
        _currentRequestIndex ++;
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if (error) {
            [self _showErrorHUD];
            failure(error);
        } else {
            [self _hideHUD];
            success(responseObject, httpResponse.statusCode);
        }
    }];
    [dataTask resume];
}

- (void)PATCH:(NSString *)url version:(WDApiVersion)apiVersion parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self _showHUD];
    WDURLRequest * request = [WDURLRequest requestWithURL:[NSURL URLWithString:[self _baseUrl:url apiVersion:apiVersion]] headerDic:_HTTPHeaderFieldDic];
    [request setHTTPMethod:@"PATCH"];
    [request setHTTPBody:[self _parametersToBody:parameters]];
    @weakify(self)
    [_requests addObject:request];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self)
        _currentRequestIndex ++;
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if (error) {
            [self _showErrorHUD];
            failure(error);
        } else {
            [self _hideHUD];
            success(responseObject, httpResponse.statusCode);
        }
    }];
    [dataTask resume];
}

- (void)UPLOAD:(NSString *)url version:(WDApiVersion)apiVersion parameters:(id)parameters contentType:(NSString *)contentType progress:(void (^)(NSProgress *))progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self _showHUD];
    WDURLRequest * request = [WDURLRequest requestWithURL:[NSURL URLWithString:[self _baseUrl:url apiVersion:apiVersion]] headerDic:_HTTPHeaderFieldDic];
    [request setHTTPMethod:@"POST"];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    @weakify(self)
    [_requests addObject:request];
    NSURLSessionUploadTask *dataTask = [self.session uploadTaskWithRequest:request fromData:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        @strongify(self)
        _currentRequestIndex ++;
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if (error) {
            [self _showErrorHUD];
            failure(error);
        } else {
            [self _hideHUD];
            success(responseObject, httpResponse.statusCode);
        }
    }];
    [dataTask resume];
}

#pragma mark - hud
- (void)_showHUD {
    if (_currentRequestIndex == 0) {
        [WZXProgressTool show:self.loadString Interaction:YES];
    }
}

- (void)_hideHUD {
    if (_currentRequestIndex == _requests.count) {
        [WZXProgressTool dismiss];
        if (self.successString) {
            [WZXProgressTool showSuccess:self.successString Interaction:YES];
        }
    }
}

- (void)_showErrorHUD {
    if (_currentRequestIndex == _requests.count) {
        [WZXProgressTool showError:self.errorString Interaction:NO];
    }
}

- (NSString *)loadString {
    if (_loadString) {
        return _loadString;
    } else {
        return @"加载中";
    }
}

- (NSString *)errorString {
    if (_errorString) {
        return _errorString;
    } else {
        return @"加载失败";
    }
}


@end

@implementation WDURLRequest

+ (instancetype)requestWithURL:(NSURL *)URL headerDic:(NSDictionary *)headerDic{
    WDURLRequest * request = [super requestWithURL:URL];
    [request setHttpHeader:headerDic];
    return request;
}

- (void)setHttpHeader:(NSDictionary *)headerDic {
    if (headerDic) {
        for (NSString * key in headerDic.allKeys) {
            [self setValue:headerDic[key] forHTTPHeaderField:key];
        }
    } else {
        [self setValue:@"YavVlGleImoT5XVkekX0kyGm-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
        [self setValue:@"nPIl7IkH9LtvsnUK7b8hxlS4" forHTTPHeaderField:@"X-LC-Key"];
        [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSString * token = [WZXKeyChain loadToken];
        if (token) {
            [self setValue:token forHTTPHeaderField:@"X-LC-Session"];
        }
    }
}

@end
