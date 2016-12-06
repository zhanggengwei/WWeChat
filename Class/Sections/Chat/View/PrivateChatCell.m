//
//  PrivateCell.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/7.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "PrivateChatCell.h"
#import "BubbleView.h"

@implementation PrivateChatCell {
    BubbleView * _bubbleView;
}

- (void)setModel:(MessageModel *)model {
    _model = model;
    if (_model.isA) {
        [_BAvaterImgView removeFromSuperview];
    } else {
        [_AAvaterImgView removeFromSuperview];
    }
    [self.contentView addSubview:self.bubbleView];
}

- (BubbleView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = ({
            NSString * title = nil;
            UIImage  * img = nil;
            if(_model.messageType == MessageTypeNone) {
                title = _model.message;
            } else if (_model.messageType == MessageTypeImg) {
                img   = _model.message;
            }
            BubbleView * bubbleView = [BubbleView bubbleWithIsA:_model.isA title:title img:img];
            bubbleView;
        });
    }
    return _bubbleView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
