//
//  ViewController.m
//  DemoCAGradientLayer
//
//  Created by Chris Hu on 16/8/27.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "ViewController.h"
#import "CAGradientView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testBasicGradientLayer];
    
    [self testGradientView];
}

- (void)testBasicGradientLayer
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    
    // 渐变layer, 需要设置colors数组, 有时候需要设置locations数组
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];
    
    // 不加locations数组, 则默认为线性均匀的渐变.
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
}

- (void)testGradientView
{
    UIImageView *imageViewOriginal = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 200, 200)];
    imageViewOriginal.image        = [UIImage imageNamed:@"66.jpg"];
    [self.view addSubview:imageViewOriginal];
    
    // 加了mask的view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 250, 200, 200)];
    imageView.image        = [UIImage imageNamed:@"66.jpg"];
    [self.view addSubview:imageView];
    
    CAGradientView *gradientView = [[CAGradientView alloc] initWithFrame:imageView.bounds];
    // 使用imageView的maskView
    imageView.maskView = gradientView;
}

@end
