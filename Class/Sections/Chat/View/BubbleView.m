//
//  BubbleView.m
//  WWeChat
//
//  Created by WzxJiang on 16/7/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BubbleView.h"


const CGFloat minHeight = 40;
const CGFloat space     = 5;

@implementation BubbleView {
    BOOL _isA;
    NSString * _title;
    UIImage  * _img;
    UILabel  * _messageLabel;
    UIImageView * _messageImgView;
}

+ (instancetype)bubbleWithIsA:(BOOL)isA title:(NSString *)title img:(UIImage *)img {
    if (title)  return [[BubbleView alloc]initWithTitle:title isA:isA];
    if (img)    return [[BubbleView alloc]initWithImg:img isA:isA];
    return nil;
}

- (instancetype)initWithTitle:(NSString *)title isA:(BOOL)isA{
    if (self = [super init]) {
        _isA = isA;
        _title = title;
        [self calculateFrameWithTitle];
    }
    return self;
}

- (instancetype)initWithImg:(UIImage *)image isA:(BOOL)isA{
    if (self = [super init]) {
        _isA = isA;
        _img = image;
        [self calculateFrameWithImg];
    }
    return self;
}

- (void)calculateFrameWithTitle {
    [self addSubview:[self messageLabel]];
    CGRect selfRect;
    if (_messageLabel.frame.size.height < minHeight - space) {
        selfRect.size.height = 40;
    } else {
        selfRect.size.height = _messageLabel.frame.size.height;
    }
    selfRect.size.width = _messageLabel.frame.size.width;
    self.frame = selfRect;
}

- (void)calculateFrameWithImg {
    [self addSubview:[self messageImgView]];
    CGRect selfRect;
    selfRect = _messageImgView.frame;
    self.frame = selfRect;
}

- (void)calculateIsA {
    UIImage * bubbleImg;
    if (_isA) {
        bubbleImg = UIImageForKitBundle(@"SenderTextNodeBkgHL");
        self.wzx_origin = CGPointMake(kScreenWidth - (minHeight + 2 * 10), 0);
    } else {
        bubbleImg = UIImageForKitBundle(@"ReceiverTextNodeBkgHL");
        self.wzx_origin = CGPointMake(minHeight + 2 * 10, 0);
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(30, 15, 30, 15);
    UIImage *insetImage = [bubbleImg resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    self.image = insetImage;
}

#pragma mark - lazy load
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.text = _title;
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:14];
        CGSize bestSize = [_messageLabel sizeThatFits:CGSizeMake(kScreenWidth - 2*space -space, CGFLOAT_MAX)];
        _messageLabel.frame = CGRectMake(space, space, bestSize.width, bestSize.height);
    }
    return _messageLabel;
}

- (UIImageView *)messageImgView {
    if (!_messageImgView) {
        _messageImgView = [[UIImageView alloc]init];
        _messageImgView.image = _img;
        CGSize imgSize = _img.size;
        _messageImgView.frame = CGRectMake(0, 0, 100, (100/imgSize.width)*imgSize.height);
    }
    return _messageImgView;
}
@end
