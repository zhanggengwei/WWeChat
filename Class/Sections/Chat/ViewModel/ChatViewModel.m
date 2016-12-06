//
//  ChatViewModel.m
//  WWeChat
//
//  Created by WzxJiang on 16/7/2.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "ChatViewModel.h"
#import "WZXThreadManager.h"
#import "AddressBookViewModel.h"

@implementation ChatViewModel

#pragma mark - 获取未读信息

- (NSInteger)getTotalUnreadCount {
   return [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
}

- (NSInteger)getUnreadCount:(RCConversationType)conversationType targetId:(NSString *)targetId {
    return [[RCIMClient sharedRCIMClient] getUnreadCount:conversationType targetId:targetId];
}

- (BOOL)clearMessagesUnreadStatus:(RCConversationType)conversationType targetId:(NSString *)targetId {
    return [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:conversationType targetId:targetId];
}

#pragma mark - 获取会话
- (NSArray<WZXConversation *> *)getConversationList {
    NSArray *conversationList = [[RCIMClient sharedRCIMClient]
                                 getConversationList:@[@(ConversationType_PRIVATE),
                                       @(ConversationType_DISCUSSION),
                                       @(ConversationType_GROUP),
                                       @(ConversationType_SYSTEM),
                                       @(ConversationType_APPSERVICE),
                                       @(ConversationType_PUBLICSERVICE)]];
    
    NSMutableArray * conversationArr = [[NSMutableArray alloc]init];
    
    if(conversationList.count > 0) {
        for (RCConversation *conversation in conversationList) {
            NSLog(@"会话类型：%lu，目标会话ID：%@", (unsigned long)conversation.conversationType, conversation.targetId);
            [conversationArr addObject:[[WZXConversation alloc]initWithConversation:conversation]];
        }
    }
    return conversationArr;
}


- (void)getConversationListWithConversationIDs:(NSArray *)conversationIds success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSDictionary * dic = @{
                           @"conversationID":@{@"$in":conversationIds}
                           };
    NSString * queryStr = [dic yy_modelToJSONString];
    NSString * queryUTF8Str = [queryStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager GET:[NSString stringWithFormat:@"classes/MyConversation?where=%@",queryUTF8Str]  version:V1_1 parameters:nil success:^(id response, NSInteger code) {
        NSMutableArray * conversations = [NSMutableArray array];
        for (NSDictionary * result in response[@"results"]) {
            WZXConversation * conversation = [WZXConversation yy_modelWithDictionary:result];
            [conversations addObject:conversation];
        }
        success(conversations, code);
    } failure:failure];
}

- (void)getConversationListWithConversationID:(NSString *)conversationID success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self getConversationListWithConversationIDs:@[conversationID] success:success failure:failure];
}

- (NSArray<MessageModel *> *)getLatestMessages:(RCConversationType)conversationType targetId:(NSString *)targetId count:(int)count {
    NSArray<RCMessage *> * messages = [[RCIMClient sharedRCIMClient] getLatestMessages:conversationType targetId:targetId count:count];
    NSMutableArray * messageModels = [NSMutableArray array];
    [messages enumerateObjectsUsingBlock:^(RCMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MessageModel * messageModel = [[MessageModel alloc]initWithMessage:obj];
        [messageModels addObject:messageModel];
    }];
# warning 未处理时间
//    NSMutableArray * sortedMessages = [NSMutableArray array];
//    NSTimeInterval time = messages.firstObject.sentTime;
    return messageModels;
}

#pragma mark - 发送信息
- (RCMessage *)sendMessage:(RCConversationType)conversationType
                  targetId:(NSString *)targetId
                   content:(RCMessageContent *)content
               pushContent:(NSString *)pushContent
                  pushData:(NSString *)pushData
                   success:(void (^)(long messageId))successBlock
                     error:(void (^)(RCErrorCode nErrorCode, long messageId))errorBlock {
    return
    [[RCIMClient sharedRCIMClient] sendMessage:conversationType targetId:targetId content:content pushContent:pushContent pushData:pushData success:successBlock error:errorBlock];
}

- (RCMessage *)sendMessage:(RCConversationType)conversationType targetId:(NSString *)targetId content:(RCMessageContent *)content success:(void (^)(long))successBlock error:(void (^)(RCErrorCode, long))errorBlock {
    return [self sendMessage:conversationType targetId:targetId content:content pushContent:nil pushData:nil success:successBlock error:errorBlock];
}

- (RCMessage *)sendTextMessage:(RCConversationType)conversationType
                          targetId:(NSString *)targetId
                             title:(NSString *)title
                       pushContent:(NSString *)pushContent
                          pushData:(NSString *)pushData
                           success:(void (^)(long messageId))successBlock
                             error:(void (^)(RCErrorCode nErrorCode, long messageId))errorBlock {
    RCTextMessage * textMessage = [RCTextMessage messageWithContent:title];
    return
    [[RCIMClient sharedRCIMClient] sendMessage:conversationType targetId:targetId content:textMessage pushContent:pushContent pushData:pushData success:successBlock error:errorBlock];
}

- (RCMessage *)sendTextMessage:(RCConversationType)conversationType
                      targetId:(NSString *)targetId
                         title:(NSString *)title
                       success:(void (^)(long messageId))successBlock
                         error:(void (^)(RCErrorCode nErrorCode, long messageId))errorBlock {
    return [self sendTextMessage:conversationType targetId:targetId title:title pushContent:nil pushData:nil success:successBlock error:errorBlock];
}

- (RCMessage *)sendImageMessage:(RCConversationType)conversationType
                       targetId:(NSString *)targetId
                          image:(UIImage *)image
                    pushContent:(NSString *)pushContent
                       pushData:(NSString *)pushData
                       progress:(void (^)(int progress, long messageId))progressBlock
                        success:(void (^)(long messageId))successBlock
                          error:(void (^)(RCErrorCode errorCode, long messageId))errorBlock {
    RCImageMessage * imageMessage = [RCImageMessage messageWithImage:image];
    imageMessage.imageUrl = [NSString stringWithFormat:@"%@_%@_%f.png",[Statics currentUser].objectId,targetId,[Statics getTimestamp]];
    return
    [[RCIMClient sharedRCIMClient] sendImageMessage:conversationType targetId:targetId content:imageMessage pushContent:pushContent pushData:pushData progress:progressBlock success:successBlock error:errorBlock];
}

- (RCMessage *)sendImageMessage:(RCConversationType)conversationType
                       targetId:(NSString *)targetId
                          image:(UIImage *)image
                       progress:(void (^)(int progress, long messageId))progressBlock
                        success:(void (^)(long messageId))successBlock
                          error:(void (^)(RCErrorCode errorCode, long messageId))errorBlock {
    return
    [self sendImageMessage:conversationType targetId:targetId image:image pushContent:nil pushData:nil progress:progressBlock success:successBlock error:errorBlock];
}

- (void)sendsendTypingStatus:(RCConversationType)conversationType
                    targetId:(NSString *)targetId
                       title:(NSString *)title {
    [[RCIMClient sharedRCIMClient] sendTypingStatus:conversationType targetId:targetId contentType:title];
}


#pragma mark - 设置是否置顶
- (BOOL)setConversationToTop:(RCConversationType)conversationType
                    targetId:(NSString *)targetId
                       isTop:(BOOL)isTop {
    return [[RCIMClient sharedRCIMClient] setConversationToTop:conversationType targetId:targetId isTop:isTop];
}

@end
