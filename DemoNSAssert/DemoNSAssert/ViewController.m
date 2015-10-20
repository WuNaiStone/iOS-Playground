//
//  ViewController.m
//  DemoNSAssert
//
//  Created by zj－db0465 on 15/10/20.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:(CGRect){0, 100, self.view.frame.size.width, 50}];
    btn.layer.borderColor = [UIColor blueColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [btn setTitle:@"Button Name" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBtnClicked:(UIButton *)sender {
    // 在Building Settings->Preprocessor Macros中，设置Release为NS_BLOCK_ASSERTIONS，禁止断言检查。
    // 在Edit Scheme->Run->Build Configuration中，更改编译版本。
    NSAssert(sender.titleLabel.text, @"1: sender.titleLable.text not nil");
    NSAssert(![sender.titleLabel.text isEqualToString:@""], @"2: sender.titleLable.text not nil");
    NSAssert(sender.titleLabel.text == nil, @"3: sender.titleLable.text not nil");
    
    NSLog(@"sender.name : %@", sender.titleLabel.text);
}

@end
