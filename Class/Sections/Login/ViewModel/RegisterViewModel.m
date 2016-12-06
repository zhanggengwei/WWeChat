//
//  RegisterViewModel.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/29.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel

- (void)registerWithPhoneNum:(NSString *)phoneNum password:(NSString *)password success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.manager POST:@"users" version:V1_1 parameters:@{@"username":phoneNum,@"password":[password wzx_MD5String]} success:^(id response, NSInteger code) {
        if (code == 201) {
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


@end
