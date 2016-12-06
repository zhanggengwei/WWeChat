//
//  UITextField+LocalString.m
//  PopOn
//
//  Created by WzxJiang on 16/6/20.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import "UITextField+LocalString.h"

@implementation UITextField (LocalString)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel1 = @selector(setText:);
        SEL swizzSel1  = @selector(wd_setText:);
        Method systemMethod1 = class_getInstanceMethod([self class], systemSel1);
        Method swizzMethod1 = class_getInstanceMethod([self class], swizzSel1);
        BOOL isAdd1 = class_addMethod(self, systemSel1, method_getImplementation(swizzMethod1), method_getTypeEncoding(swizzMethod1));
        if (isAdd1) {
            class_replaceMethod(self, swizzSel1, method_getImplementation(systemMethod1), method_getTypeEncoding(systemMethod1));
        }else{
            method_exchangeImplementations(systemMethod1, swizzMethod1);
        }
        
        SEL systemSel2 = @selector(setPlaceholder:);
        SEL swizzSel2  = @selector(wd_setPlaceholder:);
        Method systemMethod2 = class_getInstanceMethod([self class], systemSel2);
        Method swizzMethod2 = class_getInstanceMethod([self class], swizzSel2);
        BOOL isAdd2 = class_addMethod(self, systemSel2, method_getImplementation(swizzMethod2), method_getTypeEncoding(swizzMethod2));
        if (isAdd2) {
            class_replaceMethod(self, swizzSel2, method_getImplementation(systemMethod2), method_getTypeEncoding(systemMethod2));
        }else{
            method_exchangeImplementations(systemMethod2, swizzMethod2);
        }
    });
}

- (void)wd_setText:(NSString *)text {
    [self wd_setText:[Statics localized:text]];
}

- (void)wd_setPlaceholder:(NSString *)text {
    [self wd_setPlaceholder:[Statics localized:text]];
}

@end
