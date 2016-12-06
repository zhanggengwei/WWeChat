//
//  ChangeDataViewModel.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/29.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "ChangeDataViewModel.h"

@implementation ChangeDataViewModel

- (void)changeSex:(BOOL)isMan success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.manager PUT:[NSString stringWithFormat:@"users/%@",[Statics currentUser].objectId] version:V1_1 parameters:@{@"sex":@(isMan)} success:^(id response, NSInteger code) {
        [Statics currentUser].sex = isMan;
        successBlock(response, code);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

- (void)changeNickName:(NSString *)nickName success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.manager PUT:[NSString stringWithFormat:@"users/%@",[Statics currentUser].objectId] version:V1_1 parameters:@{@"nickName":nickName} success:^(id response, NSInteger code) {
        [Statics currentUser].nickName = nickName;
        successBlock(response, code);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

- (void)changeAvater:(NSData *)avaterData success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    dispatch_semaphore_t semaphore_t = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block NSString * avaterUrl;
       [self.manager UPLOAD:[NSString stringWithFormat:@"files/avater_%@_%f.jpg",[Statics currentUser].objectId,[Statics getTimestamp]] version:V1_1 parameters:avaterData contentType:@"image/jpg" progress:^(NSProgress *uploadProgress) {
           NSLog(@"%f",uploadProgress.fractionCompleted);
       } success:^(id response, NSInteger code) {
           NSLog(@"上传图片完成");
           avaterUrl = response[@"url"];
           dispatch_semaphore_signal(semaphore_t);
       } failure:^(NSError *error) {
           failureBlock(error);
       }];
       
       dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
        NSLog(@"开始更新User");
       [self _updateAvater:avaterUrl success:^(id response, NSInteger code) {
           NSLog(@"更新ed User");
           successBlock(response, code);
       } failure:^(NSError *error) {
           failureBlock(error);
       }];
   });
    
}

- (void)_updateAvater:(NSString *)avaterUrl success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.manager PUT:[NSString stringWithFormat:@"users/%@",[Statics currentUser].objectId] version:V1_1 parameters:@{@"avaterUrl":avaterUrl} success:^(id response, NSInteger code) {
        [Statics currentUser].avaterUrl = avaterUrl;
        successBlock(response, code);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
@end
