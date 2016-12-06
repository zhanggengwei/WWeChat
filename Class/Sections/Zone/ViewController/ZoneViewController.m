//
//  ZoneViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "ZoneViewController.h"
@interface ZoneViewController ()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation ZoneViewController {
    UITableView * _tableView;
}

NSArray * ZoneTableTitles() {
    return @[@[@"朋友圈"],
             @[@"扫一扫",
               @"摇一摇"],
             @[@"附近的人"],
             @[@"购物", @"游戏"]];
};

NSArray * ZoneTableImgs() {
    return @[@[@"Found/found_quan"],
             @[@"Found/found_saoyisao",
               @"Found/found_yao",],
             @[@"Found/found_nearby"],
             @[@"Found/found_shop",
               @"Found/found_game"]];
};

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight  = ScaleHeight(45);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZoneCell"];
}

#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * rows = ZoneTableTitles()[section];
    return rows.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ZoneTableTitles().count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZoneCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = ZoneTableTitles()[indexPath.section][indexPath.row];
    cell.imageView.image = UIImageForKitBundle(ZoneTableImgs()[indexPath.section][indexPath.row]);
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
