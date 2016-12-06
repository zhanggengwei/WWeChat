//
//  EditMeanViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/29.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "EditMeanViewController.h"
#import "ChangeDataViewController.h"
#import "ChangeAvaterViewController.h"
@interface EditMeanViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation EditMeanViewController
const CGFloat EditMeanSection1Tag = 10000;
const CGFloat EditMeanSection2Tag = 20000;
NSArray * EditMeanTableTitles() {
    return @[@[@"头像",
               @"名字",
               @"微信号",
               @"我的二维码",
               @"我的地址"],
             @[@"性别",
               @"地区",
               @"个性签名"]];
};

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * rows = EditMeanTableTitles()[section];
    return rows.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return EditMeanTableTitles().count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return ScaleHeight(80);
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        CGFloat signHeight = [[Statics currentUser].sign wzx_stringHeightWithFont:[UIFont systemFontOfSize:13] width:ScaleWidth(145)] + 20;
        return signHeight > ScaleHeight(45) ? signHeight : ScaleHeight(45);
    } else {
        return  ScaleHeight(45);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"EditMeanCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = EditMeanTableTitles()[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIImageView * avaterImgView = [cell.contentView viewWithTag:EditMeanSection1Tag + indexPath.row];
            if (!avaterImgView) {
                avaterImgView = [[UIImageView alloc]init];
                avaterImgView.tag = EditMeanSection1Tag + indexPath.row;
                [cell.contentView addSubview:avaterImgView];
                [avaterImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell.contentView);
                    make.width.equalTo(@(65));
                    make.height.equalTo(@(65));
                    make.right.equalTo(cell.contentView).offset(-10);
                }];
            }
            [avaterImgView yy_setImageWithURL:[NSURL URLWithString:[Statics currentUser].avaterUrl] placeholder:UIImageForKitBundle(@"default_avater")];
            
        } else if (indexPath.row == 1) {
            cell.detailTextLabel.text = [Statics currentUser].nickName;
        } else if (indexPath.row == 2) {
            NSString * wxID = [Statics currentUser].wxID;
            if (wxID) {
                cell.detailTextLabel.text = wxID;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = [Statics currentUser].sex ? @"男" : @"女";
        } else if (indexPath.row == 1) {
            // 地区
        } else if (indexPath.row == 2) {
            // 个性签名
            UILabel * signLabel = [cell viewWithTag:EditMeanSection2Tag + indexPath.row];
            if (!signLabel) {
                signLabel = [[UILabel alloc]init];
                [cell.contentView addSubview:signLabel];
                signLabel.numberOfLines = 0;
                signLabel.textColor = [UIColor grayColor];
                signLabel.font = [UIFont systemFontOfSize:13];
                signLabel.tag = EditMeanSection2Tag + indexPath.row;
                [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell);
                    make.width.equalTo(@(ScaleWidth(145)));
                    make.right.equalTo(cell).offset(-25);
                    make.height.equalTo(@(40));
                }];
            }
            signLabel.text = [Statics currentUser].sign;
            [signLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([signLabel.text wzx_stringHeightWithFont:[UIFont systemFontOfSize:13] width:ScaleWidth(145)]));
            }];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //修改头像
            [self.navigationController pushViewController:[ChangeAvaterViewController new] animated:YES];
        } else if(indexPath.row == 1) {
            //修改用户名
            [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangeNickName] animated:YES];
        } else if(indexPath.row == 2) {
            //微信号（不能修改）
        } else if(indexPath.row == 3) {
            //二维码
        } else if(indexPath.row == 4) {
            //地址
            [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangeAddress] animated:YES];
        }
    } else {
        if (indexPath.row == 0) {
            //性别
            [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangeSex] animated:YES];
        } else if(indexPath.row == 1) {
            //地区
            [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangePath] animated:YES];
        } else if(indexPath.row == 2) {
            //个性签名
            [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangeSign] animated:YES];
        }
    }
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
