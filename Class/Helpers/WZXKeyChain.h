//
//  KeyChain.h
//  Randomer
//
//  Created by 王子轩 on 16/4/9.
//  Copyright © 2016年 com.wzx. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WZXKeyChain : NSObject

extern NSString * const WZX_KEY_CHAIN_PHONENUM;
extern NSString * const WZX_KEY_CHAIN_PASSWORD;
extern NSString * const WZX_KEY_CHAIN_TOKEN;
extern NSString * const WZX_KEY_CHAIN_RONGTOKEN;

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKey:(NSString *)service;

+ (void)saveToken:(id)token;
+ (void)saveRongToken:(id)rongToken;
+ (void)savePhoneNum:(id)phoneNum password:(id)password;


+ (NSString *)loadPhoneNum;
+ (NSString *)loadPassword;
+ (NSString *)loadToken;
+ (NSString *)loadRongToken;



@end
