//
//  WDExtension.h
//  PopOn
//
//  Created by WzxJiang on 16/6/17.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - localString

#import "UIView+WZXExtension.h"
#import "UIScrollView+WZXExtension.h"
#import "NSString+WZXExtension.h"
#import "NSDictionary+WZXExtension.h"
#import "RLMRealm+WZXExtension.h"

#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d]\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
    #define NSLog(FORMAT, ...) {}
#endif


//MARK: UIColor
UIColor * UIColor_4(CGFloat RED, CGFloat GREEN, CGFloat BLUE, CGFloat ALPHA);
UIColor * UIColor_3(CGFloat RED, CGFloat GREEN, CGFloat BLUE);
UIColor * UIColorFromRGB(NSInteger rgbValue);

//MARK: SandBox
id   SandboxGet(NSString * key);
void SandboxSave(id value, NSString * key);
void SandboxRemove(NSString * key);

//MARK: scale
CGFloat ScaleHeight(CGFloat height);
CGFloat ScaleWidth(CGFloat width);

//MARK:  
BOOL PhoneIs4();
BOOL PhoneIs5();
BOOL PhoneIs6();
BOOL PhoneIs6p();

id PhoneValue(id iPhone6p, id iPhone6, id iPhone5, id iPhone4);

//MARK: imageForBundle
//** KitUIBundle */
NSString * UIImagePathForKitBundle(NSString * imgName);
UIImage * UIImageForKitBundle(NSString * imgName);
NSString * UIImagePathForBundle(NSString * imgName, NSString * bundlename);
UIImage * UIImageForBundle(NSString * imgName, NSString * bundlename);

void NotificationAdd(id observer, SEL selector, NSString * name, NSString * alias);

void NotificationPost(NSString * name, NSString * alias, NSDictionary * userInfo);

void NotificationRemove(id observer, NSString * name, NSString * alias);

void SHOW_ALERT_ONE(UIViewController * fromVC, NSString * title, NSString * message, UIAlertAction * sureAction);
void SHOW_ALERT_TWO(NSString * title, NSString * message, NSString * sureTitle, UIAlertAction * otherAction);

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define the_UserDefault [NSUserDefaults standardUserDefaults]
#define the_NotificationCenter [NSNotificationCenter defaultCenter]
#define the_Application [UIApplication sharedApplication]

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

