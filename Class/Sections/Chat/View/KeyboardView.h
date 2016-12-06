//
//  KeyboardView.h
//  WWeChat
//
//  Created by wordoor－z on 16/3/4.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KeyboardToolView;
@interface KeyboardView : UIView

@property(nonatomic, assign)CGFloat currentTextViewHeight;

@property(nonatomic, copy)void (^showKeyBoardBlock)(NSInteger antype,CGFloat duration,CGFloat kbHeight);
@property(nonatomic, copy)void (^hideKeyBoardBlock)(NSInteger antype,CGFloat duration,CGFloat kbHeight);
@property(nonatomic, copy)void (^sentMessageBlock)(NSString * message);

@property(nonatomic, strong)KeyboardToolView * toolView;

@end

@interface KeyboardToolView : UIView

//语音按钮
@property(nonatomic,strong)UIButton * soundBtn;

//输入框
@property(nonatomic,strong)UITextView * messageTextView;

//表情按钮
@property(nonatomic,strong)UIButton *  faceBtn;

//更多按钮
@property(nonatomic,strong)UIButton *  moreBtn;

@end
