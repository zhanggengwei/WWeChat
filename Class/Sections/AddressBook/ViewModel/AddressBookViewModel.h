//
//  AddressBookViewModel.h
//  WWeChat
//
//  Created by WzxJiang on 16/6/30.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BaseViewModel.h"

@interface AddressBookViewModel : BaseViewModel

- (void)addFriend:(NSString *)friendID
          success:(SuccessBlock)successBlock
          failure:(FailureBlock)failureBlock;

- (void)searchFriend:(NSArray <NSString *> *)friendIDs
             success:(SuccessBlock)successBlock
             failure:(FailureBlock)failureBlock;

- (NSArray *)addressBookDivideGroup:(NSArray *)users;
@end
