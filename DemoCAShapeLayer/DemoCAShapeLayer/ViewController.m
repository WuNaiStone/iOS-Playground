//
//  ViewController.m
//  DemoCAShapeLayer
//
//  Created by Chris Hu on 16/7/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "CAShapeLayer+ViewMask.h"
#import "ViewCAShapeLayerAnimation.h"
#import "CSPieProgress.h"
#import "CSPieShapeLayer.h"
#import "CSLoopView.h"

@interface ViewController () <
    ViewCAShapeLayerAnimationDelegate
>

@end

@implementation ViewController {

    UIButton *btn;
    
    ViewCAShapeLayerAnimation *_viewAnima;
    
    CSPieProgress *_pieProgress;
    
    CSPieShapeLayer *_pieShapeLayer;
    
    CADisplayLink *_displayLinkLoading;
    
    UISlider *_sliderProgress;
    
    CGFloat _startProgress;
    CGFloat _stopProgress;
    
    CSLoopView *_loopView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
 
    _viewAnima = [[ViewCAShapeLayerAnimation alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [self.view addSubview:_viewAnima];
    _viewAnima.delegate = self;
    
    [self addBtns];
    
    [self addSliderProgress];
    
    [self testPieProgress];
    
    [self testPieShapeLayer];
    
    [self testLoopView];
}

- (void)testPieProgress
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"Model.jpg"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:maskView];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.4f;
    maskView.center = imageView.center;
    
    _pieProgress = [[CSPieProgress alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:_pieProgress];
    _pieProgress.backgroundColor = [UIColor clearColor];
    _pieProgress.center = maskView.center;
}

- (void)testPieShapeLayer
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(220, 100, 100, 100)];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"Model.jpg"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(220, 100, 100, 100)];
    [self.view addSubview:maskView];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.4f;
    maskView.center = imageView.center;
    
    _pieShapeLayer = [[CSPieShapeLayer alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:_pieShapeLayer];
    _pieShapeLayer.center = maskView.center;
    _pieShapeLayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testMask];
        [_loopView beginCaptureAnimation];
    });
}

- (void)testMask {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    bgView.center = self.view.center;
    [self.view addSubview:bgView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view.backgroundColor = [UIColor redColor];
    view.center = self.view.center;
    [self.view addSubview:view];
    
    CGRect beginRect = CGRectMake(0, 0, 20, 20);
    CGRect endRect = CGRectMake(0, 0, 100, 100);
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithRect:beginRect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:endRect];
    
    // layer.mask的区域即为实际屏幕上能看到的区域
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    view.layer.mask = maskLayer;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.fromValue = (__bridge id)(beginPath.CGPath);
    anim.toValue = (__bridge id)(endPath.CGPath);
    anim.duration = 5;
    [maskLayer addAnimation:anim forKey:@"path"];
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
    [_loopView beginCaptureAnimation];
    
    
    [_viewAnima startAnimation];
    
    
    _startProgress = 0.f;
    _stopProgress = 1.f;
    
//    if (!_displayLinkLoading) {
//        _displayLinkLoading = [CADisplayLink displayLinkWithTarget:self selector:@selector(actionLoadingProgress:)];
//        [_displayLinkLoading addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    } else {
//        [_displayLinkLoading invalidate];
//        _displayLinkLoading = nil;
//        
//        _viewLoading.progressValue = _startProgress;
//    }
}

- (void)addSliderProgress
{
    _sliderProgress = [[UISlider alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height - 150, self.view.frame.size.width - 100, 50)];
    [self.view addSubview:_sliderProgress];
    _sliderProgress.value = 0.f;
    _sliderProgress.minimumValue = 0.f;
    _sliderProgress.maximumValue = 1.f;
    [_sliderProgress addTarget:self action:@selector(actionSliderProgress:) forControlEvents:UIControlEventValueChanged];
}

- (void)actionSliderProgress:(UISlider *)sender
{
    _pieProgress.progressValue = sender.value;
    
    _pieShapeLayer.progressValue = sender.value;
    
    _loopView.progressValue = sender.value;
}

- (void)actionLoadingProgress:(CADisplayLink *)sender
{
    _pieProgress.progressValue = _startProgress;
    _startProgress += 0.01f;
    
    if (_startProgress == _stopProgress) {
        [sender invalidate];
        sender = nil;
    }
}

#pragma mark - Loop View

- (void)testLoopView
{
    _loopView = [[CSLoopView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _loopView.layer.cornerRadius = _loopView.frame.size.height / 2;
    [self.view addSubview:_loopView];
    _loopView.center = CGPointMake(self.view.center.x, self.view.center.y + 150);
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

#pragma mark - <ViewLoadingAnimationDelegate>

- (void)ViewLoadingAnimationDidStart
{

}

- (void)ViewLoadingAnimationDidStop
{

}

@end

