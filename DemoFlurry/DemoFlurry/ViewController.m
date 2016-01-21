//
//  ViewController.m
//  DemoFlurry
//
//  Created by zj－db0465 on 16/1/21.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "Flurry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [Flurry logEvent:@"ViewController"];
    [Flurry logEvent:@"ViewController" withParameters:@{@"Method": @"viewDidLoad"}];
    [Flurry logEvent:@"viewDidLoad" timed:YES];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Goto ViewController 2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionGotoVC2:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    [btn1 setTitle:@"Set Flurry Info" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(actionSetFlurryInfo:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 2.0f;
    [self.view addSubview:btn1];
}

- (void)actionGotoVC2:(UIButton *)sender {
    [Flurry logEvent:@"Goto ViewController2"];
    [Flurry logEvent:@"ViewController" withParameters:@{@"Method": @"actionGotoVC2"}];
    [Flurry endTimedEvent:@"viewDidLoad" withParameters:nil];
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    [self presentViewController:vc2 animated:NO completion:nil];
}

- (void)actionSetFlurryInfo:(UIButton *)sender {
    [Flurry setVersion:100];
    [Flurry setUserID:@"userid"];
    [Flurry setGender:@"male"];
    [Flurry setAge:20];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
