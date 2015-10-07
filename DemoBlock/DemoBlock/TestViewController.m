//
//  TestViewController.m
//  DemoBlock
//
//  Created by zj－db0465 on 15/9/17.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic) UILabel *lb;
@property (nonatomic) UIButton *btn;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self blockTestPassing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)blockTestPassing {
    _lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, CGRectGetWidth(self.view.bounds), 40)];
    _lb.backgroundColor = [UIColor grayColor];
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.text = @"initial label";
    [self.view addSubview:_lb];
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), 40)];
    _btn.layer.borderColor = [[UIColor redColor] CGColor];
    _btn.layer.borderWidth = 1.0f;
    [_btn setTitle:@"TestViewController" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [_btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (IBAction)action:(UIButton *)sender {
//    _blockUpdateBtnTitle(@"sender");
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
