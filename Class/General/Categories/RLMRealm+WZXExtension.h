//
//  RLMRealm+WZXExtension.h
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <Realm/Realm.h>

@interface RLMRealm (WZXExtension)

+ (RLMRealm *)userRealm;

+ (RLMRealm *)messageRealm;

+ (RLMRealm *)otherRealm;
@end
