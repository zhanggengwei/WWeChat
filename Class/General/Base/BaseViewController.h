//
//  BaseViewController.h
//  WWeChat
//
//  Created by WzxJiang on 16/6/27.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic, strong)UIButton * leftNavItem;
@property(nonatomic, strong)UIButton * rightNavItem;


- (void)addKeyBoardNoti:(SEL)showSEL HideSEL:(SEL)hideSEL;

#pragma mark - 添加左按钮(文字)
- (void)addLeftBtnWithTitle:(NSString *)title;
- (void)addLeftBtnWithTitle:(NSString *)title
                      Color:(UIColor *)color;
- (void)addLeftBtnWithTitle:(NSString *)title
                      Color:(UIColor *)color
                     Action:(SEL)action;
- (void)addLeftBtnWithTitle:(NSString *)title
                       Font:(UIFont *)font
                      Color:(UIColor *)color
                     Action:(SEL)action;
#pragma mark - 添加左按钮(图片)
- (void)addLeftBtn;
- (void)addLeftBtnWithAction:(SEL)action;
- (void)addLeftBtnWithImgName:(NSString *)imgName;
- (void)addLeftBtnWithImgName:(NSString *)imgName
                       Action:(SEL)action;
#pragma mark - 添加右按钮(文字)
- (void)addRightBtnWithTitle:(NSString *)title
                      Action:(SEL)action;
- (void)addRightBtnWithTitle:(NSString *)title
                       Color:(UIColor *)color
                      Action:(SEL)action;
- (void)addRightBtnWithTitle:(NSString *)title
                        Font:(UIFont *)font
                       Color:(UIColor *)color
                      Action:(SEL)action;

#pragma mark - 添加右按钮(图片)
- (void)addRightBtnWithImgName:(NSString *)imgName
                        Action:(SEL)action;
@end
