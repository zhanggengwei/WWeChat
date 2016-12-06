//
//  Statics.m
//  Wordoor
//
//  Created by BernieWang on 14-5-6.
//  Copyright (c) 2014年 Bernie. All rights reserved.
//

#import "Statics.h"

@implementation Statics

static UserObject * currentUser = nil;

+ (NSString*)localized:(NSString*)text{
    NSString * language = [Statics langcode];
    NSString * sendText = nil;
    if (!language) {
        return NSLocalizedString(text, nil);
    }
    if ([language isEqualToString:@"zh-CN"]) {
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"]];
        sendText = [bundle localizedStringForKey:text value:@"" table:nil];
    } else {
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]];
        sendText = [bundle localizedStringForKey:text value:@"" table:nil];
    }
    return sendText ? sendText : text;
}

+ (NSString *)langcode {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLang = [languages objectAtIndex:0];
        
        if ([currentLang rangeOfString:@"zh-Hans"].location != NSNotFound|| [currentLang rangeOfString:@"zh-Hant"].location != NSNotFound) {
            return @"zh-CN";
        } else {
            return @"en";
        }
}


+ (NSInteger) getTimeZone {
    NSTimeInterval timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
    return timeZoneOffset/60.0/60.0;
}

+ (NSTimeInterval)getTimestamp {
    NSDate * nowDate = [NSDate date];
    return [nowDate timeIntervalSince1970];
}

+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (NSString *)wzx_version {
    return SandboxGet((NSString *)kCFBundleVersionKey);
}

+ (NSString *)wzx_info_version {
    return [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleVersionKey];
}

+ (void)setWzx_version:(NSString *)wd_version {
    SandboxSave(wd_version, (NSString *)kCFBundleVersionKey);
}

+ (UserObject *)currentUser {
    return currentUser;
}
+ (void)saveCurrentUser:(UserObject *)userObject {
    currentUser = userObject;
}

+ (void)saveCurrentUserWithDic:(NSDictionary *)dic {
    UserObject * currentUser = [[UserObject alloc]init];
    [currentUser setValuesForKeysWithDictionary:dic];
    [Statics saveCurrentUser:currentUser];
}
@end