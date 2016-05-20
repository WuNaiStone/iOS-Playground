//
//  ViewController.m
//  DemoUnitTest
//
//  Created by zj－db0465 on 15/11/23.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionButton1:(UIButton *)sender {
    NSLog(@"actionButton1");
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    [self presentViewController:vc2 animated:NO completion:nil];
}
@end
