//
//  WDExtension.m
//  PopOn
//
//  Created by WzxJiang on 16/6/17.
//  Copyright © 2016年 wordoor. All rights reserved.
//
UIColor * UIColor_4(CGFloat RED, CGFloat GREEN, CGFloat BLUE, CGFloat ALPHA) {
    return [UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:ALPHA];
}

UIColor * UIColor_3(CGFloat RED, CGFloat GREEN, CGFloat BLUE) {
    return UIColor_4(RED, GREEN, BLUE, 1);
}

UIColor * UIColorFromRGB(NSInteger rgbValue) {
    return
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                     blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

//--------------------------------------------------------------------------
id SandboxGet(NSString * key) {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

void SandboxSave(id value, NSString * key) {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

void SandboxRemove(NSString * key) {
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

//--------------------------------------------------------------------------
CGFloat ScaleHeight(CGFloat height) {
    return ([UIScreen mainScreen].bounds.size.height/568.f) * height;
}

CGFloat ScaleWidth(CGFloat width) {
    return ([UIScreen mainScreen].bounds.size.width/320.f) * width;
}

//--------------------------------------------------------------------------

BOOL PhoneIs4() {
    return (kScreenHeight == 480)&&(kScreenWidth == 320);
}

BOOL PhoneIs5() {
    return (kScreenHeight == 568)&&(kScreenWidth == 320);
}

BOOL PhoneIs6() {
    return (kScreenHeight == 667)&&(kScreenWidth == 375);
}

BOOL PhoneIs6p() {
    return (kScreenHeight == 736)&&(kScreenWidth == 414);
}

id _SiftNil(NSArray * values){
    for (int i = 0; i < values.count; i++) {
        if (values[i]!=nil
            && ![values[i] isKindOfClass:[NSNull class]]) {
            return values[i];
        }
    }
    return nil;
}

id PhoneValue(id iPhone6p, id iPhone6, id iPhone5, id iPhone4) {
    if (PhoneIs6p()) {
        return _SiftNil(@[iPhone6p, iPhone6, iPhone5, iPhone4]);
    } else if (PhoneIs6()) {
        return _SiftNil(@[iPhone6, iPhone5, iPhone4]);
    } else if (PhoneIs5()) {
        return _SiftNil(@[iPhone5, iPhone4]);
    } else if (PhoneIs4()) {
        return _SiftNil(@[iPhone4]);
    } else {
        return nil;
    }
}

//--------------------------------------------------------------------------

NSString * UIImagePathForBundle(NSString * imgName, NSString * bundlename) {
    return [NSString stringWithFormat:@"%@.bundle/%@",bundlename,imgName];
}

UIImage * UIImageForBundle(NSString * imgName, NSString * bundlename) {
    NSString * imgPath = UIImagePathForBundle(imgName, bundlename);
    return [UIImage imageNamed:imgPath];
}

NSString * UIImagePathForKitBundle(NSString * imgName) {
    return UIImagePathForBundle(imgName, @"WWeChatKit");
}

UIImage * UIImageForKitBundle(NSString * imgName) {
    NSString * imgPath = UIImagePathForKitBundle(imgName);
    return [UIImage imageNamed:imgPath];
}

//--------------------------------------------------------------------------

void NotificationAdd(id observer, SEL selector, NSString * name, NSString * alias) {
    NotificationRemove(observer, name, alias);
    [the_NotificationCenter addObserver:observer selector:selector name:name object:alias];
}

void NotificationPost(NSString * name, NSString * alias, NSDictionary * userInfo) {
    [the_NotificationCenter postNotificationName:name object:alias userInfo:userInfo];
}

void NotificationRemove(id observer, NSString * name, NSString * alias) {
    if (name) {
        [the_NotificationCenter removeObserver:observer name:name object:alias];
    }
}

//--------------------------------------------------------------------------
void SHOW_ALERT_ONE(UIViewController * fromVC, NSString * title, NSString * message, UIAlertAction * sureAction) {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:[Statics localized:message] message:[Statics localized:title] preferredStyle:UIAlertControllerStyleAlert];
    
    if (!sureAction) {
        sureAction = [UIAlertAction actionWithTitle:[Statics localized:@"确定"] style:UIAlertActionStyleCancel handler:nil];
    }
    
    [alertVC addAction:sureAction];
    
    [fromVC presentViewController:alertVC animated:YES completion:nil];
}

void SHOW_ALERT_TWO(NSString * title, NSString * message, NSString * sureTitle, UIAlertAction * otherAction) {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:[Statics localized:title] message:[Statics localized:title] preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:[Statics localized:sureTitle] style:UIAlertActionStyleCancel handler:nil]];
    
    [alertVC addAction:otherAction];
    
    [[Statics getCurrentVC] presentViewController:alertVC animated:YES completion:nil];
}

