//
//  BubbleView.h
//  WWeChat
//
//  Created by WzxJiang on 16/7/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleView : UIImageView

+ (instancetype)bubbleWithIsA:(BOOL)isA title:(NSString *)title img:(UIImage *)img;

@end
