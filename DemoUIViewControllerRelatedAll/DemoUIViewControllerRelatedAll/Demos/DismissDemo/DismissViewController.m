//
//  DismissViewController.m
//  DemoUIViewControllerRelatedAll
//
//  Created by Chris Hu on 16/3/31.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "DismissViewController.h"
#import "ViewController1.h"

@interface DismissViewController ()

@end

@implementation DismissViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
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
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    [self presentViewController:vc1 animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
