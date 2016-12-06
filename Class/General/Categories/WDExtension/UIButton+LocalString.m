//
//  UIButton+LocalString.m
//  PopOn
//
//  Created by WzxJiang on 16/6/20.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import "UIButton+LocalString.h"

@implementation UIButton (LocalString)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(setTitle:forState:);
        SEL swizzSel  = @selector(wd_setTitle:forState:);
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}

- (void)wd_setTitle:(nullable NSString *)title forState:(UIControlState)state {
    [self wd_setTitle:[Statics localized:title] forState:state];
}

@end
