//
//  AnimatorPresentTransition.m
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "AnimatorPresentTransition.h"

@interface AnimatorPresentTransition ()

@property (nonatomic, strong) UIViewController *presentedViewController;

@property (nonatomic, strong) UIViewController *presentingViewController;

@end


@implementation AnimatorPresentTransition

- (instancetype)initFromViewController:(UIViewController *)from toViewController:(UIViewController *)to {
    self = [super init];
    if (self) {
        self.presentedViewController = from;
        self.presentingViewController = to;
    }
    return self;
}

// 动画的持续时间
// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
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
    
    // 设置toView在转场开始时的位置和alpha.
    toView.frame = [transitionContext initialFrameForViewController:to]; // 全为0, 则toView从左上角扩散出来
//    toView.frame = CGRectMake(CGRectGetMinX(fromView.frame),
//                              CGRectGetHeight(fromView.frame),
////                              CGRectGetMaxY(fromView.frame) / 2, // 从中间往上弹出来
////                              CGRectGetMinY(fromView.frame), // 在fromView之上渐变出现
//                              CGRectGetWidth(fromView.frame),
//                              CGRectGetHeight(fromView.frame));
    toView.alpha = 0.0f;
    
    // containerView为transitionContext所包含的, 所有的动画都在该view中进行.
    [containerView addSubview:toView];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // 最后就是UIView动画的过程了, 动画的过程可以任意实现.
//    [UIView animateWithDuration:duration animations:^{
//        toView.frame = [transitionContext finalFrameForViewController:to];
//        toView.alpha = 1.0f;
//    } completion:^(BOOL finished) {
//        BOOL wasCancelled = [transitionContext transitionWasCancelled];
//        [transitionContext completeTransition:!wasCancelled];
//    }];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        // 指定位置
        toView.frame = [transitionContext finalFrameForViewController:to];
//        // toView只有一半屏幕的时候, 不明白为何会有一般的黑屏
//        toView.frame = CGRectMake(CGRectGetMinX(fromView.frame),
//                                  CGRectGetHeight(fromView.frame) / 2,
//                                  CGRectGetWidth(fromView.frame),
//                                  CGRectGetHeight(fromView.frame) / 2);
        toView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
    
}


// @optional
// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted {
    NSLog(@"%s", __func__);
}


@end
