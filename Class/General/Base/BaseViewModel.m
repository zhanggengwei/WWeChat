//
//  BaseViewModel.m
//  PopOn
//
//  Created by WzxJiang on 16/6/21.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (WDNetworking *)manager {
    if (!_manager) {
        _manager = [WDNetworking manager];
    }
    return _manager;
}

- (WDNetworking *)rongCloudManager {
    if (!_rongCloudManager) {
        NSString * nonce = [NSString stringWithFormat:@"%u",arc4random()];
        NSString * timestamp = [NSString stringWithFormat:@"%ld",(NSInteger)[Statics getTimestamp]];
        NSString * signature = [NSString stringWithFormat:@"%@%@%@",WZX_RONG_SECRET_KEY,nonce,timestamp];
        _rongCloudManager = [WDNetworking manager];
        [_rongCloudManager setHTTPHeaderFieldDic:@{@"App-Key":WZX_RONG_KEY,
                                                   @"Nonce":nonce,
                                                   @"Timestamp":timestamp,
                                                   @"Signature":[signature wzx_SHA1String],
                                                   @"Content-Type":@"application/x-www-form-urlencoded"}];
        [_rongCloudManager setBaseURL:@"https://api.cn.ronghub.com"];
    }
    return _rongCloudManager;
}

@end
