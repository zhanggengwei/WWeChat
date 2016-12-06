//
//  WDViewTool.h
//  PopOn
//
//  Created by WzxJiang on 16/6/25.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXProgressTool : NSObject

+ (void)dismiss;

+ (void)show:(NSString *)status;
+ (void)show:(NSString *)status Interaction:(BOOL)Interaction;

+ (void)showSuccess:(NSString *)status;
+ (void)showSuccess:(NSString *)status Interaction:(BOOL)Interaction;

+ (void)showError:(NSString *)status;
+ (void)showError:(NSString *)status Interaction:(BOOL)Interaction;
@end
