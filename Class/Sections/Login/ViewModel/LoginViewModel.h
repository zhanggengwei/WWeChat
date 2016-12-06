//
//  LoginViewModel.h
//  WWeChat
//
//  Created by WzxJiang on 16/6/29.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BaseViewModel.h"

@interface LoginViewModel : BaseViewModel

- (void)loginWithPhoneNum:(NSString *)phoneNum
                 password:(NSString *)password
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock;

- (void)getRongCloudTokenWithUserId:(NSString *)userId
                            success:(SuccessBlock)successBlock
                            failure:(FailureBlock)failureBlock;

- (void)loginRongCloudWithToken:(NSString *)Token
                        success:(SuccessBlock)successBlock
                        failure:(FailureBlock)failureBlock;

- (void)getRongCloudTokenAndLoginWithSuccess:(SuccessBlock)successBlock
                                     failure:(FailureBlock)failureBlock;
@end
