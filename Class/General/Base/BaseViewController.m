//
//  BaseViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/27.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BaseViewController.h"
#import "YYFPSLabel.h"
@interface BaseViewController ()

@end

@implementation BaseViewController {
    YYFPSLabel *_fpsLabel;
}

CGRect LeftNavBtnRect() {
    return CGRectMake(0,
                      ScaleHeight(32),
                      ScaleWidth(40),
                      ScaleHeight(22));
}

CGRect RightNavBtnRect() {
    return CGRectMake(kScreenWidth - ScaleWidth(40),
                      ScaleHeight(32),
                      ScaleWidth(40),
                      ScaleHeight(22));
}

UIEdgeInsets LeftNavBtnEdge() {
    return UIEdgeInsetsMake(0, ScaleWidth(-10), 0, ScaleWidth(10));
}

UIEdgeInsets RightNavBtnEdge() {
    return UIEdgeInsetsMake(0, ScaleWidth(10), 0, ScaleWidth(-10));
}

UIFont * NavBtnFont(){
    return [UIFont systemFontOfSize:16];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (isDEBUG) {
        _fpsLabel = [[YYFPSLabel alloc]initWithFrame:CGRectMake(10, kScreenHeight - 40, 50, 20)];
        [self.view addSubview:_fpsLabel];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BASE_BACKGROUND_COLOR;
    UIBarButtonItem * backbutton = [[UIBarButtonItem alloc]init];
    backbutton.title = @"返回";
    self.navigationItem.backBarButtonItem = backbutton;
}

- (void)addKeyBoardNoti:(SEL)showSEL HideSEL:(SEL)hideSEL {
    NotificationAdd(self, showSEL,UIKeyboardWillShowNotification, nil);
    NotificationAdd(self, hideSEL,UIKeyboardWillHideNotification, nil);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 添加左按钮(文字)
- (void)addLeftBtnWithTitle:(NSString *)title {
    [self addLeftBtnWithTitle:title Color:nil];
}

- (void)addLeftBtnWithTitle:(NSString *)title Color:(UIColor *)color {
    [self addLeftBtnWithTitle:title Color:color Action:nil];
}

- (void)addLeftBtnWithTitle:(NSString *)title Color:(UIColor *)color Action:(SEL)action {
    [self addLeftBtnWithTitle:title Font:nil Color:color Action:action];
}

- (void)addLeftBtnWithTitle:(NSString *)title Font:(UIFont *)font Color:(UIColor *)color Action:(SEL)action {
    if (!color)  color  = [UIColor whiteColor];
    
    if (!font)   font   = NavBtnFont();
    
    if (!action) action = @selector(_defaultBack:);
    
    self.leftNavItem.titleLabel.font = font;
    self.leftNavItem.titleEdgeInsets = LeftNavBtnEdge();
    [self.leftNavItem setTitle:title forState:UIControlStateNormal];
    [self.leftNavItem setTitleColor:color forState:UIControlStateNormal];
    [self.leftNavItem addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftNavItem];
}

#pragma mark - 添加左按钮(图片)
- (void)addLeftBtn {
    [self addLeftBtnWithImgName:nil Action:nil];
}

- (void)addLeftBtnWithAction:(SEL)action {
    [self addLeftBtnWithImgName:nil Action:action];
}

- (void)addLeftBtnWithImgName:(NSString *)imgName {
    [self addLeftBtnWithImgName:imgName Action:nil];
}

- (void)addLeftBtnWithImgName:(NSString *)imgName Action:(SEL)action {
    if (!action) action = @selector(_defaultBack:);
    
    self.leftNavItem.imageEdgeInsets = LeftNavBtnEdge();
    [self.leftNavItem setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self.leftNavItem addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftNavItem];
}

#pragma mark - 添加右按钮(文字)
- (void)addRightBtnWithTitle:(NSString *)title Action:(SEL)action {
    [self addRightBtnWithTitle:title Color:nil Action:action];
}

- (void)addRightBtnWithTitle:(NSString *)title Color:(UIColor *)color Action:(SEL)action {
    [self addRightBtnWithTitle:title Font:nil Color:color Action:action];
}

- (void)addRightBtnWithTitle:(NSString *)title Font:(UIFont *)font Color:(UIColor *)color Action:(SEL)action {
    if (!color)  color  = BASE_COLOR;
    
    if (!font)   font   = NavBtnFont();
    
    if (!action) action = nil;
    
    self.rightNavItem.titleLabel.font = font;
    self.rightNavItem.titleEdgeInsets = RightNavBtnEdge();
    [self.rightNavItem setTitle:title forState:UIControlStateNormal];
    [self.rightNavItem setTitleColor:color forState:UIControlStateNormal];
    
    if (action) {
        [self.rightNavItem addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightNavItem];
}

#pragma mark - 添加右按钮(图片)
- (void)addRightBtnWithImgName:(NSString *)imgName Action:(SEL)action {
    self.rightNavItem.imageEdgeInsets = RightNavBtnEdge();
    [self.rightNavItem setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    if (action) {
        [self.rightNavItem addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightNavItem];
}

#pragma mark - lazy load

- (UIButton *)leftNavItem {
    if (!_leftNavItem) {
        _leftNavItem = ({
            UIButton * leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            leftNavBtn.frame = LeftNavBtnRect();
            leftNavBtn;
        });
    }
    return _leftNavItem;
}

- (UIButton *)rightNavItem {
    if (!_rightNavItem) {
        _rightNavItem = ({
            UIButton * rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightNavBtn.frame = RightNavBtnRect();
            rightNavBtn;
        });
    }
    return _rightNavItem;
}

#pragma mark - 私有方法
- (void)_defaultBack:(UIButton *)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
