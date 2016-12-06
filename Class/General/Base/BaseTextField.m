//
//  BaseTextField.m
//  Randomer
//
//  Created by 王子轩 on 16/4/9.
//  Copyright © 2016年 com.wzx. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _leftHorizontalSpace = 5;
        self.leftView = ({
            UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _leftHorizontalSpace, self.frame.size.height)];
            leftView.backgroundColor = [UIColor clearColor];
            leftView;
        });
        self.leftViewMode  = UITextFieldViewModeAlways;
        
        if (_rightHorizontalSpace > 0) {
            self.rightView = ({
                UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _rightHorizontalSpace, self.frame.size.height)];
                rightView.backgroundColor = [UIColor clearColor];
                rightView;
            });
            self.rightViewMode = UITextFieldViewModeAlways;
        }
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    return self;
}

- (void)setLeftHorizontalSpace:(CGFloat)leftHorizontalSpace {
    _leftHorizontalSpace = leftHorizontalSpace;
    CGRect leftRect = CGRectMake(0, 0, _leftHorizontalSpace, self.frame.size.height);
    self.leftView.bounds = leftRect;
}

- (void)setRightHorizontalSpace:(CGFloat)rightHorizontalSpace {
    _rightHorizontalSpace = rightHorizontalSpace;
    CGRect rightRect = CGRectMake(0, 0, _rightHorizontalSpace, self.frame.size.height);
    self.rightView.bounds = rightRect;
}
@end
