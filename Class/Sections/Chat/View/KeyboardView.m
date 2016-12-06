//
//  KeyboardView.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/4.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "KeyboardView.h"
@interface KeyboardView()<UITextViewDelegate>

@end
@implementation KeyboardView
CGFloat defaultHeight = 55;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = UIColor_3(244, 244, 246);
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        
        [self addEnterNofi];
        [self addKeyNofi];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:[self toolView]];
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(55));
    }];
}

- (void)addEnterNofi {
    //进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(enterForeground)
                                                 name:@"EnterForeground" object:nil];
    //进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(enterBackground)
                                                 name:@"EnterBackground" object:nil];
}

- (void)addKeyNofi {
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)enterForeground {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addKeyNofi];
    });
}

- (void)enterBackground {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    NSInteger animationType = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    if (_showKeyBoardBlock) {
        _showKeyBoardBlock(animationType, duration, kbSize.height);
    }
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    NSInteger animationType = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]integerValue];
    
    if (_hideKeyBoardBlock) {
        _hideKeyBoardBlock(animationType, duration, kbSize.height);
    }
}

- (KeyboardToolView *)toolView {
    if (!_toolView) {
        _toolView = [[KeyboardToolView alloc]init];
        _toolView.messageTextView.delegate = self;
    }
    return _toolView;
}

#pragma mark -textView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if (_sentMessageBlock) {
            _sentMessageBlock(textView.text);
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger num = [textView.text wzx_stringSizeWithFont:[UIFont systemFontOfSize:15]].width / (kScreenWidth - 3*28 -40);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_currentTextViewHeight + num*20));
    }];
    
    [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(55 + num*20));
    }];
   
    [self layoutIfNeeded];
}

@end

@implementation KeyboardToolView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.soundBtn];
    [_soundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-10);
        make.height.equalTo(@(28));
        make.width.equalTo(@(28));
    }];
    
    [self addSubview:self.messageTextView];
    [_messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_soundBtn.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-8);
        make.top.equalTo(self).offset(8);
    }];
    
    [self addSubview:self.faceBtn];
    [_faceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_messageTextView.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-8);
        make.height.equalTo(@(30));
        make.width.equalTo(@(30));
    }];
    
    [self addSubview:self.moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_faceBtn.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.right.equalTo(self).offset(-5);
        make.height.equalTo(@(28));
        make.width.equalTo(@(28));
    }];
}

- (UIButton *)soundBtn {
    if (!_soundBtn) {
        _soundBtn = ({
            UIButton * soundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [soundBtn setBackgroundImage:UIImageForKitBundle(@"chat_setmode_voice_btn_normal") forState:UIControlStateNormal];
            soundBtn;
        });
    }
    return _soundBtn;
}

- (UITextView *)messageTextView {
    if (!_messageTextView) {
        _messageTextView = ({
            UITextView * messageTextView = [[UITextView alloc]init];
            messageTextView.layer.cornerRadius = 4;
            messageTextView.clipsToBounds = YES;
            messageTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
            messageTextView.backgroundColor = [UIColor whiteColor];
            messageTextView.layer.borderWidth = 1;
            messageTextView.returnKeyType = UIReturnKeySend;
            messageTextView.enablesReturnKeyAutomatically = YES;
            messageTextView.font = [UIFont systemFontOfSize:16];
            messageTextView;
        });
    }
    return _messageTextView;
}

- (UIButton *)faceBtn {
    if (!_faceBtn) {
        _faceBtn = ({
            UIButton * faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [faceBtn setBackgroundImage:UIImageForKitBundle(@"Album_ToolViewEmotion") forState:UIControlStateNormal];
            [faceBtn setBackgroundImage:UIImageForKitBundle(@"Album_ToolViewEmotionHL") forState:UIControlStateHighlighted];
            faceBtn;
        });
    }
    return _faceBtn;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = ({
            UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [moreBtn setBackgroundImage:UIImageForKitBundle(@"chat_setmode_add_btn_normal") forState:UIControlStateNormal];
            moreBtn;
        });
    }
    return _moreBtn;
}

@end
