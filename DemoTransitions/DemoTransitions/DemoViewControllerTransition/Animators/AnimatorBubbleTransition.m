//
//  AnimatorBubbleTransition.m
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/17.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "AnimatorBubbleTransition.h"

@implementation AnimatorBubbleTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

// 动画的持续时间
// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

// This method can only be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView, *toView;
    // iOS8之后才有
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = from.view;
        toView = to.view;
    }
    
    // 实际上, 在toView的下边, 添加了一个bubbleView, 从最初的bubble的center位置开始, 通过scale动画呈现出来.
    // BubbleView与toView的背景色一致.
    UIView *bubbleView = [[UIView alloc] init];
    bubbleView.backgroundColor = toView.backgroundColor; // [UIColor purpleColor];
    CGSize toViewSize = toView.frame.size;
    CGFloat x = fmax(_bubbleCenter.x, toViewSize.width);
    CGFloat y = fmax(_bubbleCenter.y, toViewSize.height);
    CGFloat radius = sqrt(x * x + y * y);
    bubbleView.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    bubbleView.layer.cornerRadius = CGRectGetHeight(bubbleView.frame) / 2;
    bubbleView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    bubbleView.center = _bubbleCenter;
    [containerView addSubview:bubbleView];
    
    // toView要跟随bubbleView一起做动画
    toView.frame = [transitionContext finalFrameForViewController:to];
    CGPoint toViewFinalCenter = toView.center;
    toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    toView.center = _bubbleCenter;
    toView.alpha = 0.0;
    [containerView addSubview:toView];
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        bubbleView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        toView.alpha = 1.0f;
        toView.center = toViewFinalCenter;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
//    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        bubbleView.transform = CGAffineTransformIdentity;
//        toView.transform = CGAffineTransformIdentity;
//        toView.alpha = 1.0f;
//        toView.center = toViewFinalCenter;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
    
}

// @optional
// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted {
    NSLog(@"%s", __func__);
}

@end
