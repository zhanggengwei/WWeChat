//
//  WZXSheetView.h
//  WZXSheet
//
//  Created by wordoor－z on 16/4/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXAction.h"
@interface WZXSheetView : UIView

/**
 *  按钮高度，默认为60
 */
@property(nonatomic,assign)CGFloat actionHeight;

/**
 *  标题高度，默认为20
 */
@property(nonatomic,assign)CGFloat titleHeight;

/**
 *  信息高度，默认为20
 */
@property(nonatomic,assign)CGFloat messageHeight;

/**
 *  分割线高度，默认为20
 */
@property(nonatomic,assign)CGFloat lineHeight;

/**
 *  背景颜色
 */
@property(nonatomic,strong)UIColor * bgColor;

/**
 *  出现消失动画时间，默认为0.5
 */
@property(nonatomic,assign)CGFloat duration;
/**
 *  初始化方法
 *
 *  @param title   标题，可为nil
 *  @param message 信息，可为nil
 *
 *  @return WZXSheetView对象
 */
+ (WZXSheetView *)sheetWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  添加按钮
 *
 *  @param action 传入一个WZXAction对象
 */
- (void)addAction:(WZXAction *)action;

/**
 *  出现
 */
- (void)show;

/**
 *  消失
 */
- (void)dismiss:(void(^)())dismissBlock;

@end
