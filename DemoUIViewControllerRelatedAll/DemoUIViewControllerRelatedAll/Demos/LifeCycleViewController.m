//
//  LifeCycleViewController.m
//  DemoUIViewControllerRelatedAll
//
//  Created by zj－db0465 on 16/3/3.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "LifeCycleViewController.h"

@interface LifeCycleViewController ()

@end

@implementation LifeCycleViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

/**
 *  此时整个视图层次(view hierarchy)已经被放到内存中，可以移除一些视图，修改约束，加载数据等
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addButtons];
    
    NSLog(@"%s", __func__);
}

/**
 *  视图加载完成，并即将显示在屏幕上,还没有设置动画，可以改变当前屏幕方向或状态栏的风格等
 *
 *  @param animated 是否有动画效果
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);
}

/**
 *  视图已经展示在屏幕上，可以对视图做一些关于展示效果方面的修改。
 *
 *  @param animated 是否有动画效果
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s", __func__);
}

/**
 *  视图即将消失
 *
 *  @param animated 是否有动画效果
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"%s", __func__);
}

/**
 *  视图即将消失
 *
 *  @param animated 是否有动画效果
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"%s", __func__);
}

/**
 *  即将开始子视图位置布局
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSLog(@"%s", __func__);
}

/**
 *  用于通知视图的位置布局已经完成
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"%s", __func__);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    NSLog(@"%s", __func__);
}

- (BOOL)isViewLoaded {
    NSLog(@"%s", __func__);
    
    return [super isViewLoaded];
}

- (BOOL)isBeingPresented {
    NSLog(@"%s", __func__);
    
    return [super isBeingPresented];
}

- (BOOL)isBeingDismissed {
    NSLog(@"%s", __func__);
    
    return [super isBeingDismissed];
}

- (BOOL)isMovingToParentViewController {
    NSLog(@"%s", __func__);
    
    return [super isMovingToParentViewController];
}

- (BOOL)isMovingFromParentViewController {
    NSLog(@"%s", __func__);
    
    return [super isMovingFromParentViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"%s", __func__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    
    NSLog(@"%s", __func__);
    return self;
}

+ (void)initialize
{
    if (self == [UIViewController class]) {
    }
    
    NSLog(@"%s", __func__);
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    
    NSLog(@"%s", __func__);
    return self;
}

/**
 *  创建或加载view，赋值给UIViewController的view属性
 */
- (void)loadView {
    [super loadView];
    
    NSLog(@"%s", __func__);
}

- (void)loadViewIfNeeded {
    [super loadViewIfNeeded];
    
    NSLog(@"%s", __func__);
}

- (void) removeFromParentViewController {
    [super removeFromParentViewController];
    
    NSLog(@"%s", __func__);
}

#pragma mark - IBActions

- (void)addButtons {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [btn setTitle:@"Close" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionClose:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionClose:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 Demo的log：
 2016-03-22 15:12:11.475 DemoUIViewControllerRelatedAll[49348:2047139] -[ViewController viewWillAppear:]
 2016-03-22 15:12:11.521 DemoUIViewControllerRelatedAll[49348:2047139] -[ViewController viewDidAppear:]
 
 2016-03-22 15:12:28.714 DemoUIViewControllerRelatedAll[49348:2047139] +[LifeCycleViewController initialize]
 2016-03-22 15:12:28.714 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController init]
 2016-03-22 15:12:28.715 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController loadView]
 2016-03-22 15:12:28.715 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.715 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.716 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController viewDidLoad]
 2016-03-22 15:12:28.716 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.716 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.717 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.717 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.719 DemoUIViewControllerRelatedAll[49348:2047139] -[ViewController viewWillDisappear:]
 2016-03-22 15:12:28.719 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController viewWillAppear:]
 2016-03-22 15:12:28.720 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.720 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.720 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.721 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.721 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController viewWillLayoutSubviews]
 2016-03-22 15:12:28.721 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController viewDidLayoutSubviews]
 2016-03-22 15:12:28.722 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController viewWillLayoutSubviews]
 2016-03-22 15:12:28.722 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController viewDidLayoutSubviews]
 2016-03-22 15:12:28.723 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:28.723 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:29.240 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController viewDidAppear:]
 2016-03-22 15:12:29.240 DemoUIViewControllerRelatedAll[49348:2047139] -[ViewController viewDidDisappear:]
 2016-03-22 15:12:51.114 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.115 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.115 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.115 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.116 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.116 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.116 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.116 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.116 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.117 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:51.117 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 
 2016-03-22 15:12:55.220 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:55.222 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController viewWillDisappear:]
 2016-03-22 15:12:55.222 DemoUIViewControllerRelatedAll[49348:2047139] -[ViewController viewWillAppear:]
 2016-03-22 15:12:55.224 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:55.224 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController isViewLoaded]
 2016-03-22 15:12:55.743 DemoUIViewControllerRelatedAll[49348:2047139] -[ViewController viewDidAppear:]
 2016-03-22 15:12:55.743 DemoUIViewControllerRelatedAll[49348:2047139] -[LifeCycleViewController viewDidDisappear:]
 
 从VC1跳转至VC2:
 VC1 viewWillDisappear, VC2 viewWillAppear, VC2 viewDidAppear, VC1 viewDidDisappear
 */
@end
