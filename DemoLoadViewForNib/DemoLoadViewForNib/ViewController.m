//
//  ViewController.m
//  DemoLoadViewForNib
//
//  Created by Chris Hu on 15/9/11.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "Test1ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(actionBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionBtn1 {
    Test1ViewController *test1VC = [[Test1ViewController alloc] initWithNibName:@"Test1ViewController" bundle:nil];
    [test1VC view];
    test1VC.imageViewCourse.image = [UIImage imageNamed:@"1.png"];
    test1VC.lbCourse.text = @"test 1";
    [self presentViewController:test1VC animated:YES completion:nil];
}

@end
