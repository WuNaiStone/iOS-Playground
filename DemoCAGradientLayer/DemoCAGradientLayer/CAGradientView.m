//
//  CAGradientView.m
//  DemoCAGradientLayer
//
//  Created by Chris Hu on 16/10/26.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "CAGradientView.h"

@interface CAGradientView ()

@end

@implementation CAGradientView
{
    CAGradientLayer *_gradientLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initGradientLayer];
    }
    return self;
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (void)initGradientLayer {
    _gradientLayer = (CAGradientLayer *)self.layer;
    _gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                              (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)[UIColor clearColor].CGColor];
    _gradientLayer.locations  = @[@(0), @(0.5), @(1)];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint   = CGPointMake(1, 0);
}

@end
