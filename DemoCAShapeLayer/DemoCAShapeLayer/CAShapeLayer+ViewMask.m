//
//  CAShapeLayer+ViewMask.m
//  DemoCAShapeLayer
//
//  Created by Chris Hu on 16/7/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CAShapeLayer+ViewMask.h"

@implementation CAShapeLayer (ViewMask)

+ (instancetype)addMaskLayerInView: (UIView *)view {
//    UIBezierPath *path = [self pathTriangleInView:view];
    UIBezierPath *path = [self pathStarInView:view];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}

// 三角形
+ (UIBezierPath *)pathTriangleInView:(UIView *)view {
    CGFloat width   = CGRectGetWidth(view.frame);
    CGFloat height  = CGRectGetHeight(view.frame);
    CGPoint p1      = CGPointMake(width / 2, 0);
    CGPoint p2      = CGPointMake(width, height / 2);
    CGPoint p3      = CGPointMake(0, height / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p1];
    [path addLineToPoint:p2];
    [path addLineToPoint:p3];
    [path closePath];
    
    return path;
}

// 五角形
/*
 看成是一个圆
 5个顶点在圆上，
 设半径：r=50，圆心：x=100，y=100
 则：最上一个顶点坐标为：x1=100,y1=50
 左边第二个顶点坐标为：x2=x-50*sin72度，y2=y-50*cos72度
 右边第二个顶点坐标为：x3=x+50*sin72度，y3=y-50*cos72度
 左边第三个顶点坐标为：x4=x-50*sin36度，y4=y+50*cos36度
 右边第三个顶点坐标为：x5=x+50*sin36度，y5=y+50*cos36度
 
 几个顶点的坐标就出来了，如下
 (x,y-r);(x-r*sin72度，y-r*cos72度);(x+r*sin72度,y-r*cos72度);
 (x-r*sin36度,y+r*cos36度);(x+r*sin36度，y+r*cos36度)
 */
+ (UIBezierPath *)pathStarInView:(UIView *)view {
    CGFloat width   = CGRectGetWidth(view.frame);
    CGFloat height  = CGRectGetHeight(view.frame);
    
    CGPoint center  = view.center;
    CGFloat radius  = width >= height ? width / 2 : height / 2;
    
    CGPoint p1      = CGPointMake(center.x, radius);
    
    CGFloat angle = 4 * M_PI / 5;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p1];
    
    for (NSInteger i = 1; i < 5; i++) {
        // cosf()返回参数的余弦值
        CGFloat x = cosf(i * angle - M_PI_2) * radius;
        // sinf()返回参数的正弦值
        CGFloat y = sinf(i * angle - M_PI_2) * radius;
        
        CGPoint point = CGPointMake(x+ center.x, y+ center.y);
        
        [path addLineToPoint:point];
    }
    
    /*
     
     
     
    CGPoint p1      = CGPointMake(center.x, radius);
    CGPoint p2      = CGPointMake(center.x - radius * sin(72 * M_PI / 180), center.y - 50 * cos(72 * M_PI / 180));
    CGPoint p3      = CGPointMake(center.x + radius * sin(72 * M_PI / 180), center.y - 50 * cos(72 * M_PI / 180));
    CGPoint p4      = CGPointMake(center.x - radius * sin(36 * M_PI / 180), center.y + 50 * cos(36 * M_PI / 180));
    CGPoint p5      = CGPointMake(center.x + radius * sin(36 * M_PI / 180), center.y + 50 * cos(36 * M_PI / 180));
    */
    
    
    
//    [path addLineToPoint:p2];
//    [path addLineToPoint:p3];
//    [path addLineToPoint:p4];
//    [path addLineToPoint:p5];
    [path closePath];
    
    return path;
}

@end
