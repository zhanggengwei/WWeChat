//
//  WZXConversation.m
//  WWeChat
//
//  Created by WzxJiang on 16/7/2.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "WZXConversation.h"
#import "AddressBookViewModel.h"

@implementation WZXConversation

- (instancetype)initWithConversation:(RCConversation *)conversation {
    self = [super init];
    if (self) {
        self.conversationID = conversation.targetId;
        self.conversationType = conversation.conversationType;
        self.conversationTitle = conversation.conversationTitle;
        self.isTop = conversation.isTop;
        
        if ([conversation.lastestMessage isMemberOfClass:[RCTextMessage class]]) {
            RCTextMessage * textMessage = (RCTextMessage *)conversation.lastestMessage;
            self.lastMessage = textMessage.content;
        } else if ([conversation.lastestMessage isMemberOfClass:[RCImageMessage class]]){
            self.lastMessage = @"图片";
        } else {
            self.lastMessage = @"xxx";
        }
        
        self.lastMessageTime = conversation.sentTime;
        self.unreadMessageCount = conversation.unreadMessageCount;
    }
    return self;
}

- (void)loadUserInfo:(void (^)())loadUserComplete {
    _loadUserComplete = loadUserComplete;
    NSMutableArray * BUsers = [NSMutableArray array];
    [[AddressBookViewModel new] searchFriend:@[self.conversationID] success:^(id response, NSInteger code) {
        NSArray * results = response[@"results"];
        if (results.firstObject) {
            UserObject * user = [[UserObject alloc]init];
            [user setValuesForKeysWithDictionary:results.firstObject];
            [BUsers addObject:user];
            _BUsers = BUsers;
            _conversationTitle     = user.nickName;
            _conversationAvaterUrl = user.avaterUrl;
            if (_loadUserComplete) {
                _loadUserComplete();
            }
        }
    } failure:^(NSError *error) {
            
    }];
}

- (NSString *)description {
    return [self yy_modelDescription];
}

@end
