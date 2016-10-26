//
//  ViewController.m
//  DemoBezierPath
//
//  Created by Chris Hu on 16/10/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
{
    CAShapeLayer *_shapeLayer;
    
    CGPathRef _oldPath;
    CGPathRef _newPath;
    
    NSTimer *_timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shapeLayer               = [CAShapeLayer layer];
    _shapeLayer.borderWidth   = 0.5f;
    _shapeLayer.frame         = CGRectMake(0, 0, 200, 200);
    _shapeLayer.position      = self.view.center;
    _shapeLayer.path          = [self newBezierPath].CGPath;
    _shapeLayer.fillColor     = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_shapeLayer];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(actionTimer:) userInfo:nil repeats:YES];
}

- (void)actionTimer:(NSTimer *)sender
{
    _oldPath = _shapeLayer.path;
    _newPath = [self newBezierPath].CGPath;
    
    CABasicAnimation *basicAnimation   = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration            = 0.5;
    basicAnimation.fromValue           = (__bridge id)(_oldPath);
    basicAnimation.toValue             = (__bridge id)_newPath;
    _shapeLayer.path                   = _newPath;
    [_shapeLayer addAnimation:basicAnimation forKey:@"path"];
}

- (UIBezierPath *)newBezierPath {
    static int count = 0;
    
    CGFloat controlPoint1_X = 0;
    CGFloat controlPoint1_Y = 0;
    CGFloat controlPoint2_X = 0;
    CGFloat controlPoint2_Y = 0;
    
    if (count ++ % 2 == 0) {
        
        controlPoint1_X = [self randomNum_70_79];
        controlPoint1_Y = [self randomNum_70_79];
        
        controlPoint2_X = [self randomNum_120_129];
        controlPoint2_Y = [self randomNum_120_129];
        
    } else {
        
        controlPoint1_X = [self randomNum_70_79];
        controlPoint1_Y = [self randomNum_120_129];
        
        controlPoint2_X = [self randomNum_120_129];
        controlPoint2_Y = [self randomNum_70_79];
        
    }
    
    // 获取贝塞尔曲线
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    // A
    [bezierPath moveToPoint:CGPointMake(0, 100)];
    
    // B (Curve)
    [bezierPath addCurveToPoint:CGPointMake(200, 100)
                  controlPoint1:CGPointMake(controlPoint1_X, controlPoint1_Y)
                  controlPoint2:CGPointMake(controlPoint2_X, controlPoint2_Y)];
    
    // C
    [bezierPath addLineToPoint:CGPointMake(200, 200)];
    
    // D
    [bezierPath addLineToPoint:CGPointMake(0, 200)];
    
    // 闭合曲线
    [bezierPath closePath];
    
    return bezierPath;
}

- (CGFloat)randomNum_70_79 {
    
    return (CGFloat)(arc4random() % 10 + 70);
}

- (CGFloat)randomNum_120_129 {
    
    return (CGFloat)(arc4random() % 10 + 120);
}

@end
