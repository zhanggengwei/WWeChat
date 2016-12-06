//
//  RLMRealm+WZXExtension.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "RLMRealm+WZXExtension.h"

@implementation RLMRealm (WZXExtension)

+ (RLMRealm *)userRealm {
    NSString * path = [NSString stringWithFormat:@"%@/userRealm.realm",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).firstObject];
    NSLog(@"USER REALM PATH: %@",path);
    RLMRealm * userRealm = [RLMRealm realmWithURL:[NSURL URLWithString:path]];
    return userRealm;
}

+ (RLMRealm *)messageRealm {
    NSString * path = [NSString stringWithFormat:@"%@/messageRealm.realm",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).firstObject];
    NSLog(@"MESSAGE REALM PATH: %@",path);
    RLMRealm * messageRealm = [RLMRealm realmWithURL:[NSURL URLWithString:path]];
    return messageRealm;
}

+ (RLMRealm *)otherRealm {
    NSString * path = [NSString stringWithFormat:@"%@/otherRealm.realm",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).firstObject];
    NSLog(@"OTHER REALM PATH: %@",path);
    RLMRealm * otherRealm = [RLMRealm realmWithURL:[NSURL URLWithString:path]];
    return otherRealm;
}
@end
