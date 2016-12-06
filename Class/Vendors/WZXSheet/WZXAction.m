//
//  WZXAction.m
//  WZXSheet
//
//  Created by wordoor－z on 16/4/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXAction.h"
#import "WZXSheetView.h"
@interface WZXAction()
@property (nonatomic,copy)void (^clickBlock)(WZXAction * action);
@end
@implementation WZXAction

+ (WZXAction *)actionWithTitle:(NSString *)title type:(WSheetType)type handler:(void (^)(WZXAction * action))handler {
    return [[WZXAction alloc]initWithTitle:title type:type handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title type:(WSheetType)type handler:(void (^)(WZXAction * action))handler {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitle:title forState:UIControlStateNormal];
        self.clickBlock = handler;
        self.type = type;
        switch (type) {
            case WSheetTypeCancel:{
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
                break;
            case WSheetTypeDefault:{
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
        
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)btnClick:(UIButton *)sender {
    WZXSheetView * sheetView = (WZXSheetView *)self.superview;
    [sheetView dismiss:^{
        
    }];
    self.clickBlock(self);
}

@end
