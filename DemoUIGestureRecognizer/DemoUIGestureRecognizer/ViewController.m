//
//  ViewController.m
//  DemoUIGestureRecognizer
//
//  Created by zj－db0465 on 15/9/28.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"

#import "AView.h"
#import "BView.h"

#import "AScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addGestures];
    
    [self addButtons];
}

- (void)addButtons {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 50)];
    [btn1 setTitle:@"AView" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(actionAView:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 2.0f;
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn2 setTitle:@"AScrollView" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(actionAScrollView:) forControlEvents:UIControlEventTouchUpInside];
    btn2.layer.borderColor = [UIColor redColor].CGColor;
    btn2.layer.borderWidth = 2.0f;
    [self.view addSubview:btn2];
}

- (void)actionAView:(UIButton *)sender {
    AView *aView = [[AView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    aView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:aView];
    
    BView *bView = [[BView alloc] initWithFrame:aView.bounds];
    bView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bView];
}

- (void)actionAScrollView:(UIButton *)sender {
    AScrollView *aScrollView = [[AScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    aScrollView.backgroundColor = [UIColor greenColor];
    aScrollView.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    [self.view addSubview:aScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - gestures

- (void)addGestures {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    longGesture.minimumPressDuration = 2.0f;
    [self.view addGestureRecognizer:longGesture];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    [self.view addGestureRecognizer:rotationGesture];
    
    UIScreenEdgePanGestureRecognizer *screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    screenEdgePanGesture.edges = UIRectEdgeAll;
    [self.view addGestureRecognizer:screenEdgePanGesture];
}

- (void)actionGesture:(UIGestureRecognizer *)sender {
    NSLog(@"actionGesture : %@", sender);
    NSLog(@"numberOfTouches : %ld\n", (long)sender.numberOfTouches);
    if ([sender isKindOfClass:[UISwipeGestureRecognizer class]]) {
        NSLog(@"Swipe : %@", sender);
    }
}

#pragma mark - touch events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    NSLog(@"ViewController touchesBegan : %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    NSLog(@"ViewController touchesMoved : %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    NSLog(@"ViewController touchesEnded : %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    NSLog(@"ViewController touchesCancelled : %@", NSStringFromCGPoint(touchPoint));
}


@end
