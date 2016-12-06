//
//  RootViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "StartViewController.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "TabBarViewController.h"
#import "StartViewModel.h"
@interface StartViewController ()

@end

@implementation StartViewController {
    UIImageView    * _backgroundImgView;
    UIButton       * _loginBtn;
    UIButton       * _registerBtn;
    StartViewModel * _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    // 判断是否自动登录
    if ([WZXKeyChain loadToken].length > 0) {
        [[self viewModel] autoLoginWithSuccess:^(id response, NSInteger code) {
            if ([response isEqualToString:[Statics currentUser].objectId]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    the_Application.keyWindow.rootViewController = [TabBarViewController new];
                });
            }
        } failure:^(NSError *error) {
            
        }];
    } else {
        [self createUI];
    }
}

- (void)setUp {
    [self.view addSubview:[self backgroundImgView]];
    _backgroundImgView.image = UIImageForKitBundle(PhoneValue(@"LaunchImage-800-Portrait-736h", @"LaunchImage-800-667h", @"LaunchImage-700-568h", @"LaunchImage"));
}

- (void)createUI {
    [self.view addSubview:[self loginBtn]];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScaleWidth(130)));
        make.height.equalTo(@(ScaleHeight(40)));
        make.left.equalTo(self.view).offset(ScaleWidth(20));
        make.bottom.equalTo(self.view).offset(ScaleHeight(-20));
    }];
    
    [self.view addSubview:[self registerBtn]];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScaleWidth(130)));
        make.height.equalTo(@(ScaleHeight(40)));
        make.right.equalTo(self.view).offset(ScaleWidth(-20));
        make.bottom.equalTo(self.view).offset(ScaleHeight(-20));
    }];

}

- (UIImageView *)backgroundImgView {
    if (!_backgroundImgView) {
        _backgroundImgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    }
    return _backgroundImgView;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:[UIColor whiteColor]];
        [_loginBtn wzx_addCornerRadius:4];
        [_loginBtn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:BASE_COLOR];
        [_registerBtn wzx_addCornerRadius:4];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (StartViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[StartViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark - action
- (void)toLogin {
    [self presentViewController:[LoginViewController new] animated:YES completion:nil];
}

- (void)toRegister {
    [self presentViewController:[RegisterViewController new] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
