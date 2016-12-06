//
//  ChangeDataViewModel.h
//  WWeChat
//
//  Created by WzxJiang on 16/6/29.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BaseViewModel.h"

@interface ChangeDataViewModel : BaseViewModel

- (void)changeSex:(BOOL)isMan
          success:(SuccessBlock)successBlock
          failure:(FailureBlock)failureBlock;

- (void)changeNickName:(NSString *)nickName
               success:(SuccessBlock)successBlock
               failure:(FailureBlock)failureBlock;

- (void)changeAvater:(NSData *)avaterData
             success:(SuccessBlock)successBlock
             failure:(FailureBlock)failureBlock;
@end
