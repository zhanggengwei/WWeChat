//
//  WZXSheetView.m
//  WZXSheet
//
//  Created by wordoor－z on 16/4/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXSheetView.h"

@interface WZXSheetView ()
@property(nonatomic,strong)NSMutableArray * actionArr;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * messageLabel;
@property(nonatomic,strong)UIView * lineView;
@property (nonatomic,assign)BOOL haveSequence;
@end

@implementation WZXSheetView

+ (WZXSheetView *)sheetWithTitle:(NSString *)title message:(NSString *)message {
    return [[WZXSheetView alloc]initWithTitle:title message:message];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    if (self = [super init]) {
        
        [self setUp];
        
        self.backgroundColor = BASE_BACKGROUND_COLOR;
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width,0);
        
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 5;
        
        if (title) {
            self.titleLabel.text = title;
        }
        
        if (message) {
            self.messageLabel.text = title;
        }
    }
    return self;
}

- (void)setUp {
    _titleHeight   = 20;
    _messageHeight = 20;
    _actionHeight  = ScaleHeight(44);
    _lineHeight    = 20;
    
    _duration = 0.2;
}

- (void)setBgColor:(UIColor *)bgColor {
    self.backgroundColor = bgColor;
}

- (void)addAction:(WZXAction *)action {
    [self.actionArr addObject:action];
}

- (void)show {
    if (!_haveSequence) {
        _haveSequence = YES;
        self.actionArr = [NSMutableArray arrayWithArray:[self sequence:self.actionArr]];
        CGFloat Y = _titleLabel.frame.size.height + _messageLabel.frame.size.height + 0.5;
        for (int i = 0;i < self.actionArr.count; i++) {
            WZXAction * action = self.actionArr[i];
            action.frame = CGRectMake(0, Y, self.frame.size.width, _actionHeight - 0.5);
            [self addSubview:action];
            Y += _actionHeight;
            if (i == self.actionArr.count - 2) {
                Y += _lineHeight;
            }
        }
    }
    
    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[WZXSheetView class]]) {
            WZXSheetView * wzxView = (WZXSheetView *)view;
            @weakify(self)
            [wzxView dismiss:^{
                @strongify(self)
                [[UIApplication sharedApplication].keyWindow addSubview:self];
                [UIView animateWithDuration:_duration animations:^{
                    CGRect rect = self.frame;
                    rect.origin.y = [UIScreen mainScreen].bounds.size.height - self.frame.size.height;
                    self.frame = rect;
                }];
                return;
            }];
        }
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:_duration animations:^{
        CGRect rect = self.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height - self.frame.size.height;
        self.frame = rect;
    }];
    
    
}

- (void)dismiss:(void(^)())dismissBlock {
    [UIView animateWithDuration:_duration animations:^{
        CGRect rect = self.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = rect;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        dismissBlock();
    }];
}

- (NSArray<WZXAction *> *)sequence:(NSArray<WZXAction *> *)arr {
    CGRect rect = self.frame;
    rect.size.height = _titleLabel.frame.size.height + _messageLabel.frame.size.height + arr.count * _actionHeight + _lineHeight;
    self.frame = rect;
    
    NSMutableArray * cancelArr = [[NSMutableArray alloc]init];
    NSMutableArray * defaultArr = [[NSMutableArray alloc]init];
    for (WZXAction * action in arr) {
        if (action.type == WSheetTypeDefault) {
            [defaultArr addObject:action];
        } else {
            [cancelArr addObject:action];
        }
    }
    
    for (WZXAction * action in cancelArr) {
        [defaultArr addObject:action];
    }
    
    return defaultArr;
}

- (NSMutableArray *)actionArr {
    if (!_actionArr) {
        _actionArr = [[NSMutableArray alloc]init];
    }
    return _actionArr;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, _titleHeight)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel;
        });
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = ({
            UILabel * messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLabel == nil ? 0 :_titleHeight, self.frame.size.width, _messageHeight)];
            messageLabel.textColor = [UIColor grayColor];
            messageLabel.textAlignment = NSTextAlignmentCenter;
            messageLabel.backgroundColor = [UIColor whiteColor];
            messageLabel;
        });
        [self addSubview:_messageLabel];
    }
    return _messageLabel;
}

@end
