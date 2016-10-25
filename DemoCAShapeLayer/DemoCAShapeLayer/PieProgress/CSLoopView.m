//
//  CSLoopView.m
//  DemoCAShapeLayer
//
//  Created by zj－db0465 on 16/10/25.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CSLoopView.h"

@interface CSLoopView ()

@property (nonatomic, assign) CGFloat radius;

@end

@implementation CSLoopView
{
    
    CAShapeLayer *_shapeLayer;
    
    CGPoint _arcCenter;
    
    UIBezierPath *_path;
    UIBezierPath *_outerPath;
    UIBezierPath *_innerPath;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self layoutIfNeeded];
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _arcCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _radius = self.bounds.size.width / 2;
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.backgroundColor = [UIColor greenColor].CGColor;
    _shapeLayer.frame = self.bounds;
    _shapeLayer.fillColor = [UIColor redColor].CGColor;
    _shapeLayer.fillRule = kCAFillRuleEvenOdd;
    //    [self.layer insertSublayer:_shapeLayer atIndex:0];
    [self.layer addSublayer:_shapeLayer];
    
    _path = [UIBezierPath bezierPath];
    
    _outerPath = [UIBezierPath bezierPathWithOvalInRect:_shapeLayer.bounds];
    [_path appendPath:_outerPath];
    
    _innerPath = [UIBezierPath bezierPathWithArcCenter:_arcCenter radius:_radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [_path appendPath:_innerPath];
    
    _shapeLayer.path = _path.CGPath;
}

- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    
    UIBezierPath *newInnerPath = [UIBezierPath bezierPathWithArcCenter:_arcCenter radius:_radius * (1 - _progressValue) startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path appendPath:_outerPath];
    [path appendPath:newInnerPath];
    
    _shapeLayer.path = path.CGPath;
}

- (void)beginCaptureAnimation
{
    [CATransaction begin];
    [self.layer removeAllAnimations];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    anim.duration = 0.3f;
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 appendPath:_outerPath];
//    [path1 appendPath:[UIBezierPath bezierPathWithOvalInRect:_shapeLayer.bounds]];
    [path1 appendPath:[UIBezierPath bezierPathWithArcCenter:_arcCenter radius:_radius startAngle:0 endAngle:2 * M_PI clockwise:YES]];
    
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 appendPath:_outerPath];
    // 正确设置rect
    //    [path2 appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(_arcCenter.x, _arcCenter.y, 0, 0)]];
    
    // radius不能为0.
    [path2 appendPath:[UIBezierPath bezierPathWithArcCenter:_arcCenter radius:0.1f startAngle:0 endAngle:2 * M_PI clockwise:YES]];
    
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 appendPath:_outerPath];
//    [path3 appendPath:[UIBezierPath bezierPathWithOvalInRect:_shapeLayer.bounds]];
    [path3 appendPath:[UIBezierPath bezierPathWithArcCenter:_arcCenter radius:_radius startAngle:0 endAngle:2 * M_PI clockwise:YES]];
    
    
    anim.keyTimes = @[@0, @0.5, @1];
    anim.values = @[(__bridge id)path1.CGPath, (__bridge id)path2.CGPath, (__bridge id)path3.CGPath];
    [_shapeLayer addAnimation:anim forKey:@"path"];
    
    [CATransaction commit];
}

@end
