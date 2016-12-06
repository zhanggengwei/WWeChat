//
//  WZXThreadManager.m
//  PopOn
//
//  Created by WzxJiang on 16/6/22.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import "WZXThreadManager.h"

@implementation WZXThreadManager
static WZXThreadManager * manager = nil;

+ (instancetype)threadManager {
    return manager;
}

+ (instancetype)threadManager:(NSInteger)num target:(id)target completeAction:(SEL)completeAction {
    manager = [[WZXThreadManager alloc]initWithNum:num target:target completeAction:completeAction];
    return manager;
}

+ (instancetype)threadManager:(NSInteger)num target:(id)target complete:(void (^)())completeBlock {
    manager = [[WZXThreadManager alloc]initWithNum:num target:target complete:completeBlock];
    return manager;
}

- (instancetype)initWithNum:(NSInteger)num target:(id)target completeAction:(SEL)completeAction {
    if (self = [super init]) {
        _target = target;
        _num = num;
        _completeAction = completeAction;
    }
    return self;
}

- (instancetype)initWithNum:(NSInteger)num target:(id)target complete:(void (^)())completeBlock {
    if (self = [super init]) {
        _target = target;
        _num = num;
        _completeBlock = completeBlock;
    }
    return self;
}

- (NSInteger)reduce {
    _num--;
    if (_num == 0) {
        if (_completeAction) {
            if ([_target respondsToSelector:_completeAction]) {
                IMP imp = [_target methodForSelector:_completeAction];
                void(*func)(id, SEL) = (void *)imp;
                func(_target, _completeAction);
            }
        }
        
        if (_completeBlock) {
            _completeBlock();
        }
    }
    return _num;
}


@end
