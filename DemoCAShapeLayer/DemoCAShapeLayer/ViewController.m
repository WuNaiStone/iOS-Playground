//
//  ViewController.m
//  DemoCAShapeLayer
//
//  Created by Chris Hu on 16/7/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "ViewCAShapeLayerAnimation.h"

@interface ViewController () <
    ViewCAShapeLayerAnimationDelegate
>

@end

@implementation ViewController {

    UIButton *btn;
    
    ViewCAShapeLayerAnimation *_viewAnima;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    _viewAnima = [[ViewCAShapeLayerAnimation alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:_viewAnima];
    _viewAnima.center = self.view.center;
    _viewAnima.delegate = self;
    
    [self addBtns];
}

- (void)addBtns{
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"CAShapeLayerAnimation" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionCAShapeLayer:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionCAShapeLayer:(UIButton *)sender {
    [_viewAnima startAnimation];
}

#pragma mark - <ViewCAShapeLayerAnimationDelegate>

- (void)ViewCAShapeLayerAnimationDidStart {
    NSLog(@"%s", __func__);
    
    btn.titleLabel.text = @"Loading Start";
    btn.userInteractionEnabled = NO;
}

- (void)ViewCAShapeLayerAnimationDidStop {
    NSLog(@"%s", __func__);
    
    btn.titleLabel.text = @"Loading Stop";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.titleLabel.text = @"CAShapeLayerAnimation";
        btn.userInteractionEnabled = YES;
    });
}

@end
