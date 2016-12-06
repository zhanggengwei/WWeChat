//
//  LoginViewModel.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/29.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "LoginViewModel.h"
#import <RongIMLib/RongIMLib.h>

@implementation LoginViewModel

- (void)loginWithPhoneNum:(NSString *)phoneNum password:(NSString *)password success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    @weakify(self)
    [self.manager GET:@"login" version:V1_1 parameters:@{@"username":phoneNum,@"password":[password wzx_MD5String]} success:^(id response, NSInteger code) {
        @strongify(self)
        if (code == 200) {
            [WZXKeyChain savePhoneNum:phoneNum password:password];
            [WZXKeyChain saveToken:response[@"sessionToken"]];
            [Statics saveCurrentUserWithDic:response];
            
            [self getRongCloudTokenAndLoginWithSuccess:^(id response, NSInteger code) {
                successBlock(response, code);
            } failure:^(NSError *error) {
                failureBlock(error);
            }];
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

- (void)getRongCloudTokenAndLoginWithSuccess:(SuccessBlock)successBlock
                                     failure:(FailureBlock)failureBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"开始请求");
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [self getRongCloudTokenWithUserId:[Statics currentUser].objectId success:^(id response, NSInteger code) {
            [WZXKeyChain saveRongToken:response[@"token"]];
            NSLog(@"请求token成功");
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSError *error) {
            NSLog(@"请求token失败");
            failureBlock(error);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        [self loginRongCloudWithToken:[WZXKeyChain loadRongToken] success:^(id response, NSInteger code) {
            NSLog(@"融云连接成功");
            successBlock(response, code);
        } failure:^(NSError *error) {
            NSLog(@"融云连接失败");
            failureBlock(error);
        }];
    });
}

- (void)getRongCloudTokenWithUserId:(NSString *)userId
                            success:(SuccessBlock)successBlock
                            failure:(FailureBlock)failureBlock {
    
    NSString * body = [NSString stringWithFormat:@"userId=%@&name=&portraitUri=",userId];
    [self.rongCloudManager POST:@"user/getToken.json" version:NONE parameters:[body dataUsingEncoding:NSUTF8StringEncoding] success:^(id response, NSInteger code) {
        successBlock(response, code);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

- (void)loginRongCloudWithToken:(NSString *)Token
                        success:(SuccessBlock)successBlock
                        failure:(FailureBlock)failureBlock {
    [[RCIMClient sharedRCIMClient] connectWithToken:Token
    success:^(NSString *userId) {
        successBlock(userId, 0);
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        failureBlock(nil);
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        failureBlock(nil);
        NSLog(@"token错误");
    }];
}
@end
