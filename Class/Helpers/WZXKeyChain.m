//
//  KeyChain.m
//  Randomer
//
//  Created by 王子轩 on 16/4/9.
//  Copyright © 2016年 com.wzx. All rights reserved.
//

#import "WZXKeyChain.h"
#import <Security/Security.h>

NSString * const WZX_KEY_CHAIN_PHONENUM  = @"WZX_KEY_CHAIN_PHONENUM";
NSString * const WZX_KEY_CHAIN_PASSWORD  = @"WZX_KEY_CHAIN_PASSWORD";
NSString * const WZX_KEY_CHAIN_TOKEN     = @"WZX_KEY_CHAIN_TOKEN";
NSString * const WZX_KEY_CHAIN_RONGTOKEN = @"WZX_KEY_CHAIN_RONGTOKEN";
@implementation WZXKeyChain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKey:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+ (void)savePhoneNum:(id)phoneNum password:(id)password {
    [self save:WZX_KEY_CHAIN_PHONENUM data:phoneNum];
    [self save:WZX_KEY_CHAIN_PASSWORD data:password];
}

+ (void)saveToken:(id)token {
    [self save:WZX_KEY_CHAIN_TOKEN data:token];
}

+ (void)saveRongToken:(id)rongToken {
    [self save:WZX_KEY_CHAIN_RONGTOKEN data:rongToken];
}

+ (NSString *)loadPhoneNum {
    return [self load:WZX_KEY_CHAIN_PHONENUM];
}

+ (NSString *)loadPassword {
    return [self load:WZX_KEY_CHAIN_PASSWORD];
}

+ (NSString *)loadToken {
    return [self load:WZX_KEY_CHAIN_TOKEN];
}

+ (NSString *)loadRongToken {
    return [self load:WZX_KEY_CHAIN_RONGTOKEN];
}
@end
