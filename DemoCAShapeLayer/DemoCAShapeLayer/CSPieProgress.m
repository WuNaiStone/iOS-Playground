//
//  CSPieProgress.m
//  DemoCAShapeLayer
//
//  Created by Chris Hu on 16/9/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CSPieProgress.h"


@interface CSPieProgressLayer : CALayer

@property (nonatomic, assign) CGFloat progressValue;

@end


@implementation CSPieProgressLayer

- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat lineWidth = 2.0f;
    
    CGRect rect = self.bounds;
    CGPoint center = CGPointMake(rect.origin.x + floorf(rect.size.height / 2.0f),
                                 rect.origin.y + floorf(rect.size.height / 2.0f));
    CGFloat radius = floorf(MIN(rect.size.width, rect.size.height) / 2.0f) - lineWidth;
    
    
    UIGraphicsPushContext(ctx);
    
    [[UIColor whiteColor] setStroke];
    
    //Border
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:0.0f
                                                            endAngle:2 * M_PI
                                                           clockwise:NO];
    
    [borderPath setLineWidth:lineWidth];
    [borderPath stroke];
    
    
    //Progress
    CGFloat startAngle = -(M_PI / 2.0f);
    CGFloat endAngle = startAngle + 2.0f * M_PI * self.progressValue;
    
    UIBezierPath *processPath = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:radius / 2.0f
                                                           startAngle:startAngle
                                                             endAngle:endAngle
                                                            clockwise:YES];
    [processPath setLineWidth:radius];
    [processPath stroke];
    
    UIGraphicsPopContext();
}

@end



#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees) / 180)

@interface CSPieProgress ()
<
    CAAnimationDelegate
>

@end

@implementation CSPieProgress

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setNeedsDisplay];
    }
    return self;
}

+ (Class)layerClass {
    return [CSPieProgressLayer class];
}

- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    
    [CATransaction begin];
    
    [self.layer removeAllAnimations];
    
    [(CSPieProgressLayer *)self.layer setProgressValue:progressValue];
    
    [CATransaction commit];
}

@end
