//
//  BaseView.m
//  PopOn
//
//  Created by WzxJiang on 16/6/16.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
