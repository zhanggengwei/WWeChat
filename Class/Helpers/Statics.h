//
//  Statics.h
//  Wordoor
//
//  Created by BernieWang on 14-5-6.
//  Copyright (c) 2014年 Bernie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObject.h"
@interface Statics: NSObject

+ (NSString *)localized:(NSString*)text;

/** 获取本机语言 */
+ (NSString *)langcode;

/** 获取时区 */
+ (NSInteger)getTimeZone;
+ (NSTimeInterval)getTimestamp;

+ (UIViewController *)getCurrentVC;

/** 取出版本号 */
+ (NSString *)wzx_version;
+ (NSString *)wzx_info_version;

+ (void)setWzx_version:(NSString *)wd_version;

+ (UserObject *)currentUser;
+ (void)saveCurrentUser:(UserObject *)userObject;
+ (void)saveCurrentUserWithDic:(NSDictionary *)dic;
@end
