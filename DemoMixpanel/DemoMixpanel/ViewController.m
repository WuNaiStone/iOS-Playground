//
//  ViewController.m
//  DemoMixpanel
//
//  Created by zj－db0465 on 15/9/17.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "Mixpanel.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController {

    Mixpanel *mixpanel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"ViewController viewDidLoad"];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 100)];
    lb.backgroundColor = [UIColor grayColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = @"ViewController UILabel";
    [self.view addSubview:lb];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.width + 30.f, self.view.bounds.size.width, 60)];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 1.0f;
    [btn setTitle:@"ViewController UIButton" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btnAlert = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btnAlert setTitle:@"Alert" forState:UIControlStateNormal];
    [btnAlert setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnAlert setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btnAlert addTarget:self action:@selector(actionAlert:) forControlEvents:UIControlEventTouchUpInside];
    btnAlert.layer.borderColor = [UIColor redColor].CGColor;
    btnAlert.layer.borderWidth = 2.0f;
    [self.view addSubview:btnAlert];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [mixpanel track:@"ViewController viewWillAppear"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [mixpanel track:@"ViewController viewDidAppear"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [mixpanel track:@"ViewController didReceiveMemoryWarning"];
}

- (void)actionBtn:(UIButton *)sender {
    [mixpanel track:@"ViewController actionBtn"];
    
    TestViewController *testVC = [[TestViewController alloc] init];
    [self presentViewController:testVC animated:NO completion:nil];
}

- (void)actionAlert:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Test OpenURL and Alert" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:NO completion:nil];
}

@end
