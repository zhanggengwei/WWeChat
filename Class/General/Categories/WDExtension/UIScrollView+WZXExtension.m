//
//  UIScrollView+WDExtension.m
//  PopOn
//
//  Created by WzxJiang on 16/6/17.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import "UIScrollView+WZXExtension.h"

@implementation UIScrollView (WZXExtension)

- (CGFloat)wzx_contentInset_top {
    return self.contentInset.top;
}

- (void)setWzx_contentInset_top:(CGFloat)wzx_contentInset_top {
    UIEdgeInsets edge = self.contentInset;
    edge.top = wzx_contentInset_top;
    self.contentInset = edge;
}


- (CGFloat)wzx_contentInset_bottom {
    return self.contentInset.bottom;
}

- (void)setWzx_contentInset_bottom:(CGFloat)wzx_contentInset_bottom {
    UIEdgeInsets edge = self.contentInset;
    edge.bottom = wzx_contentInset_bottom;
    self.contentInset = edge;
}


- (CGFloat)wzx_contentInset_left {
    return self.contentInset.left;
}

- (void)setWzx_contentInset_left:(CGFloat)wzx_contentInset_left {
    UIEdgeInsets edge = self.contentInset;
    edge.left = wzx_contentInset_left;
    self.contentInset = edge;
}


- (CGFloat)wzx_contentInset_right {
    return self.contentInset.right;
}

- (void)setWzx_contentInset_right:(CGFloat)wzx_contentInset_right {
    UIEdgeInsets edge = self.contentInset;
    edge.right = wzx_contentInset_right;
    self.contentInset = edge;
}


- (CGFloat)wzx_contentOffset_x {
    return self.contentOffset.x;
}

- (void)setWzx_contentOffset_x:(CGFloat)wzx_contentOffset_x {
    CGPoint offset = self.contentOffset;
    offset.x = wzx_contentOffset_x;
    self.contentOffset = offset;
}


- (CGFloat)wzx_contentOffset_y {
    return self.contentOffset.y;
}

- (void)setWzx_contentOffset_y:(CGFloat)wzx_contentOffset_y {
    CGPoint offset = self.contentOffset;
    offset.y = wzx_contentOffset_y;
    self.contentOffset = offset;
}


- (CGFloat)wzx_contentSize_width {
    return self.contentSize.width;
}

- (void)setWzx_contentSize_width:(CGFloat)wzx_contentSize_width {
    CGSize size = self.contentSize;
    size.width = wzx_contentSize_width;
    self.contentSize = size;
}


- (CGFloat)wzx_contentSize_height {
    return self.contentSize.height;
}

- (void)setWzx_contentSize_height:(CGFloat)wzx_contentSize_height {
    CGSize size = self.contentSize;
    size.height = wzx_contentSize_height;
    self.contentSize = size;
    
}

@end
