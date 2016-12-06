//
//  ChatCell.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/31.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatCell.h"
#import "WZXTimeTool.h"
@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)changeConstraints {
    _avaterImgViewHeight.constant = ScaleHeight(45);
    _avaterImgViewWidth.constant = ScaleHeight(45);
}

- (void)setModel:(WZXConversation *)model {
    [self changeConstraints];
    
    @weakify(self)
    [model loadUserInfo:^{
        @strongify(self)
       self.nameLabel.text = model.conversationTitle;
       [self.avaterImgView yy_setImageWithURL:[NSURL URLWithString:model.conversationAvaterUrl] placeholder:UIImageForKitBundle(@"default_avater")];
    }];
    
    self.messagelabel.text = model.lastMessage;
    
    self.timeLabel.text = [WZXTimeTool compareWithTime:model.lastMessageTime];
    
//    if (model.noReadNum > 0) {
//        NSString * noReadNumStr = [NSString stringWithFormat:@"%d",model.noReadNum];
//        CGFloat strWidth = [self giveMeWidthWithStr:noReadNumStr];
//        if (strWidth < ScaleHeight(15)) {
//            strWidth = ScaleHeight(15);
//        }
//        UIView * redPoint = [[UIView alloc]initWithFrame:CGRectMake(ScaleHeight(45) - strWidth/2.0, - ScaleHeight(5), strWidth, ScaleHeight(15))];
//        redPoint.layer.cornerRadius  = redPoint.frame.size.height/2.0;
//        redPoint.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
//        
//        UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, redPoint.frame.size.width, redPoint.frame.size.height)];
//        numLabel.textColor = [UIColor whiteColor];
//        numLabel.font = [UIFont systemFontOfSize:10];
//        numLabel.text = noReadNumStr;
//        numLabel.textAlignment = NSTextAlignmentCenter;
//        [redPoint addSubview:numLabel];
//        
//        [self.avaterImgView addSubview:redPoint];
//    }
}

@end
