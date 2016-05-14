//
//  ViewCircle.m
//  DemoUIViewRelatedAll
//
//  Created by Chris Hu on 16/5/6.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewCircle.h"

#define PI 3.14159265358979323846
#define DEGREES_TO_RADIANS(degrees) ((PI * degrees)/ 180)

@implementation ViewCircle {

    CGContextRef context;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    [self drawCircle];
    return self;
}

- (void)drawCircle {
    context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.2); // 填充颜色
    CGContextSetLineWidth(context, 2.5);
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, self.frame.size.width/2-2, 0, 2*PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); // 绘制路径
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self drawCircle];
}

@end
