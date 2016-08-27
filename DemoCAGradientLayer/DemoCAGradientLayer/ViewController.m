//
//  ViewController.m
//  DemoCAGradientLayer
//
//  Created by Chris Hu on 16/8/27.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    
    // 渐变layer, 需要设置colors数组, 有时候需要设置locations数组
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    
    // 不加locations数组, 则默认为线性均匀的渐变.
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
}

@end
