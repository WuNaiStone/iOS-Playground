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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addButtons];
    
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSLog(@"%s", __func__);
}

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

@end
