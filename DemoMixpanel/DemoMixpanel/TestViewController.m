//
//  TestViewController.m
//  DemoMixpanel
//
//  Created by icetime17 on 15/9/17.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import "TestViewController.h"
#import "Mixpanel.h"

@interface TestViewController ()

@end

@implementation TestViewController {

    Mixpanel *mixpanel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    mixpanel = [Mixpanel sharedInstance];
//    [mixpanel identify:@"test user id"];
    NSString *distinctId = mixpanel.distinctId;
    [mixpanel identify:distinctId];
    [mixpanel.people set:@{
                           @"name": distinctId,
                           @"age": @18,
                           @"Email": @"email_address@xxx.com"
                           }];

//    [mixpanel.people increment:@"age" by:@10];

    [mixpanel track:@"TestViewController viewDidLoad"];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 100)];
    lb.backgroundColor = [UIColor grayColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = @"TestViewController UILabel";
    [self.view addSubview:lb];

    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.width + 30.f, self.view.bounds.size.width, 60)];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 1.0f;
    [btn setTitle:@"TestViewController UIButton" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [mixpanel track:@"TestViewController viewWillAppear"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [mixpanel track:@"TestViewController viewDidAppear"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    [mixpanel track:@"TestViewController didReceiveMemoryWarning"];
}

- (void)actionBtn:(UIButton *)sender {
    mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"TestViewController actionBtn"];

    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
