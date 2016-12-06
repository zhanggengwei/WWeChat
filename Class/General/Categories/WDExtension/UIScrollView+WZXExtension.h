//
//  UIScrollView+WDExtension.h
//  PopOn
//
//  Created by WzxJiang on 16/6/17.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (WZXExtension)


@property(nonatomic,assign)CGFloat wzx_contentInset_top;

@property(nonatomic,assign)CGFloat wzx_contentInset_left;

@property(nonatomic,assign)CGFloat wzx_contentInset_bottom;

@property(nonatomic,assign)CGFloat wzx_contentInset_right;


@property(nonatomic,assign)CGFloat wzx_contentOffset_x;

@property(nonatomic,assign)CGFloat wzx_contentOffset_y;


@property(nonatomic,assign)CGFloat wzx_contentSize_width;

@property(nonatomic,assign)CGFloat wzx_contentSize_height;


@end
