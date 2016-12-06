//
//  WZXThreadManager.h
//  PopOn
//
//  Created by WzxJiang on 16/6/22.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXThreadManager : NSObject

@property(nonatomic,assign)NSInteger num;
@property(nonatomic,strong)id target;
@property(nonatomic,assign)SEL completeAction;
@property(nonatomic,copy)void(^completeBlock)();

+ (instancetype)threadManager;

+ (instancetype)threadManager:(NSInteger)num target:(id)target completeAction:(SEL)completeAction;
+ (instancetype)threadManager:(NSInteger)num target:(id)target complete:(void(^)())completeBlock;

- (NSInteger)reduce;
@end
