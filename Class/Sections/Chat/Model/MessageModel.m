//
//  MessageModel.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/7.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "MessageModel.h"
@implementation MessageModel

- (instancetype)initWithMessage:(RCMessage *)message {
    self = [super init];
    if (self) {
        if ([message.content isMemberOfClass:[RCTextMessage class]]) {
            RCTextMessage * textMessage = (RCTextMessage *)message.content;
            self.messageType = MessageTypeNone;
            self.message = textMessage.content;
        } else if ([message.content isMemberOfClass:[RCImageMessage class]]) {
            RCImageMessage * textMessage = (RCImageMessage *)message.content;
            self.messageType = MessageTypeImg;
            self.message = textMessage.imageUrl;
        }
        
        self.isA = [message.senderUserId isEqualToString:[Statics currentUser].objectId];
        self.timestamp = [NSString stringWithFormat:@"%lld",message.sentTime];
        self.sentID = message.senderUserId;
    }
    return self;
}

@end
