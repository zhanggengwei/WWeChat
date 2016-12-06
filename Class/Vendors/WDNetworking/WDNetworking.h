//
//  WDNetworking.h
//  WDNetworking
//
//  Created by WzxJiang on 16/6/16.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFURLSessionManager;

@interface WDNetworking : NSObject

typedef void(^SuccessBlock)(id response, NSInteger code);
typedef void(^progressBlock)();
typedef void(^FailureBlock)(NSError * error);

typedef NS_ENUM(NSInteger,WDApiVersion) {
    NONE = -1,
    V1_0,
    V1_1,
    V1_2,
};

/**
 *  WDNetworking对象非单例
 *
 *  @return WDNetworking对象
 */
+ (instancetype)manager;

@property(nonatomic,assign)NSInteger currentRequestIndex;

@property(nonatomic,strong)NSMutableArray * requests;

@property(nonatomic,strong)AFURLSessionManager * session;

@property(nonatomic,copy)NSString * baseURL;
@property(nonatomic,copy)NSDictionary * HTTPHeaderFieldDic;
/**
 *  当前session最大并发数
 */
@property(nonatomic,assign)NSUInteger maxConcurrentOperationCount;

@property(nonatomic,copy)NSString * loadString;
@property(nonatomic,copy)NSString * errorString;
@property(nonatomic,copy)NSString * successString;

- (void)GET:(NSString *)url
    version:(WDApiVersion)apiVersion
 parameters:(id)parameters
    success:(SuccessBlock)success
    failure:(FailureBlock)failure;

- (void)POST:(NSString *)url
     version:(WDApiVersion)apiVersion
  parameters:(id)parameters
     success:(SuccessBlock)success
     failure:(FailureBlock)failure;

- (void)PUT:(NSString *)url
    version:(WDApiVersion)apiVersion
 parameters:(id)parameters
    success:(SuccessBlock)success
    failure:(FailureBlock)failure;

- (void)PATCH:(NSString *)url
      version:(WDApiVersion)apiVersion
   parameters:(id)parameters
      success:(SuccessBlock)success
      failure:(FailureBlock)failure;

- (void)DELETE:(NSString *)url
       version:(WDApiVersion)apiVersion
    parameters:(id)parameters
       success:(SuccessBlock)success
       failure:(FailureBlock)failure;

//- (void)DOWNLOAD:(NSString *)url
//         version:(WDApiVersion)apiVersion
//      parameters:(id)parameters
//         success:(SuccessBlock)success
//         failure:(FailureBlock)failure;
//
- (void)UPLOAD:(NSString *)url
       version:(WDApiVersion)apiVersion
    parameters:(id)parameters
   contentType:(NSString *)contentType
      progress:(void(^)(NSProgress * uploadProgress))progress
       success:(SuccessBlock)success
       failure:(FailureBlock)failure;

/**
 *  当前session取消所有请求
 */
- (void)cancelAllRequest;

/**
 *  当前session取消第index个请求
 */
- (void)cancelRequest:(NSUInteger)index;
@end

@interface WDURLRequest : NSMutableURLRequest

+ (instancetype)requestWithURL:(NSURL *)URL headerDic:(NSDictionary *)headerDic;

@end
