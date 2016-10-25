//
//  CSPieShapeLayer.m
//  DemoCAShapeLayer
//
//  Created by Chris Hu on 16/10/9.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CSPieShapeLayer.h"


static CGFloat offset = 2.f;


@implementation CSPieShapeLayer {
    
    CAShapeLayer *_shapeLayer;
    
    CGPoint radiusCenter;
    
    CGFloat radius;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addOutCircle];
        
        [self addCAShapeLayer];
    }
    return self;
}

// 外圈
- (void)addOutCircle
{
    CAShapeLayer *outShapeLayer = [CAShapeLayer layer];
    outShapeLayer.frame = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:outShapeLayer.bounds];
    outShapeLayer.path = path.CGPath;
    outShapeLayer.lineWidth = 2.0f;
    outShapeLayer.lineCap = kCALineCapRound;
    outShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    outShapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:outShapeLayer];
    
    outShapeLayer.strokeStart = 0.f;
    outShapeLayer.strokeEnd = 1.f;
}

- (void)addCAShapeLayer {
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 0, self.bounds.size.width - offset * 2, self.bounds.size.height - offset * 2);
    
    radiusCenter = self.center;
    radius = (_shapeLayer.bounds.size.width - offset) / 2; // 要加1
    
    // 绘制扇形
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:radiusCenter];
    [path addArcWithCenter:radiusCenter
                    radius:radius
                startAngle:0
                  endAngle:0
                 clockwise:YES];
//    [path addLineToPoint:radiusCenter];
    [path closePath]; // 使用closePath也可以
    
    _shapeLayer.path = path.CGPath;
    _shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_shapeLayer];
}

- (void)setProgressValue:(CGFloat)progressValue {
    _progressValue = progressValue;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:radiusCenter];
    [path addArcWithCenter:radiusCenter
                    radius:radius
                startAngle:0
                  endAngle:2 * M_PI * _progressValue
                 clockwise:YES];
    
    _shapeLayer.path = path.CGPath;
    [_shapeLayer setNeedsDisplay];
}

@end
