//
//  WZXConversation.h
//  WWeChat
//
//  Created by WzxJiang on 16/7/2.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//
#import "BaseModel.h"
#import "UserObject.h"
#import <RongIMLib/RongIMLib.h>

@interface WZXConversation :BaseModel

// 会话类型
@property(nonatomic, assign)RCConversationType conversationType;

// 是否置顶
@property(nonatomic, assign)BOOL isTop;

// 最后一条信息
@property(nonatomic, copy)NSString * lastMessage;

// 最后一条信息的时间
@property(nonatomic, assign)NSTimeInterval lastMessageTime;

// 会话ID
@property(nonatomic, copy)NSString * conversationID;

// 会话所有人
@property(nonatomic, strong)NSArray<UserObject *> * BUsers;

// 会话title
@property(nonatomic, copy)NSString * conversationTitle;

// 会话avaterUrl
@property(nonatomic, copy)NSString * conversationAvaterUrl;

// 未读信息
@property(nonatomic, assign)NSInteger unreadMessageCount;

@property(nonatomic, copy)void(^loadUserComplete)();

- (instancetype)initWithConversation:(RCConversation *)conversation;

- (void)loadUserInfo:(void(^)())loadUserComplete;
@end
