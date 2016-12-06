//
//  BaseChatViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/7/1.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BaseChatViewController.h"
#import <RongIMLib/RongIMLib.h>
@interface BaseChatViewController () <RCIMClientReceiveMessageDelegate>

@end

@implementation BaseChatViewController

- (void)viewWillAppear:(BOOL)animated {
    if ([self.navigationController.viewControllers.firstObject isEqual:self]) {
        self.tabBarController.tabBar.hidden = NO;
    } else {
        self.tabBarController.tabBar.hidden = YES;
    }

    [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)preData {}

#pragma mark - delegate
- (void)onTypingStatusChanged:(RCConversationType)conversationType targetId:(NSString *)targetId status:(NSArray *)userTypingStatusList {
    
}

- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object {
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        RCTextMessage *testMessage = (RCTextMessage *)message.content;
        NSLog(@"消息内容：%@", testMessage.content);
    } else if ([message.content isMemberOfClass:[RCImageMessage class]]) {
        NSLog(@"消息内容：图片");
    }
    //没有未接受的消息时刷新
    if (nLeft == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self preData];
        });
    }
    NSLog(@"还剩余的未接收的消息数：%d", nLeft);
}



#pragma mark - lazy load

- (ChatViewModel *)chatViewModel {
    if (!_chatViewModel) {
        _chatViewModel = [[ChatViewModel alloc]init];
    }
    return _chatViewModel;
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
