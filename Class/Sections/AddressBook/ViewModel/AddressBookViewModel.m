//
//  AddressBookViewModel.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/30.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "AddressBookViewModel.h"

@implementation AddressBookViewModel

- (void)addFriend:(NSString *)friendID success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    for (FriendObject * friendObj in [Statics currentUser].friends) {
        if ([friendObj.objectId isEqualToString:friendID]) {
            return;
        }
    }
    NSDictionary * dic = @{@"friends":@{@"__op"   : @"Add",
                                       @"objects": @[friendID]}};
    [self.manager PUT:[NSString stringWithFormat:@"users/%@",[Statics currentUser].objectId] version:V1_1 parameters:dic success:^(id response, NSInteger code) {
        successBlock(response, code);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

- (void)searchFriend:(NSArray<NSString *> *)friendIDs success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    NSDictionary * dic = @{
                           @"objectId":@{@"$in":friendIDs}
                                   };
    NSString * queryStr = [dic yy_modelToJSONString];
    NSString * queryUTF8Str = [queryStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager GET:[NSString stringWithFormat:@"users?where=%@",queryUTF8Str]  version:V1_1 parameters:nil success:^(id response, NSInteger code) {
        successBlock(response, code);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

- (NSArray *)addressBookDivideGroup:(NSArray *)users {
    NSMutableArray * dataArrs = [NSMutableArray array];
    NSMutableArray * otherUsers = [NSMutableArray arrayWithArray:users];
    for(char i = 'A';i <= 'Z';i++) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        NSMutableArray * currNameArr = [[NSMutableArray alloc]init];
        NSString * sectionName = [NSString stringWithFormat:@"%c",i];
        for (int j = 0; j < users.count; j++) {
            UserObject * user = users[j];
            if ([[user firstPhonetic] isEqualToString:sectionName]) {
                [currNameArr addObject:user];
                [otherUsers removeObject:user];
            }
        }
        if (currNameArr.count > 0) {
            [dic setObject:currNameArr forKey:@"names"];
            [dic setObject:sectionName forKey:@"sectionName"];
            [dataArrs addObject:dic];
        }
    }
    if (otherUsers.count > 0) {
        [dataArrs addObject:@{@"names":otherUsers,
                              @"sectionName":@"#"}];
    }
    return dataArrs;
}
@end
