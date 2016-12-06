//
//  LoginContentView.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "LoginContentView.h"

@implementation LoginContentView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"使用手机号登录";
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(36);
        make.height.equalTo(@(20));
        make.centerX.equalTo(self);
    }];
    
    UILabel * countryDesLabel = [[UILabel alloc]init];
    countryDesLabel.text = @"国家/地区";
    countryDesLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:countryDesLabel];
    [countryDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(36);
        make.left.equalTo(self).offset(10);
        make.width.lessThanOrEqualTo(@(80));
        make.height.equalTo(@(ScaleHeight(45)));
    }];
    
    UILabel * countryLabel = [[UILabel alloc]init];
    countryLabel.text = @"中国";
    countryLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:countryLabel];
    [countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(36);
        make.left.equalTo(countryDesLabel.mas_right).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@(ScaleHeight(45)));
    }];
    
    UIView * phoneNumView = [[UIView alloc]init];
    [phoneNumView wzx_addLineWithDirection:WZXLineDirectionTop|WZXLineDirectionBottom type:WZXLineTypeFill lineWidth:1];
    [self addSubview:phoneNumView];
    [phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countryDesLabel.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(10);
        make.height.equalTo(@(ScaleHeight(45)));
    }];
    
    UILabel * numLabel = [[UILabel alloc]init];
    [phoneNumView addSubview:numLabel];
    numLabel.text = @"+86";
    numLabel.font = [UIFont systemFontOfSize:16];
    [numLabel wzx_addLineWithDirection:WZXLineDirectionRight type:WZXLineTypeFill lineWidth:1];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumView);
        make.left.equalTo(phoneNumView);
        make.width.equalTo(@(70));
        make.bottom.equalTo(phoneNumView);
    }];
    
    [phoneNumView addSubview:self.phoneNumField];
    [_phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumView);
        make.left.equalTo(numLabel.mas_right);
        make.right.equalTo(phoneNumView);
        make.bottom.equalTo(phoneNumView);
    }];
    
    
    UIView * passwordView = [[UIView alloc]init];
    [passwordView wzx_addLineWithDirection:WZXLineDirectionBottom type:WZXLineTypeFill lineWidth:1];
    [self addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumView.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(10);
        make.height.equalTo(@(ScaleHeight(45)));
    }];
    
    UILabel * passDesLabel = [[UILabel alloc]init];
    passDesLabel.text = @"密码";
    passDesLabel.font = [UIFont systemFontOfSize:16];
    [passwordView addSubview:passDesLabel];
    [passDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordView);
        make.left.equalTo(passwordView);
        make.width.equalTo(@(70));
        make.bottom.equalTo(passwordView);
    }];
    
    [passwordView addSubview:self.passwordField];
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordView);
        make.left.equalTo(passDesLabel.mas_right);
        make.right.equalTo(passwordView);
        make.bottom.equalTo(passwordView);
    }];
    
    [self addSubview:self.loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordView.mas_bottom).offset(28);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(@(ScaleHeight(40)));
    }];
    
    UIButton * smsCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:smsCodeBtn];
    [smsCodeBtn setTitle:@"通过短信验证码登录" forState:UIControlStateNormal];
    [smsCodeBtn setTitleColor:UIColor_3(142, 148, 165) forState:UIControlStateNormal];
    smsCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [smsCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(22);
        make.centerX.equalTo(self);
        make.height.equalTo(@(ScaleHeight(28)));
    }];
}

- (void)_judgement:(UITextField *)sender {
    if (_phoneNumField.text.length == 11 &&
        _passwordField.text.length >= 6) {
        _loginBtn.enabled = YES;
    } else {
        _loginBtn.enabled = NO;
    }
}

#pragma mark - lazy load
- (UITextField *)phoneNumField {
    if (!_phoneNumField) {
        _phoneNumField = [[UITextField alloc]init];
        _phoneNumField.placeholder = @"请填写手机号码";
        [_phoneNumField addTarget:self action:@selector(_judgement:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneNumField;
}

- (UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [[UITextField alloc]init];
        _passwordField.placeholder = @"请填写密码";
        [_passwordField addTarget:self action:@selector(_judgement:) forControlEvents:UIControlEventEditingChanged];
        _passwordField.secureTextEntry = YES;
    }
    return _passwordField;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loginBtn setBackgroundImage:[UIImage yy_imageWithColor:BASE_COLOR] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage yy_imageWithColor:[UIColor colorWithRed:104/255.0 green:187/255.0 blue:30/255.0 alpha:0.5]] forState:UIControlStateDisabled];
        _loginBtn.enabled = NO;
    }
    return _loginBtn;
}

@end
