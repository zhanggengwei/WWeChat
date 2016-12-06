//
//  AddressBookViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "AddressBookViewController.h"
#import "AddressBookViewModel.h"
#import "AddressBookCell.h"
@interface AddressBookViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate>

@end

@implementation AddressBookViewController {
    UISearchController * _searchController;
    AddressBookViewModel * _viewModel;
    NSArray * _dataArr;
}

NSArray * AddressBookTableTitles() {
    return @[@"新的朋友",
             @"群聊",
             @"标签",
             @"公众号"];
};

NSArray * AddressBookTableImgs() {
    return @[@"AddressBook/plugins_FriendNotify",
             @"AddressBook/add_friend_icon_addgroup",
             @"AddressBook/Contact_icon_ContactTag",
             @"AddressBook/add_friend_icon_offical"];
};

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self getData];
}

- (void)getData {
    @weakify(self)
    [[self viewModel] searchFriend:[[Statics currentUser] friendObjectIds] success:^(id response, NSInteger code) {
        @strongify(self)
        NSMutableArray * users = [NSMutableArray array];
        for (NSDictionary * result in response[@"results"]) {
            UserObject * user = [[UserObject alloc]init];
            [user setValuesForKeysWithDictionary:result];
            [users addObject:user];
        }
        _dataArr = [[self viewModel] addressBookDivideGroup:users];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = ScaleHeight(45);
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressBookCell" bundle:nil] forCellReuseIdentifier:@"AddressBookCell"];
}

#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return AddressBookTableTitles().count;
    } else {
        NSDictionary * nameDic = _dataArr[section - 1];
        NSArray * names = nameDic[@"names"];
        return names.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return ScaleHeight(44);
    } else {
        return ScaleHeight(20);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    tableView.sectionIndexColor = [UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    [arr addObject:UITableViewIndexSearch];
    
    for (NSDictionary * dic in _dataArr) {
        [arr addObject:dic[@"sectionName"]];
    }
    return arr;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScaleWidth(30), ScaleHeight(20))];
        NSDictionary * dic = _dataArr[section - 1];
        label.text = [NSString stringWithFormat:@"   %@",dic[@"sectionName"]];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:146/255.0 alpha:1];
        return label;
    } else {
        return self.searchController.searchBar;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString * identifier = @"AddressBookDefaultCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    } else {
        AddressBookCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressBookCell"];
        return cell;
    }
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        cell.imageView.image = UIImageForKitBundle(AddressBookTableImgs()[indexPath.row]);
        cell.textLabel.text = AddressBookTableTitles()[indexPath.row];
    } else {
        AddressBookCell * addressBookCell = (AddressBookCell *)cell;
        NSDictionary * nameDic = _dataArr[indexPath.section - 1];
        NSArray * users        = nameDic[@"names"];
        UserObject * user      = users[indexPath.row];
        [addressBookCell setModel:user];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        //self.searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        [_searchController.searchBar sizeToFit];
        //self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        _searchController.delegate = self;
        _searchController.searchBar.backgroundImage = [[UIImage alloc]init];
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.tintColor = BASE_COLOR;
    }
    return _searchController;
}

- (AddressBookViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AddressBookViewModel alloc]init];
    }
    return _viewModel;
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
