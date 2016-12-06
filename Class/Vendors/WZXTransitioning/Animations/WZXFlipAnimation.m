//
//  WZXFlipAnimation.m
//  WZXPrsentAnimations
//
//  Created by WzxJiang on 16/6/1.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "WZXFlipAnimation.h"

@implementation WZXFlipAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //目的ViewController
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //起始ViewController
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //添加toView到上下文
    [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    //自定义动画
    
    toViewController.view.alpha = 0;
    toViewController.view.layer.transform = CATransform3DMakeRotation(- M_PI, 0, 1, 0);

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromViewController.view.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        fromViewController.view.alpha = 0;
        toViewController.view.layer.transform = CATransform3DIdentity;
        toViewController.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        fromViewController.view.layer.transform = CATransform3DIdentity;
        
        // 声明过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
