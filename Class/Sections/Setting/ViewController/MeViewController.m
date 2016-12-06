//
//  SettingViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "MeViewController.h"
#import "MeCell.h"

#import "EditMeanViewController.h"

@interface MeViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation MeViewController

NSArray * MeTableTitles() {
    return @[@[@""],
             @[@"相册",
               @"收藏",
               @"钱包",
               @"卡券"],
             @[@"表情"],
             @[@"设置"]];
};

NSArray * MeTableImgs() {
    return @[@[@""],
             @[@"Setting/me_photo",
               @"Setting/me_collect",
               @"Setting/me_money",
               @"Setting/me_collect"],
             @[@"Setting/MoreExpressionShops"],
             @[@"Setting/me_setting"]];
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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MeDefaultCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MeCell" bundle:nil] forCellReuseIdentifier:@"MeCell"];
}

#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * rows = MeTableTitles()[section];
    return rows.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MeTableTitles().count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return ScaleHeight(87);
    } else {
        return ScaleHeight(45);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeDefaultCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

#pragma mark - tableview delegate 
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MeCell * meCell = (MeCell *)cell;
        [meCell.avaterImgView yy_setImageWithURL:[NSURL URLWithString:[Statics currentUser].avaterUrl] placeholder:UIImageForKitBundle(@"default_avater")];
        meCell.nameLabel.text = [Statics currentUser].nickName;
        meCell.wechatIDLabel.text = [NSString stringWithFormat:@"微信号:%@",[Statics currentUser].wxID ? [Statics currentUser].wxID : @""];
    } else {
        cell.textLabel.text = MeTableTitles()[indexPath.section][indexPath.row];
        cell.imageView.image = UIImageForKitBundle(MeTableImgs()[indexPath.section][indexPath.row]);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[EditMeanViewController new] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
