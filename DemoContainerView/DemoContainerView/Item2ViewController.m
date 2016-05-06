//
//  Item2ViewController.m
//  DemoContainerView
//
//  Created by zj－db0465 on 16/5/6.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "Item2ViewController.h"

@interface Item2ViewController ()

@end

@implementation Item2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self addButtonBack];
    
    [self addLabel];
}

- (void)addButtonBack {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Pop Item2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 30)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    label.text = @"This is Item2 ViewController";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
