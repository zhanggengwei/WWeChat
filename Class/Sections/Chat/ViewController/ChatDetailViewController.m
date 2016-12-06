//
//  ChatDetailViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/3.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatDetailViewController.h"
#import "PrivateChatCell.h"
#import "KeyboardView.h"

@interface ChatDetailViewController()<UITableViewDataSource,UITableViewDelegate>
@end

CGFloat const defaultKeyViewHeight = 55;

@implementation ChatDetailViewController {
    NSArray * _dataArr;
    NSInteger  _num;
    UITableView * _tableView;
    KeyboardView * _keyboardView;
    CGFloat _currentKeyboardViewHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _num = 20;
    self.title = _conversationModel.conversationTitle;
    [self createUI];
}

- (void)preData {
    _dataArr = [self.chatViewModel getLatestMessages:_conversationModel.conversationType targetId:_conversationModel.conversationID count:20];
    [[self tableView] reloadData];
}

- (void)createUI {
    [self.view addSubview:[self tableView]];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    [self.view addSubview:[self keyboardView]];
    [_keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@(defaultKeyViewHeight));
    }];
    _currentKeyboardViewHeight = defaultKeyViewHeight;
}

- (void)hideKeyboard {
    [_keyboardView endEditing:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tableView registerClass:[PrivateChatCell class] forCellReuseIdentifier:@"PrivateCell"];
            [tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
            tableView;
        });
    }
    return _tableView;
}

- (KeyboardView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = [[KeyboardView alloc]init];
        _keyboardView.currentTextViewHeight = defaultKeyViewHeight;
        @weakify(self)
        [_keyboardView setShowKeyBoardBlock:^(NSInteger animationType, CGFloat duration, CGFloat kbHeight) {
            @strongify(self)
            [UIView animateWithDuration:duration delay:0 options:animationType animations:^{
                [self->_keyboardView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(ABS(_currentKeyboardViewHeight + kbHeight)));
                }];
            } completion:^(BOOL finished) {
                self->_keyboardView.currentTextViewHeight += kbHeight;
            }];
            [self->_keyboardView layoutIfNeeded];
        }];
        
        [_keyboardView setHideKeyBoardBlock:^(NSInteger animationType, CGFloat duration, CGFloat kbHeight) {
            @strongify(self)
            [UIView animateWithDuration:duration delay:0 options:animationType animations:^{
                [self->_keyboardView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(ABS(_currentKeyboardViewHeight - kbHeight)));
                }];
            } completion:^(BOOL finished) {
                self->_keyboardView.currentTextViewHeight -= kbHeight;
            }];
            [self->_keyboardView layoutIfNeeded];
        }];
        [_keyboardView setSentMessageBlock:^(NSString * title) {
            
        }];
    }
    return _keyboardView;
}

#pragma mark -- tableView --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivateChatCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PrivateCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivateChatCell * privateChatCell = (PrivateChatCell *)cell;
    [privateChatCell setModel:_dataArr[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 60)/2.0, 10, 60, 20)];
    
    NSDictionary * dic = _dataArr[section];
    
    timeLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    timeLabel.layer.cornerRadius = 5;
    timeLabel.clipsToBounds = YES;
    
    double times = [dic[@"timestamp"]doubleValue];
    
//    timeLabel.text = [[WZXTimeStampToTimeTool tool]compareWithTimeDic:[[WZXTimeStampToTimeTool tool]timeStampToTimeToolWithTimeStamp:times andScale:3]];
    
    timeLabel.font = [UIFont systemFontOfSize:12];
    
    timeLabel.textColor = [UIColor whiteColor];
    
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [headerView addSubview:timeLabel];
    
    return nil;
}

/** tableview滑到底部 */
- (void)refresh {
    NSDictionary * dic = _dataArr.lastObject;
    NSArray * arr = dic[@"messages"];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:arr.count - 1 inSection:_dataArr.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
