//
//  ChatViewModel.h
//  WWeChat
//
//  Created by WzxJiang on 16/7/2.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BaseViewModel.h"
#import <RongIMLib/RongIMLib.h>
#import "WZXConversation.h"
#import "MessageModel.h"

@interface ChatViewModel : BaseViewModel

/** 所有未读信息总数 */
- (NSInteger)getTotalUnreadCount;

/** 获取某个会话的未读信息数 */
- (NSInteger)getUnreadCount:(RCConversationType)conversationType
                   targetId:(NSString *)targetId;

/** 清除某个会话中的未读消息数 */
- (BOOL)clearMessagesUnreadStatus:(RCConversationType)conversationType
                         targetId:(NSString *)targetId;

/** 获取所有会话 */
- (NSArray<WZXConversation *> *)getConversationList;

/** 获取某个会话 */
- (void)getConversationListWithConversationID:(NSString *)conversationID
                                      success:(SuccessBlock)success
                                      failure:(FailureBlock)failure;

/** 发送信息 */
- (RCMessage *)sendMessage:(RCConversationType)conversationType
                  targetId:(NSString *)targetId
                   content:(RCMessageContent *)content
               pushContent:(NSString *)pushContent
                  pushData:(NSString *)pushData
                   success:(void (^)(long messageId))successBlock
                     error:(void (^)(RCErrorCode nErrorCode, long messageId))errorBlock;

/** 发送信息 默认推送 */
- (RCMessage *)sendMessage:(RCConversationType)conversationType
                  targetId:(NSString *)targetId
                   content:(RCMessageContent *)content
                   success:(void (^)(long messageId))successBlock
                     error:(void (^)(RCErrorCode nErrorCode, long messageId))errorBlock;

/** 发送文本信息 */
- (RCMessage *)sendTextMessage:(RCConversationType)conversationType
                      targetId:(NSString *)targetId
                         title:(NSString *)title
                   pushContent:(NSString *)pushContent
                      pushData:(NSString *)pushData
                       success:(void (^)(long messageId))successBlock
                         error:(void (^)(RCErrorCode nErrorCode, long messageId))errorBlock;

/** 发送文本信息 默认推送 */
- (RCMessage *)sendTextMessage:(RCConversationType)conversationType
                      targetId:(NSString *)targetId
                         title:(NSString *)title
                       success:(void (^)(long messageId))successBlock
                         error:(void (^)(RCErrorCode nErrorCode, long messageId))errorBlock;

/** 发送图片信息 */
- (RCMessage *)sendImageMessage:(RCConversationType)conversationType
                       targetId:(NSString *)targetId
                          image:(UIImage *)image
                    pushContent:(NSString *)pushContent
                       pushData:(NSString *)pushData
                       progress:(void (^)(int progress, long messageId))progressBlock
                        success:(void (^)(long messageId))successBlock
                          error:(void (^)(RCErrorCode errorCode, long messageId))errorBlock;

/** 发送图片信息 默认推送 */
- (RCMessage *)sendImageMessage:(RCConversationType)conversationType
                       targetId:(NSString *)targetId
                          image:(UIImage *)image
                       progress:(void (^)(int progress, long messageId))progressBlock
                        success:(void (^)(long messageId))successBlock
                          error:(void (^)(RCErrorCode errorCode, long messageId))errorBlock;

/**  向会话中发送正在输入的状态 */
- (void)sendsendTypingStatus:(RCConversationType)conversationType
                    targetId:(NSString *)targetId
                       title:(NSString *)title;

/** 获取本地存储的消息 */
- (NSArray<MessageModel *> *)getLatestMessages:(RCConversationType)conversationType
                                   targetId:(NSString *)targetId
                                      count:(int)count;

/** 设置是否置顶 */
- (BOOL)setConversationToTop:(RCConversationType)conversationType
                    targetId:(NSString *)targetId
                       isTop:(BOOL)isTop;
@end
