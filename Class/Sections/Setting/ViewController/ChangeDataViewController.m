//
//  ChangeDataViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/2/15.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChangeDataViewController.h"
#import "ChangeDataViewModel.h"

@interface ChangeDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ChangeDataViewController {
    ChangeType      _type;
    BaseTextField * _nickNameField;
    ChangeDataViewModel * _viewModel;
}

- (instancetype)initWithType:(ChangeType)type {
    if (self = [super init]) {
        _type = type;
        self.view.userInteractionEnabled = YES;
        self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        
        switch (type) {
            //更改昵称
            case ChangeNickName: {
                self.title = @"名字";
                [self addLeftBtnWithTitle:@"取消"];
                [self addRightBtnWithTitle:@"保存" Color:UIColor_3(36, 186, 36) Action:@selector(editNickName)];
                [self.rightNavItem setTitleColor:UIColor_4(36, 186, 36, 0.5) forState:UIControlStateDisabled];
                self.navigationItem.rightBarButtonItem.enabled = NO;
                [self createChangeNickNameUI];
            }
                break;
                
            //更改地址
            case ChangeAddress: {
                
            }
                break;
             
            //更改性别
            case ChangeSex: {
                self.title = @"性别";
                [self.view addSubview:self.tableView];
                self.tableView.delegate = self;
                self.tableView.dataSource = self;
                self.tableView.rowHeight = ScaleHeight(45);
            }
                break;
             
            //更改地区
            case ChangePath: {
                
            }
                break;
            
            //更改签名
            case ChangeSign: {
                self.title = @"个性签名";
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 个性签名部分 --

#pragma mark -- 修改性别部分 --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return @[@"男",@"女"].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString * identifier = @"ChangeSexCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = indexPath.row == 0?@"男":@"女";
    cell.tintColor = BASE_COLOR;
    if ([Statics currentUser].sex) {
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[self viewModel] changeSex:indexPath.row == 0 ? 1 : 0  success:^(id response, NSInteger code) {
        [tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- 修改昵称部分 --

- (void)createChangeNickNameUI {
    self.nickNameField.text = [Statics currentUser].nickName;
}

- (BaseTextField *)nickNameField {
    if (!_nickNameField) {
        _nickNameField = [[BaseTextField alloc]initWithFrame:CGRectMake(0, ScaleHeight(15+64), self.view.frame.size.width, ScaleHeight(45))];
        _nickNameField.backgroundColor = [UIColor whiteColor];
        _nickNameField.clearButtonMode = UITextFieldViewModeAlways;
        [_nickNameField becomeFirstResponder];
        [_nickNameField addTarget:self action:@selector(changeNickName:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_nickNameField];
    }
    return _nickNameField;
}

- (void)editNickName {
    [[self viewModel] changeNickName:self.nickNameField.text success:^(id response, NSInteger code) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

- (void)changeNickName:(UITextField *)sender {
    if ([sender.text isEqualToString:[Statics currentUser].nickName]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        if (sender.text.length > 0) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
}

- (ChangeDataViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ChangeDataViewModel alloc]init];
    }
    return _viewModel;
}

@end
