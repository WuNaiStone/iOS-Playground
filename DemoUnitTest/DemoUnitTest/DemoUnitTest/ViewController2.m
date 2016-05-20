//
//  ViewController2.m
//  DemoUnitTest
//
//  Created by zj－db0465 on 15/11/25.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [_btnBack setTitle:@"Go to ViewController" forState:UIControlStateNormal];
    [_btnBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btnBack setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [_btnBack addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
    _btnBack.layer.borderColor = [UIColor redColor].CGColor;
    _btnBack.layer.borderWidth = 2.0f;
    [self.view addSubview:_btnBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
