//
//  ViewController2.m
//  DemoUIViewControllerRelatedAll
//
//  Created by Chris Hu on 16/3/31.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.textColor = [UIColor whiteColor];
    label.text = NSStringFromClass(self.class);
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Button" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)actionButton:(UIButton *)sender {
//    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
//    [self dismissViewControllerAnimated:NO completion:nil];
//    return;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    ViewController *rootVC = (ViewController *)keyWindow.rootViewController;
    
//    [rootVC.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    [rootVC dismissViewControllerAnimated:NO completion:nil];
    
//    [self dismissViewControllerAnimated:NO completion:nil];
//    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    
    /**
     *  [rootVC.presentedViewController dismissViewControllerAnimated:NO completion:nil];
     *  使用rootVC.presentedViewController会对DismissVC进行retain操作，因此只能到DismissVC。
     *  [rootVC dismissViewControllerAnimated:NO completion:nil];到rootVC。
     *
     *  [self dismissViewControllerAnimated:NO completion:nil];退出VC2，到VC1中。
     *  [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];到VC1中。
     *  使用self.presentingViewController会对VC1进行retain操作，只能到VC1。
     *
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
