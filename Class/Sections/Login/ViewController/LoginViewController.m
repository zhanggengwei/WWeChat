//
//  LoginViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginContentView.h"
#import "LoginViewModel.h"
#import "TabBarViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController {
    LoginContentView * _contentView;
    LoginViewModel   * _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    if (PhoneIs5()||PhoneIs4()) {
        [self addKeyBoardNoti:@selector(showKeyBoard:) HideSEL:@selector(hideKeyBoard:)];
    }
}

- (void)showKeyBoard:(NSNotification *)noti {
    [UIView animateWithDuration:3 animations:^{
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(20);
        }];
    }];
    [_contentView.superview layoutIfNeeded];
}

- (void)hideKeyBoard:(NSNotification *)noti {
    [UIView animateWithDuration:3 animations:^{
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(80);
        }];
    }];
    [_contentView.superview layoutIfNeeded];
}



- (void)createUI {
    // 中间部分
    _contentView = [[LoginContentView alloc]init];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(330));
    }];
    [_contentView.loginBtn addTarget:self action:@selector(deafultLogin) forControlEvents:UIControlEventTouchUpInside];
    
    // 遇到问题按钮
    UIButton * questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [questionBtn addTarget:self action:@selector(toQuestion) forControlEvents:UIControlEventTouchUpInside];
    [questionBtn setTitle:@"登录遇到问题?" forState:UIControlStateNormal];
    [questionBtn setTitleColor:UIColor_3(142, 148, 165) forState:UIControlStateNormal];
    questionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [questionBtn wzx_addLineWithDirection:WZXLineDirectionRight type:WZXLineTypeShort lineWidth:0.5];
    [self.view addSubview:questionBtn];
    [questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.left.equalTo(self.view);
        make.height.equalTo(@(30));
    }];
    
    // 其他登录按钮
    UIButton * otherLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherLoginBtn addTarget:self action:@selector(toOtherLogin) forControlEvents:UIControlEventTouchUpInside];
    [otherLoginBtn setTitle:@"其他登录方式" forState:UIControlStateNormal];
    [otherLoginBtn setTitleColor:UIColor_3(142, 148, 165) forState:UIControlStateNormal];
    otherLoginBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:otherLoginBtn];
    [otherLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.left.equalTo(questionBtn.mas_right);
        make.right.equalTo(self.view);
        make.width.equalTo(questionBtn);
        make.height.equalTo(@(30));
    }];
    
    // 取消按钮
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(30));
    }];

}

- (LoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark - action
- (void)deafultLogin {
    [self.view endEditing:YES];
    [[self viewModel]loginWithPhoneNum:_contentView.phoneNumField.text password:_contentView.passwordField.text success:^(id response, NSInteger code) {
        if (code == 200) {
            the_Application.keyWindow.rootViewController = [TabBarViewController new];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)cancel {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)toQuestion {
    
}

- (void)toOtherLogin {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
