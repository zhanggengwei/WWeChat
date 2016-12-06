//
//  WDViewTool.m
//  PopOn
//
//  Created by WzxJiang on 16/6/25.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import "WZXProgressTool.h"
#import "ProgressHUD.h"
@implementation WZXProgressTool

+ (void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD dismiss];
    });
}

+ (void)show:(NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD show:[Statics localized:status]];
    });
}

+ (void)show:(NSString *)status Interaction:(BOOL)Interaction {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD show:[Statics localized:status] Interaction:Interaction];
    });
}

+ (void)showSuccess:(NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD showSuccess:[Statics localized:status]];
    });
    
}

+ (void)showSuccess:(NSString *)status Interaction:(BOOL)Interaction {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD showSuccess:[Statics localized:status] Interaction:Interaction];
    });
}

+ (void)showError:(NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD showError:[Statics localized:status]];
    });
}

+ (void)showError:(NSString *)status Interaction:(BOOL)Interaction {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD showError:[Statics localized:status] Interaction:Interaction];
    });
}

@end
