//
//  ViewCAShapeLayerAnimation.m
//  DemoCAShapeLayer
//
//  Created by Chris Hu on 16/7/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewCAShapeLayerAnimation.h"

@implementation ViewCAShapeLayerAnimation {
    CAShapeLayer *_shapeLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCAShapeLayer];
    }
    return self;
}

/**
 *  将CAShapeLayer添加到layer上.
 *
 */
- (void)addCAShapeLayer {
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    _shapeLayer.path = path.CGPath;
    _shapeLayer.lineWidth = 2.0f;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    //    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:_shapeLayer];
}

/**
 *  通过strokeStart和strokeEnd来控制stroke
 *
 *  strokeStart默认为0.0，在动画中更改strokeEnd即可实现。
 */
//
- (void)startAnimation {
    _shapeLayer.hidden = NO;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    // keyPath不能写错。
    CABasicAnimation *pathAnim  = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnim.fromValue          = [NSNumber numberWithFloat:0.0f];
    pathAnim.toValue            = [NSNumber numberWithFloat:1.0f];
    pathAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnim.duration           = 1.0f;
    //    pathAnima.autoreverses = YES;
    pathAnim.delegate = self;
    [_shapeLayer addAnimation:pathAnim forKey:@"KeyStrokeEndAnimation"];
}

- (void)stopAnimation {
    _shapeLayer.hidden = YES;
    
    UILabel *label              = [[UILabel alloc] initWithFrame:self.bounds];
    label.backgroundColor       = [UIColor lightGrayColor];
    label.textColor             = [UIColor redColor];
    label.textAlignment         = NSTextAlignmentCenter;
    label.text                  = @"Done";
    label.layer.cornerRadius    = CGRectGetWidth(label.frame) / 2;
    label.layer.masksToBounds   = YES;
    [self addSubview:label];
    
    [UIView animateWithDuration:0.5 animations:^{
        label.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        label.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [label removeFromSuperview];
    }];
}

#pragma mark - <CAAnimationDelegate>

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"%s", __func__);
    
    if (_delegate && [_delegate respondsToSelector:@selector(ViewCAShapeLayerAnimationDidStart)]) {
        [_delegate ViewCAShapeLayerAnimationDidStart];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%s", __func__);
    
    [self stopAnimation];
    
    if (_delegate && [_delegate respondsToSelector:@selector(ViewCAShapeLayerAnimationDidStop)]) {
        [_delegate ViewCAShapeLayerAnimationDidStop];
    }
}

@end
