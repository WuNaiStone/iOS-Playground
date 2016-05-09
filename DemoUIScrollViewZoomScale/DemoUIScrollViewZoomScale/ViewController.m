//
//  ViewController.m
//  DemoUIScrollViewZoomScale
//
//  Created by Chris Hu on 15/12/31.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "ScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Open ScrollViewController" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionScrollViewController:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionScrollViewController:(UIButton *)sender {
    ScrollViewController *scrollView = [[ScrollViewController alloc] init];
    scrollView.globalZoomScale = 1.f;
    [self presentViewController:scrollView animated:YES completion:nil];
}

@end
